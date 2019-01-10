From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: Hold client_mutex around
	soc_init_dai_link()" to the asoc tree
Date: Thu, 10 Jan 2019 12:04:48 +0000 (GMT)
Message-ID: <20190110120448.B36591127052@debutante.sirena.org.uk>
References: <1547110961-23670-1-git-send-email-rohitkr@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A5FA626712B
 for <alsa-devel@alsa-project.org>; Thu, 10 Jan 2019 13:04:52 +0100 (CET)
In-Reply-To: <1547110961-23670-1-git-send-email-rohitkr@codeaurora.org>
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
Cc: rohkumar@qti.qualcomm.com, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, vinod.koul@linaro.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-kernel@vger.kernel.org, plai@codeaurora.org, tiwai@suse.com, Ajit Pandey <ajitp@codeaurora.org>, lgirdwood@gmail.com, broonie@kernel.org, srinivas.kandagatla@linaro.org, asishb@codeaurora.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-core: Hold client_mutex around soc_init_dai_link()

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

>From 04eb1efcd614d6f067b76a355b3a3599667959dc Mon Sep 17 00:00:00 2001
From: Rohit kumar <rohitkr@codeaurora.org>
Date: Thu, 10 Jan 2019 14:32:41 +0530
Subject: [PATCH] ASoC: soc-core: Hold client_mutex around soc_init_dai_link()

soc_init_dai_link() calls soc_find_component() which needs
to be within client_mutex lock. Add client_mutex lock around
soc_init_dai_link() in snd_soc_register_card() to avoid
lockdep warning.

Fixes: 8780cf1142a5 ("ASoC: soc-core: defer card probe until all component is added to list")
Reported-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
Signed-off-by: Ajit Pandey <ajitp@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index eec92f17dd15..0934b36645b3 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1027,6 +1027,7 @@ static int snd_soc_init_platform(struct snd_soc_card *card,
 				 struct snd_soc_dai_link *dai_link)
 {
 	struct snd_soc_dai_link_component *platform = dai_link->platform;
+
 	/*
 	 * FIXME
 	 *
@@ -2754,15 +2755,18 @@ int snd_soc_register_card(struct snd_soc_card *card)
 	if (!card->name || !card->dev)
 		return -EINVAL;
 
+	mutex_lock(&client_mutex);
 	for_each_card_prelinks(card, i, link) {
 
 		ret = soc_init_dai_link(card, link);
 		if (ret) {
 			dev_err(card->dev, "ASoC: failed to init link %s\n",
 				link->name);
+			mutex_unlock(&client_mutex);
 			return ret;
 		}
 	}
+	mutex_unlock(&client_mutex);
 
 	dev_set_drvdata(card->dev, card);
 
-- 
2.20.1
