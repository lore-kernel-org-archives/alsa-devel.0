From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v4 2/5] ASoC: Move standard
	kcontrol	helpers to the component level
Date: Mon, 12 May 2014 15:09:09 +0100
Message-ID: <20140512140909.GH25203@opensource.wolfsonmicro.com>
References: <CAOMZO5Cb4Q80ux1R9EOcsaCPFsmxz3K5Obt02or=s0RitmPMKw@mail.gmail.com>
 <536CFBE7.3070805@metafoo.de> <20140510050747.GI2870@dragon>
 <536DCF6F.9020507@metafoo.de> <536DD108.2090607@metafoo.de>
 <20140510083131.GL2870@dragon> <536DE548.9050008@metafoo.de>
 <20140510091209.GM2870@dragon>
 <20140512104204.GF25203@opensource.wolfsonmicro.com>
 <20140512110304.GB12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3A491261B01
 for <alsa-devel@alsa-project.org>; Mon, 12 May 2014 16:09:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20140512110304.GB12304@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <festevam@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, May 12, 2014 at 12:03:04PM +0100, Mark Brown wrote:
> On Mon, May 12, 2014 at 11:42:04AM +0100, Charles Keepax wrote:
> 
> > > Yea, you're right.  When the error message shows up, _regmap_read()
> > > returns -EBUSY for reg WM8962_CLASS_D_CONTROL_1.  But how do I find out
> > > why the reg is not in the cache?
> 
> > From what I can see it doesn't look like this register should be
> > volatile. I am checking with the hardware guys here, incase I am
> > missing something, but otherwise I will wing out a patch to make
> > it non-volatile.
> 
> IIRC at least one of the bits in the register also appears in another
> register.  They aren't volatile but the cache could get confused unless
> something is open coded to keep the two cached registers in sync.

Yup, just heard back from the hardware guys, this is exactly it.
The DAC_MUTE bit in registers R5 and R49 both control the same
thing. So if you change one it changes the other.

Looks like either something will need to be added to keep the two
registers in sync, or some manual caching of the speaker switch
until the device is enabled.

Thanks,
Charles
