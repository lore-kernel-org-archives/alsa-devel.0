From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qcom: Fix of-node refcount unbalance in
	qcom_snd_parse_of()" to the asoc tree
Date: Wed, 20 Feb 2019 17:52:42 +0000 (GMT)
Message-ID: <20190220175242.31E84112882C@debutante.sirena.org.uk>
References: <20190219154652.13644-6-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5A3BBF8076A
 for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2019 18:52:44 +0100 (CET)
In-Reply-To: <20190219154652.13644-6-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: qcom: Fix of-node refcount unbalance in qcom_snd_parse_of()

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

>From 70b773219a32c7b8f3e53e041bc023ad99fd81f4 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Tue, 19 Feb 2019 16:46:51 +0100
Subject: [PATCH] ASoC: qcom: Fix of-node refcount unbalance in
 qcom_snd_parse_of()

Although qcom_snd_parse_of() tries to manage the of-node refcount,
there are still a few places that lead to the unblanced refcount in
the error code path.  Namely,

- for_each_child_of_node() needs to unreference the iterator node if
  aborting the loop in the middle,
- cpu, codec and platform node objects have to be unreferenced at each
  iteration,
- platform and codec node objects have to be referred before jumping
  to the error handling code that unreference them unconditionally.

This patch tries to address these by moving the assignment of platform
and codec node objects to the beginning of the loop and adding the
of_node_put() calls adequately.

Fixes: c25e295cd77b ("ASoC: qcom: Add support to parse common audio device nodes")
Cc: Patrick Lai <plai@codeaurora.org>
Cc: Banajit Goswami <bgoswami@codeaurora.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/common.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/common.c b/sound/soc/qcom/common.c
index 4715527054e5..5661025e8cec 100644
--- a/sound/soc/qcom/common.c
+++ b/sound/soc/qcom/common.c
@@ -42,6 +42,9 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 	link = card->dai_link;
 	for_each_child_of_node(dev->of_node, np) {
 		cpu = of_get_child_by_name(np, "cpu");
+		platform = of_get_child_by_name(np, "platform");
+		codec = of_get_child_by_name(np, "codec");
+
 		if (!cpu) {
 			dev_err(dev, "Can't find cpu DT node\n");
 			ret = -EINVAL;
@@ -63,8 +66,6 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 			goto err;
 		}
 
-		platform = of_get_child_by_name(np, "platform");
-		codec = of_get_child_by_name(np, "codec");
 		if (codec && platform) {
 			link->platform_of_node = of_parse_phandle(platform,
 					"sound-dai",
@@ -100,10 +101,15 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 		link->dpcm_capture = 1;
 		link->stream_name = link->name;
 		link++;
+
+		of_node_put(cpu);
+		of_node_put(codec);
+		of_node_put(platform);
 	}
 
 	return 0;
 err:
+	of_node_put(np);
 	of_node_put(cpu);
 	of_node_put(codec);
 	of_node_put(platform);
-- 
2.20.1
