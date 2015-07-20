From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH v13 0/3] ASoC: tda998x: add a codec to the HDMI
	transmitter
Date: Mon, 20 Jul 2015 15:01:10 +0200
Message-ID: <cover.1437397270.git.moinejf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
 by alsa0.perex.cz (Postfix) with ESMTP id EC2B7260A59
 for <alsa-devel@alsa-project.org>; Mon, 20 Jul 2015 15:17:12 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Andrew Jackson <Andrew.Jackson@arm.com>, Jyri Sarha <jsarha@ti.com>, Dave Airlie <airlied@gmail.com>
List-Id: alsa-devel@alsa-project.org

This patch series asks for Russell King's patch

	http://article.gmane.org/gmane.linux.ports.arm.kernel/411574
	drm/edid: add function to help find SADs

to be applayed.

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

 .../devicetree/bindings/drm/i2c/tda998x.txt        |  51 ++++++
 drivers/gpu/drm/i2c/tda998x_drv.c                  | 178 +++++++++++++++++++--
 include/sound/tda998x.h                            |  23 +++
 sound/soc/codecs/Kconfig                           |   6 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/tda998x.c                         | 132 +++++++++++++++
 6 files changed, 381 insertions(+), 11 deletions(-)
 create mode 100644 include/sound/tda998x.h
 create mode 100644 sound/soc/codecs/tda998x.c

-- 
2.1.4
