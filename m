From: Peter =?iso-8859-1?q?H=FCwe?= <PeterHuewe@gmx.de>
Subject: Re: [PATCH] soc/sh: Fix I2C dependency for SND_FSI_AK4642
Date: Tue, 15 Jun 2010 16:49:07 +0200
Message-ID: <201006151649.07554.PeterHuewe@gmx.de>
References: <201006141739.42346.PeterHuewe@gmx.de> <20100614161034.GF14604@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20100614161034.GF14604@rakim.wolfsonmicro.main>
Sender: linux-sh-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, linux-sh@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Kuninori Morimoto <morimoto.kuninori@renesas.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Am Montag 14 Juni 2010 18:10:34 schrieb Mark Brown:
> On Mon, Jun 14, 2010 at 05:39:41PM +0200, Peter Huewe wrote:
> >  	bool "FSI-AK4642 sound support"
> >  	depends on SND_SOC_SH4_FSI
> >  	select SND_SOC_AK4642
> > +	select I2C
> 
> I'd have thought a depends was more appropriate.  Arguably you want to
> depend on the SH I2C driver since the driver is useless without the
> relevant I2C controller.
> 

Thanks for pointing this out - I had also a closer look at the codecs and the 
other FSI related codec (da7210.c) depends on I2C too.

So maybe even move the dependency up to SND_SOC_SH4_FSI 
since both codecs rely on I2C?

So something like this would be more appropriate?
 config SND_SOC_SH4_FSI
 	tristate "SH4 FSI support"
+	depends on CONFIG_I2C_SH_MOBILE
 	help
 	  This option enables FSI sound support

If you think this patch sounds correct, I can create a new 'official' patch.

Peter

