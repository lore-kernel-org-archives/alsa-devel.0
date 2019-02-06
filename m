From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH] ASoC: dapm: Check for NULL widget in
	dapm_update_dai_unlocked
Date: Wed, 6 Feb 2019 11:13:59 +0000
Message-ID: <20190206111359.30786-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 92DCC267002
 for <alsa-devel@alsa-project.org>; Wed,  6 Feb 2019 12:14:04 +0100 (CET)
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
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, krzk@kernel.org, lgirdwood@gmail.com, s.nawrocki@samsung.com
List-Id: alsa-devel@alsa-project.org

DAIs linked to the dummy will not have an associated playback/capture
widget, so we need to skip the update in that case.

Fixes: 078a85f2806f ("ASoC: dapm: Only power up active channels from a DAI")
Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Tested-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Tested-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/soc-dapm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 5b74dffc9c11d..111a23a9708a2 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2580,6 +2580,9 @@ static int dapm_update_dai_unlocked(struct snd_pcm_substream *substream,
 	else
 		w = dai->capture_widget;
 
+	if (!w)
+		return 0;
+
 	dev_dbg(dai->dev, "Update DAI routes for %s %s\n", dai->name,
 		dir == SNDRV_PCM_STREAM_PLAYBACK ? "playback" : "capture");
 
-- 
2.11.0
