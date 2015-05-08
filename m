From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH v12 0/6] ASoC: tda998x: add a codec to the HDMI	transmitter
Date: Fri, 8 May 2015 13:18:36 +0200
Message-ID: <cover.1431083916.git.moinejf@free.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Dave Airlie <airlied@gmail.com>, Andrew Jackson <Andrew.Jackson@arm.com>, Jyri Sarha <jsarha@ti.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Based on 4.1-rc1
As Russell King's DRM ELD helper is not yet in any repository,
it is included here with a little patch.

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

Jean-Francois Moine (6):
  drm/edid: add function to help find SADs
  sound/core: add DRM ELD helper
  sound/core: remove the trace from the DRM ELD helper
  drm/i2c: tda998x: Add support of a DT graph of ports
  drm/i2c: tda998x: Change drvdata for audio extension
  ASoC: tda998x: add a codec to the HDMI transmitter

 .../devicetree/bindings/drm/i2c/tda998x.txt        |  51 ++++++
 drivers/gpu/drm/i2c/tda998x_drv.c                  | 178 +++++++++++++++++++--
 include/drm/drm_edid.h                             |  19 +++
 include/sound/pcm_drm_eld.h                        |   6 +
 include/sound/tda998x.h                            |  23 +++
 sound/core/Kconfig                                 |   3 +
 sound/core/Makefile                                |   1 +
 sound/core/pcm_drm_eld.c                           |  91 +++++++++++
 sound/soc/codecs/Kconfig                           |   6 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/tda998x.c                         | 132 +++++++++++++++
 11 files changed, 501 insertions(+), 11 deletions(-)
 create mode 100644 include/sound/pcm_drm_eld.h
 create mode 100644 include/sound/tda998x.h
 create mode 100644 sound/core/pcm_drm_eld.c
 create mode 100644 sound/soc/codecs/tda998x.c

-- 
2.1.4
