From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH 2/2] ASoC: pcm1792a: Add controls for output
	invert and rolloff switch
Date: Mon, 28 Jul 2014 14:26:49 +0200
Message-ID: <1406550409-13798-2-git-send-email-michael@amarulasolutions.com>
References: <1406550409-13798-1-git-send-email-michael@amarulasolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f177.google.com (mail-wi0-f177.google.com
 [209.85.212.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 27F89261740
 for <alsa-devel@alsa-project.org>; Mon, 28 Jul 2014 14:26:54 +0200 (CEST)
Received: by mail-wi0-f177.google.com with SMTP id ho1so4251906wib.4
 for <alsa-devel@alsa-project.org>; Mon, 28 Jul 2014 05:26:53 -0700 (PDT)
In-Reply-To: <1406550409-13798-1-git-send-email-michael@amarulasolutions.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 sound/soc/codecs/pcm1792a.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/pcm1792a.c b/sound/soc/codecs/pcm1792a.c
index 3a80ba4..8f6a602 100644
--- a/sound/soc/codecs/pcm1792a.c
+++ b/sound/soc/codecs/pcm1792a.c
@@ -36,6 +36,7 @@
 #define PCM1792A_DAC_VOL_LEFT	0x10
 #define PCM1792A_DAC_VOL_RIGHT	0x11
 #define PCM1792A_FMT_CONTROL	0x12
+#define PCM1792A_MODE_CONTROL	0x13
 #define PCM1792A_SOFT_MUTE	PCM1792A_FMT_CONTROL
 
 #define PCM1792A_FMT_MASK	0x70
@@ -164,6 +165,8 @@ static const struct snd_kcontrol_new pcm1792a_controls[] = {
 	SOC_DOUBLE_R_RANGE_TLV("DAC Playback Volume", PCM1792A_DAC_VOL_LEFT,
 			 PCM1792A_DAC_VOL_RIGHT, 0, 0xf, 0xff, 0,
 			 pcm1792a_dac_tlv),
+	SOC_SINGLE("DAC Invert output Switch", PCM1792A_MODE_CONTROL, 7, 1, 0),
+	SOC_SINGLE("DAC Rolloff Filter Switch", PCM1792A_MODE_CONTROL, 1, 1, 0),
 };
 
 static const struct snd_soc_dapm_widget pcm1792a_dapm_widgets[] = {
-- 
1.8.1.2
