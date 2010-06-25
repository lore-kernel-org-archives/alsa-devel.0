From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [RFC 0/5] ASoC multi-component support : core
Date: Fri, 25 Jun 2010 09:37:46 +0100
Message-ID: <1277455066.3123.10.camel@odin>
References: <1277407467.3100.579.camel@odin>
	<4C23CFC0.6080700@bluewatersys.com>
	(sfid-20100624_223607_408551_609C17DE)
	<661928F7-0509-4E84-A296-0949E2D76EE3@opensource.wolfsonmicro.com>
	<4C23EC65.9080601@bluewatersys.com> <4C2435DC.5080509@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id A12E21039A7
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Jun 2010 10:37:51 +0200 (CEST)
Received: by wyb40 with SMTP id 40so145596wyb.38
	for <alsa-devel@alsa-project.org>; Fri, 25 Jun 2010 01:37:49 -0700 (PDT)
In-Reply-To: <4C2435DC.5080509@bluewatersys.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ryan Mallon <ryan@bluewatersys.com>
Cc: vbarinov <vbarinov@embeddedalley.com>, alsa-devel <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, "timur.tabi@gmail.com" <timur.tabi@gmail.com>, Wan ZongShun <mcuos.com@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, jassisinghbrar <jassisinghbrar@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Sedji Gaouaou <sedji.gaouaou@atmel.com>, Cliff Cai <cliff.cai@analog.com>, "Candelaria Villareal,
	Jorge" <jorge.candelaria@ti.com>, "vaibhav.bedia" <vaibhav.bedia@ti.com>, Kuninori Morimoto <morimoto.kuninori@renesas.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-06-25 at 16:51 +1200, Ryan Mallon wrote:
> On 06/25/2010 11:38 AM, Ryan Mallon wrote:
> > On 06/25/2010 11:12 AM, Mark Brown wrote:
> >   
> >> Do you actually see sound cards appearing? The log message at boot
> >> is purely informational, cards can probe at any time.
> >>
> >> Define DEBUG at the top of soc-audio.c if the card never appears at all
> >> then look at the log messages - they will say why the card is not being
> >> instantiated.
> >>   
> >>     
> > Hmm. If I define DEBUG at the top of sound/soc/soc-core.c I get this
> > (boots fine without DEBUG, but have no sound cards):
> >   
> 
> The crash was caused because I wasn't setting codec_drv in the
> snd_soc_dai_link for the Snapper CL15 (updated patch below). I still
> have no sound cards. I get the following in dmesg:
> 
> tlv320aic23 0-001a: probe
> tlv320aic23 0-001a: codec register tlv320aic23 26
> tlv320aic23 0-001a: dai register tlv320aic23 0
> Registered DAI 'tlv320aic23.0'
> Registered codec 'tlv320aic23.26'
> i2c-core: driver [tlv320aic23] registered
> ep93xx-pcm-audio ep93xx-pcm-audio: platform register ep93xx-audio -1
> Registered platform 'ep93xx-audio'
> ep93xx-i2s ep93xx-i2s: dai register ep93xx-i2s -1
> Registered DAI 'ep93xx-i2s.-1'
> soc-audio soc-audio: CODEC tlv320aic23 not registered
> soc-audio soc-audio: Registered card 'Snapper CL15'
> ALSA device list:
>   No soundcards found.
> 
> 
> I don't understand why the tlv320 codec is not being registered. Any ideas?
> 

Since we now support N codecs, some codecs will now require an ID field
to distinguish them from others. e.g. a board with two WM8750 codecs
would have codecs at I2C addresses 0x1a and 0x1b, hence will require
each codec to be identified on the DAI link.

Can you try this patch below. From the output it looks like your
tlv320aic23 is at I2C address 26. 


diff --git a/sound/soc/ep93xx/snappercl15.c b/sound/soc/ep93xx/snappercl15.c
index aeb822d..72b7913 100644
--- a/sound/soc/ep93xx/snappercl15.c
+++ b/sound/soc/ep93xx/snappercl15.c
@@ -94,6 +94,7 @@ static struct snd_soc_dai_link snappercl15_dai = {
        .cpu_dai_drv    = &ep93xx_i2s_dai,
        .codec_dai_drv  = &tlv320aic23_dai,
        .codec_drv      = &soc_codec_dev_tlv320aic23,
+       .codec_id       = 26,
        .platform_drv   = &ep93xx_soc_platform,
        .init           = snappercl15_tlv320aic23_init,
        .ops            = &snappercl15_ops,


> ~Ryan
> 
> ---
> Fix build errors and warnings for ep93xx/snapper cl15 asoc
> multi-component support
> 
> Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
> ---

Thanks. Applied.

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
