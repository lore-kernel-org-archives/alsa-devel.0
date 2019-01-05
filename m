From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 09/21] ASoC: cs4271: fix boolean assignments
Date: Fri,  4 Jan 2019 20:02:37 -0600
Message-ID: <20190105020249.8639-10-pierre-louis.bossart@linux.intel.com>
References: <20190105020249.8639-1-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190105020249.8639-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, liam.r.girdwood@linux.intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Reported by Coccinelle:
sound/soc/codecs/cs4271.c:226:2-16: WARNING: Assignment of bool to 0/1
sound/soc/codecs/cs4271.c:229:2-16: WARNING: Assignment of bool to 0/1

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/cs4271.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
index 849fdb2cb260..1104830edaf8 100644
--- a/sound/soc/codecs/cs4271.c
+++ b/sound/soc/codecs/cs4271.c
@@ -223,10 +223,10 @@ static int cs4271_set_dai_fmt(struct snd_soc_dai *codec_dai,
 
 	switch (format & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBS_CFS:
-		cs4271->master = 0;
+		cs4271->master = false;
 		break;
 	case SND_SOC_DAIFMT_CBM_CFM:
-		cs4271->master = 1;
+		cs4271->master = true;
 		val |= CS4271_MODE1_MASTER;
 		break;
 	default:
-- 
2.17.1
