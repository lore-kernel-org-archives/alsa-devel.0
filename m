From: Sebastien LEDUC <sebastien.leduc@st.com>
Subject: Re: question on snd_soc_dai_link_event
Date: Fri, 18 Jan 2013 15:07:29 +0100
Message-ID: <9C1683ABA24673439FCD019782C9F4BBE7D4E072A2@SAFEX1MAIL1.st.com>
References: <9C1683ABA24673439FCD019782C9F4BBDA2A1C1582@SAFEX1MAIL1.st.com>
 <20121026170142.GZ18814@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog104.obsmtp.com (eu1sys200aog104.obsmtp.com
 [207.126.144.117])
 by alsa0.perex.cz (Postfix) with ESMTP id 200F22615DD
 for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2013 15:07:50 +0100 (CET)
In-Reply-To: <20121026170142.GZ18814@opensource.wolfsonmicro.com>
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
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,
Coming back on this topic:
We are trying to use the codec <-> codec approach to model our 
on-SoC DSP. 
So in our case it would be quite important that the full sequence
of ops is called, so that we are not dependent on which ops the codec
we use is relying on.

I am even thinking that it could be worth creating an internal PCM 
for the  dai link that has the params field, and to call the standard
soc functions (soc_pcm_open, ...) on it from the dai_link widget DAPM 
callback to start / stop the PCM.

Any feedback?

Thanks
Regards
Sebastien

> -----Original Message-----
> From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
> Sent: Friday, October 26, 2012 7:02 PM
> To: Sebastien LEDUC
> Cc: alsa-devel@alsa-project.org; Liam Girdwood (lrg@ti.com)
> Subject: Re: question on snd_soc_dai_link_event
> 
> On Fri, Oct 26, 2012 at 01:58:54PM +0200, Sebastien LEDUC wrote:
> 
> Fix your mailer to word wrap within paragraphs, it makes your mails hard
> to read if you don't do this.  I've reflowed for legibility.
> 
> > I wonder why it does not call the full hw_params / prepare / trigger
> > sequence on both dai drivers to start the 2 DAIs.
> 
> None of the drivers that use this actually have any of those calls so I
> didn't bother.  Especially in the case of trigger it's unlikely that an
> off-SoC device without DMA would need this, though of course it could
> happen.
