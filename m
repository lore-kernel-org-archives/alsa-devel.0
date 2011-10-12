From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: [alsa-devel] [PATCH 6/9] ASoC: da7210: bugfix for head phone
 volume control
Date: Wed, 12 Oct 2011 20:35:34 +0530
Message-ID: <1318431934.12107.421.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, lrg@ti.com, alsa-devel <alsa-devel@alsa-project.org>
Cc: David Dajun Chen <david.chen@diasemi.com>, kuninori.morimoto.gx@renesas.com, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

This patch takes care of reserved bits of headphone volume
register by using correct volume range.

Tested on Samsung SMDK6410 board with DA7210 evaluation board.

Signed-off-by: Ashish Chavan <ashish.chavan@kpitcummins.com>
Signed-off-by: David Dajun Chen <dchen@diasemi.com>
---
 sound/soc/codecs/da7210.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
index 60f403b..eb12c82 100644
--- a/sound/soc/codecs/da7210.c
+++ b/sound/soc/codecs/da7210.c
@@ -196,12 +196,15 @@
  * mute		: 0x10
  * reserved	: 0x00 - 0x0F
  *
- * ** FIXME **
- *
  * Reserved area are considered as "mute".
- * -> min = -79.5 dB
  */
-static const DECLARE_TLV_DB_SCALE(hp_out_tlv, -7950, 150, 1);
+static const unsigned int hp_out_tlv[] = {
+	TLV_DB_RANGE_HEAD(2),
+	0x0, 0x10, TLV_DB_SCALE_ITEM(TLV_DB_GAIN_MUTE, 0, 1),
+	/* -54 dB to +15 dB */
+	0x11, 0x3f, TLV_DB_SCALE_ITEM(-5400, 150, 0),
+};
+
 static const DECLARE_TLV_DB_SCALE(dac_gain_tlv, -7725, 75, 0);
 static const DECLARE_TLV_DB_SCALE(mic_vol_tlv, -600, 600, 0);
 static const DECLARE_TLV_DB_SCALE(aux2_vol_tlv, -600, 600, 0);
-- 
1.7.1
