From: Olivier Moysan <olivier.moysan@st.com>
Subject: [PATCH 5/5] ASoC: stm32: sai: fix set_sync service
Date: Thu, 28 Feb 2019 14:19:25 +0100
Message-ID: <1551359965-25228-6-git-send-email-olivier.moysan@st.com>
References: <1551359965-25228-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551359965-25228-1-git-send-email-olivier.moysan@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com, arnaud.pouliquen@st.com, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

Add error check on set_sync function return.
Add of_node_put() as of_get_parent() takes a reference
which has to be released.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_sai.c     | 8 +++++---
 sound/soc/stm/stm32_sai_sub.c | 8 +++++---
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/sound/soc/stm/stm32_sai.c b/sound/soc/stm/stm32_sai.c
index 14c9591aae42..d68d62f12df5 100644
--- a/sound/soc/stm/stm32_sai.c
+++ b/sound/soc/stm/stm32_sai.c
@@ -105,6 +105,7 @@ static int stm32_sai_set_sync(struct stm32_sai_data *sai_client,
 	if (!pdev) {
 		dev_err(&sai_client->pdev->dev,
 			"Device not found for node %pOFn\n", np_provider);
+		of_node_put(np_provider);
 		return -ENODEV;
 	}
 
@@ -113,19 +114,20 @@ static int stm32_sai_set_sync(struct stm32_sai_data *sai_client,
 		dev_err(&sai_client->pdev->dev,
 			"SAI sync provider data not found\n");
 		ret = -EINVAL;
-		goto out_put_dev;
+		goto error;
 	}
 
 	/* Configure sync client */
 	ret = stm32_sai_sync_conf_client(sai_client, synci);
 	if (ret < 0)
-		goto out_put_dev;
+		goto error;
 
 	/* Configure sync provider */
 	ret = stm32_sai_sync_conf_provider(sai_provider, synco);
 
-out_put_dev:
+error:
 	put_device(&pdev->dev);
+	of_node_put(np_provider);
 	return ret;
 }
 
diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index cb658463ccd1..55d802f51c15 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -1106,7 +1106,7 @@ static int stm32_sai_pcm_new(struct snd_soc_pcm_runtime *rtd,
 static int stm32_sai_dai_probe(struct snd_soc_dai *cpu_dai)
 {
 	struct stm32_sai_sub_data *sai = dev_get_drvdata(cpu_dai->dev);
-	int cr1 = 0, cr1_mask;
+	int cr1 = 0, cr1_mask, ret;
 
 	sai->cpu_dai = cpu_dai;
 
@@ -1136,8 +1136,10 @@ static int stm32_sai_dai_probe(struct snd_soc_dai *cpu_dai)
 	/* Configure synchronization */
 	if (sai->sync == SAI_SYNC_EXTERNAL) {
 		/* Configure synchro client and provider */
-		sai->pdata->set_sync(sai->pdata, sai->np_sync_provider,
-				     sai->synco, sai->synci);
+		ret = sai->pdata->set_sync(sai->pdata, sai->np_sync_provider,
+					   sai->synco, sai->synci);
+		if (ret)
+			return ret;
 	}
 
 	cr1_mask |= SAI_XCR1_SYNCEN_MASK;
-- 
2.7.4
