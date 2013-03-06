From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: Re: davici-mcasp: "tx-num-evt" confusion with number
 of serializers
Date: Wed, 6 Mar 2013 10:51:05 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ED3D3B4@DBDE01.ent.ti.com>
References: <1631475.f7GPhLiLxV@ganymedes> <8652573.mejjkM8Cr8@ganymedes>
 <512F241F.9080305@topic.nl> <2559045.s5gCxPtNFX@ganymedes>
 <512F5959.9030004@gmail.com> <512F5B1C.4020508@gmail.com>
 <20130301100820.GU25302@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 899A126538A
 for <alsa-devel@alsa-project.org>; Wed,  6 Mar 2013 11:51:14 +0100 (CET)
In-Reply-To: <20130301100820.GU25302@opensource.wolfsonmicro.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Daniel Mack <zonque@gmail.com>
Cc: Mike Looijmans <mike.looijmans@topic.nl>, Grant Likely <grant.likely@secretlab.ca>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Michal Bachraty <michal.bachraty@streamunlimited.com>, "Hebbar,
 Gururaja" <gururaja.hebbar@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On Fri, Mar 01, 2013 at 15:38:27, Mark Brown wrote:
> On Thu, Feb 28, 2013 at 02:26:52PM +0100, Daniel Mack wrote:
> > On 28.02.2013 14:19, Daniel Mack wrote:
> 
> > > Be careful with such changes. In general, DT bindings are forever in
> > > general, because you can't update all the users out there, and so every
> > > binding that has ever existed has to be supported in the future, for
> > > backwards compatibility.
> 
> > > In this case, we might make an exception, given that for AM33xx, the
> > > necessary DMA bits are still not missing, and Davinci is not yet fully
> > > ported to DT either. So nobody really uses the driver on this platforms.
> 
> > Sorry, let me rephrase that last paragraph:
> 
> > In this case, we might make an exception, given that for AM33xx, the
> > necessary DMA bits are still missing, and Davinci is not yet fully
> > ported to DT either. So supposedly nobody really uses the driver on this
> > platforms via DT.
> 
> Sounds plausible, though without having seen the actual change I can't
> comment for certain.
> 

Even I have found this field name to be a bit confusing. As per my understanding,
tx/rx_num_evt is the trigger-level for generating the DMA request. Taking the case
of Tx, a DMA event is generated when the FIFO has space of x words where x < 64.
At the same time, y words are transferred from the FIFO to the McASP, where y must
be the number of active serializers. To ensure that the FIFO always has enough
words to service all the active serializers, the driver needs to ensure that x is
a non-zero integral multiple of the number of active serializers.

Assuming tx-num-evt is set to 1 and 1 serializer in I2S mode is active (which is the
case before multi-serializer support), McASP is programmed to generate a DMA event
when there's a space for 1*1 = 1 word in the FIFO. This minimizes the chance of
under-runs but puts keeps the DMA controller active. At the same time, the DMA
controller is programmed to transfer tx-num-evt ie. 1 sample (L or R). 
This is in sync with what the McASP expects.

With tx-num-evt set to 1 and 4 serializers in I2S mode, MCASP is programmed to
generate a DMA event when there's a space for 1*4 = 4 words in the FIFO. The DMA
controller is programmed with Acnt = 2 (data_type) and Bcnt = tx-num-evt = 1.
So, every DMA event ends up transferring only 2 samples whereas the data is being
drained out @ 4 words! So, when you add-in multi-serializer support, the current
implementation results in a mismatch between the DMA programming and McASP
leading to DMA errors.

To fix the above issue, instead of passing around the number of active serializers,
like you did in your other patch, I would suggest making sure dma_params->fifo_level
is programmed to (tx/rx_num_evt * active serializers). Do you see any issues with
this approach?

Regards,
Vaibhav
