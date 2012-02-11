From: Leon Romanovsky <leon@leon.nu>
Subject: [PATCH v2 10/12] ASoC: alc5632: Fix Boost Volume TLVs
	used for the external microphones
Date: Sat, 11 Feb 2012 23:26:36 +0200
Message-ID: <1328995598-8788-11-git-send-email-leon@leon.nu>
References: <1328995598-8788-1-git-send-email-leon@leon.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id AE245103ABA
	for <alsa-devel@alsa-project.org>; Sat, 11 Feb 2012 22:27:09 +0100 (CET)
Received: by mail-ey0-f179.google.com with SMTP id n11so1209112eaa.38
	for <alsa-devel@alsa-project.org>; Sat, 11 Feb 2012 13:27:09 -0800 (PST)
In-Reply-To: <1328995598-8788-1-git-send-email-leon@leon.nu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: lrg@ti.com, broonie@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
Cc: Paul Fertser <fercerpav@gmail.com>, Leon Romanovsky <leon@leon.nu>
List-Id: alsa-devel@alsa-project.org

From: Paul Fertser <fercerpav@gmail.com>

This brings the TLVs in sync with the documentation and allows to properly
manipulate mic boost controls with alsamixer.

Signed-off-by: Paul Fertser <fercerpav@gmail.com>
Signed-off-by: Leon Romanovsky <leon@leon.nu>
---
 sound/soc/codecs/alc5632.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/alc5632.c b/sound/soc/codecs/alc5632.c
index 69c652c..b77f4e7 100644
--- a/sound/soc/codecs/alc5632.c
+++ b/sound/soc/codecs/alc5632.c
@@ -145,10 +145,9 @@ static const DECLARE_TLV_DB_SCALE(hp_tlv, -4650, 150, 0);
 /* -16.5db min scale, 1.5db steps, no mute */
 static const DECLARE_TLV_DB_SCALE(adc_rec_tlv, -1650, 150, 0);
 static const unsigned int boost_tlv[] = {
-	TLV_DB_RANGE_HEAD(3),
-	0, 0, TLV_DB_SCALE_ITEM(0, 0, 0),
-	1, 1, TLV_DB_SCALE_ITEM(2000, 0, 0),
-	2, 2, TLV_DB_SCALE_ITEM(3000, 0, 0),
+	TLV_DB_RANGE_HEAD(2),
+	0, 1, TLV_DB_SCALE_ITEM(0, 2000, 0),
+	1, 3, TLV_DB_SCALE_ITEM(2000, 1000, 0),
 };
 /* 0db min scale, 6 db steps, no mute */
 static const DECLARE_TLV_DB_SCALE(dig_tlv, 0, 600, 0);
@@ -193,9 +192,9 @@ static const struct snd_kcontrol_new alc5632_snd_controls[] = {
 	SOC_DOUBLE_TLV("Rec Capture Volume",
 			ALC5632_ADC_REC_GAIN, 8, 0, 31, 0, adc_rec_tlv),
 	SOC_SINGLE_TLV("Mic 1 Boost Volume",
-			ALC5632_MIC_CTRL, 10, 2, 0, boost_tlv),
+			ALC5632_MIC_CTRL, 10, 3, 0, boost_tlv),
 	SOC_SINGLE_TLV("Mic 2 Boost Volume",
-			ALC5632_MIC_CTRL, 8, 2, 0, boost_tlv),
+			ALC5632_MIC_CTRL, 8, 3, 0, boost_tlv),
 	SOC_SINGLE_TLV("DMIC Boost Volume",
 			ALC5632_DIGI_BOOST_CTRL, 0, 7, 0, dig_tlv),
 	SOC_SINGLE("DMIC En Capture Switch",
-- 
1.7.3.4
