From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH] ASoC: ad1980: fix the indentation
Date: Sun,  8 Sep 2013 17:48:03 +0800
Message-ID: <1378633683-16264-1-git-send-email-Baohua.Song@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f44.google.com (mail-pa0-f44.google.com
 [209.85.220.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 303182617AB
 for <alsa-devel@alsa-project.org>; Sun,  8 Sep 2013 11:48:17 +0200 (CEST)
Received: by mail-pa0-f44.google.com with SMTP id fz6so5100240pac.3
 for <alsa-devel@alsa-project.org>; Sun, 08 Sep 2013 02:48:16 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, device-drivers-devel@blackfin.uclinux.org, Barry Song <Baohua.Song@csr.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 sound/soc/codecs/ad1980.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/sound/soc/codecs/ad1980.c b/sound/soc/codecs/ad1980.c
index 7257a88..be5032c 100644
--- a/sound/soc/codecs/ad1980.c
+++ b/sound/soc/codecs/ad1980.c
@@ -61,39 +61,39 @@ static const struct soc_enum ad1980_cap_src =
 	SOC_ENUM_DOUBLE(AC97_REC_SEL, 8, 0, 7, ad1980_rec_sel);
 
 static const struct snd_kcontrol_new ad1980_snd_ac97_controls[] = {
-SOC_DOUBLE("Master Playback Volume", AC97_MASTER, 8, 0, 31, 1),
-SOC_SINGLE("Master Playback Switch", AC97_MASTER, 15, 1, 1),
+	SOC_DOUBLE("Master Playback Volume", AC97_MASTER, 8, 0, 31, 1),
+	SOC_SINGLE("Master Playback Switch", AC97_MASTER, 15, 1, 1),
 
-SOC_DOUBLE("Headphone Playback Volume", AC97_HEADPHONE, 8, 0, 31, 1),
-SOC_SINGLE("Headphone Playback Switch", AC97_HEADPHONE, 15, 1, 1),
+	SOC_DOUBLE("Headphone Playback Volume", AC97_HEADPHONE, 8, 0, 31, 1),
+	SOC_SINGLE("Headphone Playback Switch", AC97_HEADPHONE, 15, 1, 1),
 
-SOC_DOUBLE("PCM Playback Volume", AC97_PCM, 8, 0, 31, 1),
-SOC_SINGLE("PCM Playback Switch", AC97_PCM, 15, 1, 1),
+	SOC_DOUBLE("PCM Playback Volume", AC97_PCM, 8, 0, 31, 1),
+	SOC_SINGLE("PCM Playback Switch", AC97_PCM, 15, 1, 1),
 
-SOC_DOUBLE("PCM Capture Volume", AC97_REC_GAIN, 8, 0, 31, 0),
-SOC_SINGLE("PCM Capture Switch", AC97_REC_GAIN, 15, 1, 1),
+	SOC_DOUBLE("PCM Capture Volume", AC97_REC_GAIN, 8, 0, 31, 0),
+	SOC_SINGLE("PCM Capture Switch", AC97_REC_GAIN, 15, 1, 1),
 
-SOC_SINGLE("Mono Playback Volume", AC97_MASTER_MONO, 0, 31, 1),
-SOC_SINGLE("Mono Playback Switch", AC97_MASTER_MONO, 15, 1, 1),
+	SOC_SINGLE("Mono Playback Volume", AC97_MASTER_MONO, 0, 31, 1),
+	SOC_SINGLE("Mono Playback Switch", AC97_MASTER_MONO, 15, 1, 1),
 
-SOC_SINGLE("Phone Capture Volume", AC97_PHONE, 0, 31, 1),
-SOC_SINGLE("Phone Capture Switch", AC97_PHONE, 15, 1, 1),
+	SOC_SINGLE("Phone Capture Volume", AC97_PHONE, 0, 31, 1),
+	SOC_SINGLE("Phone Capture Switch", AC97_PHONE, 15, 1, 1),
 
-SOC_SINGLE("Mic Volume", AC97_MIC, 0, 31, 1),
-SOC_SINGLE("Mic Switch", AC97_MIC, 15, 1, 1),
+	SOC_SINGLE("Mic Volume", AC97_MIC, 0, 31, 1),
+	SOC_SINGLE("Mic Switch", AC97_MIC, 15, 1, 1),
 
-SOC_SINGLE("Stereo Mic Switch", AC97_AD_MISC, 6, 1, 0),
-SOC_DOUBLE("Line HP Swap Switch", AC97_AD_MISC, 10, 5, 1, 0),
+	SOC_SINGLE("Stereo Mic Switch", AC97_AD_MISC, 6, 1, 0),
+	SOC_DOUBLE("Line HP Swap Switch", AC97_AD_MISC, 10, 5, 1, 0),
 
-SOC_DOUBLE("Surround Playback Volume", AC97_SURROUND_MASTER, 8, 0, 31, 1),
-SOC_DOUBLE("Surround Playback Switch", AC97_SURROUND_MASTER, 15, 7, 1, 1),
+	SOC_DOUBLE("Surround Playback Volume", AC97_SURROUND_MASTER, 8, 0, 31, 1),
+	SOC_DOUBLE("Surround Playback Switch", AC97_SURROUND_MASTER, 15, 7, 1, 1),
 
-SOC_DOUBLE("Center/LFE Playback Volume", AC97_CENTER_LFE_MASTER, 8, 0, 31, 1),
-SOC_DOUBLE("Center/LFE Playback Switch", AC97_CENTER_LFE_MASTER, 15, 7, 1, 1),
+	SOC_DOUBLE("Center/LFE Playback Volume", AC97_CENTER_LFE_MASTER, 8, 0, 31, 1),
+	SOC_DOUBLE("Center/LFE Playback Switch", AC97_CENTER_LFE_MASTER, 15, 7, 1, 1),
 
-SOC_ENUM("Capture Source", ad1980_cap_src),
+	SOC_ENUM("Capture Source", ad1980_cap_src),
 
-SOC_SINGLE("Mic Boost Switch", AC97_MIC, 6, 1, 0),
+	SOC_SINGLE("Mic Boost Switch", AC97_MIC, 6, 1, 0),
 };
 
 static const struct snd_soc_dapm_widget ad1980_dapm_widgets[] = {
-- 
1.8.2.3
