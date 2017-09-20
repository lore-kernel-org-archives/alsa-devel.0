From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH 1/1] soc-pcm: check symmetry after hw_params
Date: Wed, 20 Sep 2017 15:25:30 +0900
Message-ID: <20170920062530.12252-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 by alsa0.perex.cz (Postfix) with ESMTP id 991C9266B21
 for <alsa-devel@alsa-project.org>; Wed, 20 Sep 2017 08:25:26 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: jiada_wang@mentor.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

hw_params may be fixup by be_hw_params_fixup, calling
soc_pcm_params_symmetry() before hw_params will have issue
if there is hw_params changes in be_hw_params_fixup.

For example, with following use case
1. a dai-link which is able to convert sample rate on BE side
2. set BE playback and capture sample rate to 44100Hz
3. play a 48000Hz audio stream with this dai-link
4. record from this dai-link with 44100Hz sample rate

Got following error message when record starts
[  495.013527]  be_link_ak4613: ASoC: unmatched rate symmetry: 48000 - 44100
[  495.021729]  be_link_ak4613: ASoC: hw_params BE failed -22
[  495.028589]  rsnd_link0: ASoC: hw_params BE failed -22

Because in soc_pcm_hw_params(), FE rate is still having value before
it is fixup by be_hw_params_fixup(), when soc_pcm_params_symmetry() checks
symmetry, thus soc_pcm_params_symmetry() complains about the unmatched rate
between the active stream and the new stream tries to start.

This patch moves soc_pcm_params_symmetry() after hw_params to resolve the
above issue.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 sound/soc/soc-pcm.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 94b88b8..f11421f 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -855,11 +855,6 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 	int i, ret = 0;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
-
-	ret = soc_pcm_params_symmetry(substream, params);
-	if (ret)
-		goto out;
-
 	if (rtd->dai_link->ops && rtd->dai_link->ops->hw_params) {
 		ret = rtd->dai_link->ops->hw_params(substream, params);
 		if (ret < 0) {
@@ -930,6 +925,10 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 	cpu_dai->sample_bits =
 		snd_pcm_format_physical_width(params_format(params));
 
+
+	ret = soc_pcm_params_symmetry(substream, params);
+        if (ret)
+                goto platform_err;
 out:
 	mutex_unlock(&rtd->pcm_mutex);
 	return ret;
-- 
2.9.3
