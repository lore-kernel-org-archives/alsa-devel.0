From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: remove error due to probe
	deferral" to the asoc tree
Date: Mon, 12 Feb 2018 12:27:44 +0000
Message-ID: <E1elDCy-0002oU-Ve@debutante>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4343540168325747236=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8303C267328
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:27:47 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

--===============4343540168325747236==
Content-Type: text/plain

The patch

   ASoC: soc-core: remove error due to probe deferral

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

>From 6b49087912e311bc884d36874592595508630b88 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <mnhu@prevas.dk>
Date: Thu, 1 Feb 2018 11:09:41 +0100
Subject: [PATCH] ASoC: soc-core: remove error due to probe deferral
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Deferred probes shouldn't cause error messages in the boot log, so
change the dev_err() to the more harmless dev_info().

Signed-off-by: Martin Hundebøll <mnhu@prevas.dk>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 96c44f6576c9..60a542f35dbd 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1100,8 +1100,8 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 	cpu_dai_component.dai_name = dai_link->cpu_dai_name;
 	rtd->cpu_dai = snd_soc_find_dai(&cpu_dai_component);
 	if (!rtd->cpu_dai) {
-		dev_err(card->dev, "ASoC: CPU DAI %s not registered\n",
-			dai_link->cpu_dai_name);
+		dev_info(card->dev, "ASoC: CPU DAI %s not registered\n",
+			 dai_link->cpu_dai_name);
 		goto _err_defer;
 	}
 	snd_soc_rtdcom_add(rtd, rtd->cpu_dai->component);
-- 
2.16.1


--===============4343540168325747236==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4343540168325747236==--
