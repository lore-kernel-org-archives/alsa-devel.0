From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] ASoC: Intel: byt-rt5640: Enable headset mic
	bias voltage
Date: Mon,  9 Jun 2014 14:39:06 +0300
Message-ID: <1402313946-12398-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id DF61B2625D7
 for <alsa-devel@alsa-project.org>; Mon,  9 Jun 2014 13:39:12 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Connect "Headset Mic" to "MICBIAS1" supply widget of RT5640 in order to
enable bias voltage for headset microphones.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/intel/byt-rt5640.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/byt-rt5640.c b/sound/soc/intel/byt-rt5640.c
index 53d160d39972..234a58de3c53 100644
--- a/sound/soc/intel/byt-rt5640.c
+++ b/sound/soc/intel/byt-rt5640.c
@@ -34,6 +34,7 @@ static const struct snd_soc_dapm_widget byt_rt5640_widgets[] = {
 };
 
 static const struct snd_soc_dapm_route byt_rt5640_audio_map[] = {
+	{"Headset Mic", NULL, "MICBIAS1"},
 	{"IN2P", NULL, "Headset Mic"},
 	{"IN2N", NULL, "Headset Mic"},
 	{"DMIC1", NULL, "Internal Mic"},
-- 
2.0.0
