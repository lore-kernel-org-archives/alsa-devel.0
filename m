From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 1/6] ASoC: Intel: byt-max98090: Move MICBIAS
	widget to supply of Headset Mic
Date: Mon, 23 Jun 2014 16:29:37 +0300
Message-ID: <1403530182-5400-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 115782608C7
 for <alsa-devel@alsa-project.org>; Mon, 23 Jun 2014 15:29:51 +0200 (CEST)
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
Cc: Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Kevin Strasser <kevin.strasser@intel.com>
List-Id: alsa-devel@alsa-project.org

Move "MICBIAS" as a supply widget to "Headset Mic" instead of keeping it
between input pin "IN34" and "Headset Mic".

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/intel/byt-max98090.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/intel/byt-max98090.c b/sound/soc/intel/byt-max98090.c
index 5fc98c64a3f4..a3c5f02a60fc 100644
--- a/sound/soc/intel/byt-max98090.c
+++ b/sound/soc/intel/byt-max98090.c
@@ -39,8 +39,7 @@ static const struct snd_soc_dapm_widget byt_max98090_widgets[] = {
 
 static const struct snd_soc_dapm_route byt_max98090_audio_map[] = {
 	{"IN34", NULL, "Headset Mic"},
-	{"IN34", NULL, "MICBIAS"},
-	{"MICBIAS", NULL, "Headset Mic"},
+	{"Headset Mic", NULL, "MICBIAS"},
 	{"DMICL", NULL, "Int Mic"},
 	{"Headphone", NULL, "HPL"},
 	{"Headphone", NULL, "HPR"},
-- 
2.0.0
