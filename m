From: Leon Romanovsky <leon@leon.nu>
Subject: [PATCH] ASoC: alc5632: rename volume/switch contols
	for master and speaker volumes.
Date: Sun, 13 Nov 2011 21:53:13 +0200
Message-ID: <1321213993-27920-1-git-send-email-leon@leon.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 83C3D24412
	for <alsa-devel@alsa-project.org>; Sun, 13 Nov 2011 20:53:27 +0100 (CET)
Received: by bkat8 with SMTP id t8so5294984bka.38
	for <alsa-devel@alsa-project.org>; Sun, 13 Nov 2011 11:53:27 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@ti.com
Cc: alsa-devel@alsa-project.org, Andrey Danin <danindrey@mail.ru>, Leon Romanovsky <leon@leon.nu>
List-Id: alsa-devel@alsa-project.org

From: Andrey Danin <danindrey@mail.ru>


Signed-off-by: Andrey Danin <danindrey@mail.ru>
Signed-off-by: Leon Romanovsky <leon@leon.nu>
---
 sound/soc/codecs/alc5632.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/alc5632.c b/sound/soc/codecs/alc5632.c
index 8a3bf71..71c8a8d 100644
--- a/sound/soc/codecs/alc5632.c
+++ b/sound/soc/codecs/alc5632.c
@@ -144,10 +144,10 @@ static const DECLARE_TLV_DB_SCALE(vdac_tlv, -3525, 075, 0);
 static const struct snd_kcontrol_new alc5632_vol_snd_controls[] = {
 	/* left starts at bit 8, right at bit 0 */
 	/* 31 steps (5 bit), -46.5db scale */
-	SOC_DOUBLE_TLV("Line Playback Volume",
+	SOC_DOUBLE_TLV("Speaker Playback Volume",
 			ALC5632_SPK_OUT_VOL, 8, 0, 31, 1, hp_tlv),
 	/* bit 15 mutes left, bit 7 right */
-	SOC_DOUBLE("Line Playback Switch",
+	SOC_DOUBLE("Speaker Playback Switch",
 			ALC5632_SPK_OUT_VOL, 15, 7, 1, 1),
 	SOC_DOUBLE_TLV("Headphone Playback Volume",
 			ALC5632_HP_OUT_VOL, 8, 0, 31, 1, hp_tlv),
@@ -166,9 +166,9 @@ static const struct snd_kcontrol_new alc5632_snd_controls[] = {
 			ALC5632_PHONE_IN_VOL, 8, 31, 1, vol_tlv),
 	SOC_DOUBLE_TLV("LineIn Capture Volume",
 			ALC5632_LINE_IN_VOL, 8, 0, 31, 1, vol_tlv),
-	SOC_DOUBLE_TLV("Stereo DAC Playback Volume",
+	SOC_DOUBLE_TLV("Master Playback Volume",
 			ALC5632_STEREO_DAC_IN_VOL, 8, 0, 63, 1, vdac_tlv),
-	SOC_DOUBLE("Stereo DAC Playback Switch",
+	SOC_DOUBLE("Master Playback Switch",
 			ALC5632_STEREO_DAC_IN_VOL, 15, 7, 1, 1),
 	SOC_SINGLE_TLV("Mic1 Capture Volume",
 			ALC5632_MIC_VOL, 8, 31, 1, vol_tlv),
-- 
1.7.4.4
