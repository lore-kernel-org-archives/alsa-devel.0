From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: ASoC and a codec that can't be controlled
Date: Wed, 30 May 2007 13:20:51 +0100
Message-ID: <1180527651.29590.36.camel@a10072.wolfsonmicro.main>
References: <46531097.5040600@freescale.com>
	<1179934677.12071.30.camel@a10072.wolfsonmicro.main>
	<46574453.10808@freescale.com>
	<1180354247.5816.30.camel@a10072.wolfsonmicro.main>
	<465C7551.1010404@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id 249AC24466
	for <alsa-devel@alsa-project.org>;
	Wed, 30 May 2007 14:20:53 +0200 (CEST)
In-Reply-To: <465C7551.1010404@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2007-05-29 at 13:47 -0500, Timur Tabi wrote:
> Liam Girdwood wrote:
> > On Fri, 2007-05-25 at 15:17 -0500, Timur Tabi wrote:
> >> Liam Girdwood wrote:
> >>
> >>> These are used for setting up the dynamic audio power management and
> >>> won't be needed in stand alone mode.
> >> So if I don't care about power management, can I completely ignore anything with "dapm" in it?
> > 
> > Yes.
> > 
> >> Also, do I need a codec driver at all, even if I can't control the codec?  That is, can I 
> >> do stuff like this:
> >>
> >> static struct snd_soc_device mysoc_snd_devdata = {
> >> 	.machine = &snd_soc_machine_mysoc,
> >> 	.platform = &mysoc_soc_platform,
> >> };
> >>
> >> static struct snd_soc_dai_link mpc8610hpcd_dai = {
> >> 	.name = "CS4270",
> >> 	.stream_name = "CS4270",
> >> 	.cpu_dai = &mysoc_i2s_dai,
> >> 	.init = mpc8610hpcd_machine_init,
> >> 	.ops = &mpc8610hpcd_ops,
> >> };
> > 
> > Yes, although my feeling is that a codec "driver" would still be needed
> > to define the capabilities of your codec within the audio subsystem.
> 
> Another question:
> 
> Why do I need to specify the codec DAI in two different structures?
> 
> eti_b1_wm8731.c:
> 
> static struct snd_soc_dai_link eti_b1_dai = {
> 	.name = "WM8731",
> 	.stream_name = "WM8731",
> 	.cpu_dai = &at91_i2s_dai[1],
> 	.codec_dai = &wm8731_dai,	<----
> 	.init = eti_b1_wm8731_init,
> 	.ops = &eti_b1_ops,
> };
> 
> wm8731.c:
> 
> static int wm8731_init(struct snd_soc_device *socdev)
> {
> 	struct snd_soc_codec *codec = socdev->codec;
> ...
> 	int reg, ret = 0;
> 
> 	codec->dai = &wm8731_dai;	<-----
> 

Looks like some naming confusion on my part here, so his probably needs
a little refactoring in the codec struct.  

The codec struct contains a pointer to _all_ the digital audio
interfaces it supports (e.g. some codecs support more than 1 DAI),
whilst the link struct contains a mapping between codec interface n and
SoC interface n. In this example the WM8731 only has 1 DAI, so it does
look like duplication.

I'll refactor this in a future patch.

Liam
