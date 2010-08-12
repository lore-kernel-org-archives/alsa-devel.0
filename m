From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 09/14] ASoC: multi-component - RMI Alchemy
	AU1x Platform
Date: Thu, 12 Aug 2010 14:15:10 +0100
Message-ID: <1281618910.3067.44.camel@odin>
References: <1281516393-6060-1-git-send-email-lrg@slimlogic.co.uk>
	<1281516393-6060-10-git-send-email-lrg@slimlogic.co.uk>
	<20100811183420.GA29413@wormhole>  <1281560839.3080.204.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 78B36103801
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Aug 2010 15:15:15 +0200 (CEST)
Received: by wyb42 with SMTP id 42so1367576wyb.38
	for <alsa-devel@alsa-project.org>; Thu, 12 Aug 2010 06:15:15 -0700 (PDT)
In-Reply-To: <1281560839.3080.204.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Manuel Lauss <mano@roarinelk.homelinux.net>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-08-11 at 22:07 +0100, Liam Girdwood wrote:
> On Wed, 2010-08-11 at 20:34 +0200, Manuel Lauss wrote:
> > On Wed, Aug 11, 2010 at 09:46:28AM +0100, Liam Girdwood wrote:
> > > Update the RMI Alchemy platform and machines to new multi-component model.
> > > 
> > > This patch changes the machine drivers for multi-component as follows :-
> > > 
> > >  o Removed socdev
> > >  o Each DAI link entry now contains platform and codec fields.
> > >  o DAI link init() now passed snd_soc_pcm_runtime instread of snd_soc_codec.
> > > 
> > > This patch also changes the DAI and platform DAM drivers as follows :-
> > > 
> > >  o Each platform DAI and platform DMA driver is a kernel device and can
> > >    have platform data.
> > >  o DAI and Platform DMA drivers have private data accessors.
> > > 
> > > Other notable changes required for multi-component support:-
> > > 
> > >  o Removed empty remove() functions
> > > 
> > > CC: Manuel Lauss <mano@roarinelk.homelinux.net>
> > > Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
> > 
> > > @@ -80,8 +75,10 @@ static struct snd_soc_ops db1200_i2s_wm8731_ops = {
> > >  static struct snd_soc_dai_link db1200_i2s_dai = {
> > >  	.name		= "WM8731",
> > >  	.stream_name	= "WM8731 PCM",
> > > -	.cpu_dai	= &au1xpsc_i2s_dai,
> > > -	.codec_dai	= &wm8731_dai,
> > > +	.cpu_dai_name	= &au1xpsc_i2s_dai,
> > > +	.codec_dai_name	= &wm8731_dai,
> > > +	.platform_name	= &au1xpsc_soc_platform,
> > > +	.codec_name	= &soc_codec_dev_wm8731,
> > 
> > That doesn't compile, however I have no idea what to set it to.
> > Is there documentation how component matching is done?
> 
> Looks like I missed that one.
> 
> The components now match on the dev_name().id (unless id == -1, then it
> is dropped). Codec DAI is matched on codec DAI name.
> 
> e.g should be :-
> 
> +	.cpu_dai_name	= "au1xpsc-dai.0",
> +	.codec_dai_name	= "wm8731-hifi",
> +	.platform_name	= "au1xpsc-pcm-audio"
> +	.codec_name	= "wm8731-codec.0-0026",
> 

Btw, now fixed this up in git.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
