From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH v9 0/4] ASoC: tda998x: add a codec to the HDMI transmitter
Date: Thu, 8 Jan 2015 16:53:04 +0200
Message-ID: <54AE99D0.1050205@ti.com>
References: <cover.1420628786.git.moinejf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1420628786.git.moinejf@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Francois Moine <moinejf@free.fr>, Mark Brown <broonie@kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Dave Airlie <airlied@gmail.com>, Andrew Jackson <Andrew.Jackson@arm.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


On 01/07/2015 01:06 PM, Jean-Francois Moine wrote:
> Based on 3.19.0-rc3.
>
> v9:
> 	- back to a TDA998x specific CODEC

I did not mean that you could not make your shot at generic codec. It 
will just need more work before it is generic enough for other HDMI 
encoders to fully utilize it.

BTW, the HDMI codec is now completely unused, since my OMAP4+ HDMI audio 
patches were merged (it uses dummy codec) and my BBB HDMI audio patches 
were never merged.

But then again if you'll rather make a tda998x specific codec for now, I 
am fine with that. Let's see later when(/if) I get my generic HDMI codec 
ready - I'll eventually need something for SiI9022 - if it makes sense 
to start using it with tda998x too.

Best regards,
Jyri

> 	- more comments
> 	- change magic values to constants
> v8:
> 	- change some comments about the patches
> v7:
> 	- remove the change of the K predivider (Jyri Sarha)
> 	- add S24_3LE and S32_LE as possible audio formats (Jyri Sarha)
> 	- don't move the struct priv2 definition and use the
> 	  slave encoder private data as the device private data
> 	  (Russell King)
> 	- remove the useless request_module (Russell King/Mark Brown)
> 	- don't lock the HDMI module (Russell King)
> 	- use platform_device_unregister to remove the codec
> 	  (Russell King)
> v6:
> 	- extend the HDMI CODEC instead of using a specific CODEC
> v5:
> 	- use the TDA998x private data instead of a specific area
> 	  for the CODEC interface
> 	- the CODEC is TDA998x specific (Mark Brown)
> v4:
> 	- remove all the TDA998x specific stuff from the CODEC
> 	- move the EDID scan from the CODEC to the TDA998x
> 	- move the CODEC to sound/soc (Mark Brown)
> 	- update the audio_sample_rate from the EDID (Andrew Jackson)
> v3: fix bad rate (Andrew Jackson)int drm_edid_to_sad(struct edid *edid, struct cea_sad **sads);

> v2: check double stream start (Mark Brown)
>
> Jean-Francois Moine (4):
>    drm/i2c: tda998x: Add DT support for audio
>    drm/i2c: tda998x: Change drvdata for audio extension
>    ASoC: tda998x: add a codec to the HDMI transmitter
>    drm/i2c: tda998x: set cts_n according to the sample width
>
>   .../devicetree/bindings/drm/i2c/tda998x.txt        |  18 ++
>   drivers/gpu/drm/i2c/Kconfig                        |   1 +
>   drivers/gpu/drm/i2c/tda998x_drv.c                  | 213 +++++++++++++++++++--
>   include/sound/tda998x.h                            |  23 +++
>   sound/soc/codecs/Kconfig                           |   4 +
>   sound/soc/codecs/Makefile                          |   2 +
>   sound/soc/codecs/tda998x.c                         | 175 +++++++++++++++++
>   7 files changed, 424 insertions(+), 12 deletions(-)
>   create mode 100644 include/sound/tda998x.h
>   create mode 100644 sound/soc/codecs/tda998x.c
>
