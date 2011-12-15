From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Rename rt562[1|2]_vol_snd_controls to
 alc562[1|2]_vol_snd_controls
Date: Thu, 15 Dec 2011 11:57:57 +0800
Message-ID: <1323921477.30892.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 353091038F4
	for <alsa-devel@alsa-project.org>; Thu, 15 Dec 2011 04:58:11 +0100 (CET)
Received: by yenm9 with SMTP id m9so1231836yen.38
	for <alsa-devel@alsa-project.org>; Wed, 14 Dec 2011 19:58:09 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Arnaud Patard <arnaud.patard@rtp-net.org>
List-Id: alsa-devel@alsa-project.org

The module desciption says this is ASoC alc5621/2/3 driver.
Make the naming consistent with the reset of the code.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/alc5623.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/alc5623.c b/sound/soc/codecs/alc5623.c
index da97f02..6a9b621 100644
--- a/sound/soc/codecs/alc5623.c
+++ b/sound/soc/codecs/alc5623.c
@@ -99,7 +99,7 @@ static const unsigned int boost_tlv[] = {
 };
 static const DECLARE_TLV_DB_SCALE(dig_tlv, 0, 600, 0);
 
-static const struct snd_kcontrol_new rt5621_vol_snd_controls[] = {
+static const struct snd_kcontrol_new alc5621_vol_snd_controls[] = {
 	SOC_DOUBLE_TLV("Speaker Playback Volume",
 			ALC5623_SPK_OUT_VOL, 8, 0, 31, 1, hp_tlv),
 	SOC_DOUBLE("Speaker Playback Switch",
@@ -110,7 +110,7 @@ static const struct snd_kcontrol_new rt5621_vol_snd_controls[] = {
 			ALC5623_HP_OUT_VOL, 15, 7, 1, 1),
 };
 
-static const struct snd_kcontrol_new rt5622_vol_snd_controls[] = {
+static const struct snd_kcontrol_new alc5622_vol_snd_controls[] = {
 	SOC_DOUBLE_TLV("Speaker Playback Volume",
 			ALC5623_SPK_OUT_VOL, 8, 0, 31, 1, hp_tlv),
 	SOC_DOUBLE("Speaker Playback Switch",
@@ -925,12 +925,12 @@ static int alc5623_probe(struct snd_soc_codec *codec)
 
 	switch (alc5623->id) {
 	case 0x21:
-		snd_soc_add_controls(codec, rt5621_vol_snd_controls,
-			ARRAY_SIZE(rt5621_vol_snd_controls));
+		snd_soc_add_controls(codec, alc5621_vol_snd_controls,
+			ARRAY_SIZE(alc5621_vol_snd_controls));
 		break;
 	case 0x22:
-		snd_soc_add_controls(codec, rt5622_vol_snd_controls,
-			ARRAY_SIZE(rt5622_vol_snd_controls));
+		snd_soc_add_controls(codec, alc5622_vol_snd_controls,
+			ARRAY_SIZE(alc5622_vol_snd_controls));
 		break;
 	case 0x23:
 		snd_soc_add_controls(codec, alc5623_vol_snd_controls,
-- 
1.7.5.4
