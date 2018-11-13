From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qcom: Set dai_link id to each dai_link"
	to the asoc tree
Date: Tue, 13 Nov 2018 23:10:35 +0000 (GMT)
Message-ID: <20181113231035.527E4440078@finisterre.ee.mobilebroadband>
References: <1541684500-32728-1-git-send-email-rohitkr@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 57CF92677E4
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2018 00:10:43 +0100 (CET)
In-Reply-To: <1541684500-32728-1-git-send-email-rohitkr@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rohit kumar <rohitkr@codeaurora.org>
Cc: rohkumar@qti.qualcomm.com, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, linux-kernel@vger.kernel.org, plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org, srinivas.kandagatla@linaro.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: qcom: Set dai_link id to each dai_link

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

>From 67fd1437d11620de8768b22fe20942e752ed52e9 Mon Sep 17 00:00:00 2001
From: Rohit kumar <rohitkr@codeaurora.org>
Date: Thu, 8 Nov 2018 19:11:40 +0530
Subject: [PATCH] ASoC: qcom: Set dai_link id to each dai_link

Frontend dai_link id is used for closing ADM sessions.
During concurrent usecase when one session is closed,
it closes other ADM session associated with other usecase
too. Dai_link->id should always point to Frontend dai id.
Set cpu_dai id as dai_link id to fix the issue.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/common.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/qcom/common.c b/sound/soc/qcom/common.c
index eb1b9da05dd4..4715527054e5 100644
--- a/sound/soc/qcom/common.c
+++ b/sound/soc/qcom/common.c
@@ -13,6 +13,7 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 	struct device_node *cpu = NULL;
 	struct device *dev = card->dev;
 	struct snd_soc_dai_link *link;
+	struct of_phandle_args args;
 	int ret, num_links;
 
 	ret = snd_soc_of_parse_card_name(card, "model");
@@ -47,12 +48,14 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 			goto err;
 		}
 
-		link->cpu_of_node = of_parse_phandle(cpu, "sound-dai", 0);
-		if (!link->cpu_of_node) {
+		ret = of_parse_phandle_with_args(cpu, "sound-dai",
+					"#sound-dai-cells", 0, &args);
+		if (ret) {
 			dev_err(card->dev, "error getting cpu phandle\n");
-			ret = -EINVAL;
 			goto err;
 		}
+		link->cpu_of_node = args.np;
+		link->id = args.args[0];
 
 		ret = snd_soc_of_get_dai_name(cpu, &link->cpu_dai_name);
 		if (ret) {
-- 
2.19.1
