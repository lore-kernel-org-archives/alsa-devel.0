From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qcom: apq8096: set card as device
	drvdata" to the asoc tree
Date: Mon, 18 Jun 2018 13:00:05 +0100
Message-ID: <E1fUspJ-00005s-Fk@debutante>
References: <1528275324-4878-1-git-send-email-rohitkr@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C9CE92676E6
 for <alsa-devel@alsa-project.org>; Mon, 18 Jun 2018 14:00:12 +0200 (CEST)
In-Reply-To: <1528275324-4878-1-git-send-email-rohitkr@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: rohkumar@qti.qualcomm.com, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, linux-kernel@vger.kernel.org, plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org, srinivas.kandagatla@linaro.org, Rohit kumar <rohitkr@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: qcom: apq8096: set card as device drvdata

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

>From d5c4e972d512ae0b59108ca92b9b35bc5cf5c14e Mon Sep 17 00:00:00 2001
From: Rohit Kumar <rohitkr@codeaurora.org>
Date: Wed, 6 Jun 2018 14:25:24 +0530
Subject: [PATCH] ASoC: qcom: apq8096: set card as device drvdata

snd_soc_card is retrieved as device drvdata during unbind().
Set it as drvdata during bind() to avoid memory corruption during
unbind().

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/apq8096.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/qcom/apq8096.c b/sound/soc/qcom/apq8096.c
index 561cd429e6f2..239b8cb77bdb 100644
--- a/sound/soc/qcom/apq8096.c
+++ b/sound/soc/qcom/apq8096.c
@@ -140,6 +140,7 @@ static int apq8096_bind(struct device *dev)
 
 	component_bind_all(dev, card);
 	card->dev = dev;
+	dev_set_drvdata(dev, card);
 	ret = apq8096_sbc_parse_of(card);
 	if (ret) {
 		dev_err(dev, "Error parsing OF data\n");
-- 
2.17.1
