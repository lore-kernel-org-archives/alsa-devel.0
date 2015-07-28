From: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Subject: [PATCH v14 0/3] ASoC: tda998x: add a codec to the HDMI transmitter
Date: Tue, 28 Jul 2015 11:45:50 +0200
Message-ID: <cover.1438076750.git.moinejf@free.fr>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Jackson <Andrew.Jackson-5wv7dgnIgG8@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

This patch series asks for Russell King's patch

	http://article.gmane.org/gmane.linux.ports.arm.kernel/411574
	"drm/edid: add function to help find SADs"

to be applied.

v14: (Mark Brown)
	- protect the CODEC from edid change
	- change some structure names
	- remove the static pointer to the HDMI driver functions
	- get the ELD from a pointer in the device private area
	- prevent audio from streaming many sources at the same time
	- build the CODEC DAI's from two different samples
	- use EXPORT_SYMBOL_GPL for exported functions
	- simplify exchanges between audio and video by using
		common data in the device private area
v13:
	- rebase on 4.2.0-rc3
	- remove Russell's patches
v12:
	- use Russell King's DRM ELD helper (Mark Brown)
v11:
	- reduce the patch series to adding the tda998x codec only
v10:
	- add the generic dt-card
	- define the audio ports from a DT graph of ports (Russell King)
	- reuse HDMI constants (Andrew Jackson - Jyri Sarha)
	- alloc rate_constraints in codec (Jyri Sarha)
	- fix bad number of channels (Jyri Sarha)
	- correct codec generation from config (Russell King - Jyri Sarha)
	- no module init/exit (Russell King)
v9:
	- back to a TDA998x specific CODEC
	- more comments
	- change magic values to constants
v8:
	- change some comments about the patches
v7:
	- remove the change of the K predivider (Jyri Sarha)
	- add S24_3LE and S32_LE as possible audio formats (Jyri Sarha)
	- don't move the struct priv2 definition and use the
	  slave encoder private data as the device private data
	  (Russell King)
	- remove the useless request_module (Russell King/Mark Brown)
	- don't lock the HDMI module (Russell King)
	- use platform_device_unregister to remove the codec
	  (Russell King)
v6:
	- extend the HDMI CODEC instead of using a specific CODEC
v5:
	- use the TDA998x private data instead of a specific area
	  for the CODEC interface
	- the CODEC is TDA998x specific (Mark Brown)
v4:
	- remove all the TDA998x specific stuff from the CODEC
	- move the EDID scan from the CODEC to the TDA998x
	- move the CODEC to sound/soc (Mark Brown)
	- update the audio_sample_rate from the EDID (Andrew Jackson)
v3: fix bad rate (Andrew Jackson)
v2: check double stream start (Mark Brown)

Jean-Francois Moine (3):
  drm/i2c: tda998x: Add support of a DT graph of ports
  drm/i2c: tda998x: Change drvdata for audio extension
  ASoC: tda998x: add a codec to the HDMI transmitter

 .../devicetree/bindings/drm/i2c/tda998x.txt        |  51 +++++++
 drivers/gpu/drm/i2c/tda998x_drv.c                  | 163 +++++++++++++++++++--
 include/sound/tda998x.h                            |  18 +++
 sound/soc/codecs/Kconfig                           |   6 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/tda998x.c                         | 141 ++++++++++++++++++
 6 files changed, 370 insertions(+), 11 deletions(-)
 create mode 100644 include/sound/tda998x.h
 create mode 100644 sound/soc/codecs/tda998x.c

-- 
2.4.6

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
