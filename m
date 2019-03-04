From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: stm32: sai: fix set_sync service" to the asoc tree
Date: Mon,  4 Mar 2019 00:05:54 +0000 (GMT)
Message-ID: <20190304000554.566AC440082@finisterre.ee.mobilebroadband>
References: <1551359965-25228-6-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1551359965-25228-6-git-send-email-olivier.moysan@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
Cc: alsa-devel@alsa-project.org, olivier.moysan@st.com, alexandre.torgue@st.com, linux-kernel@vger.kernel.org, arnaud.pouliquen@st.com, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org, mcoquelin.stm32@gmail.com, perex@perex.cz, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: stm32: sai: fix set_sync service

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From d4180b4c02e7b04b8479f6237b2bd98b4c5fd19c Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Thu, 28 Feb 2019 14:19:25 +0100
Subject: [PATCH] ASoC: stm32: sai: fix set_sync service

Add error check on set_sync function return.
Add of_node_put() as of_get_parent() takes a reference
which has to be released.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.20.1
