From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: core: Make snd_soc_find_component()
	more robust" to the asoc tree
Date: Tue, 15 Jan 2019 00:07:12 +0000 (GMT)
Message-ID: <20190115000712.AC545112349B@debutante.sirena.org.uk>
References: <20190114233641.13375-1-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8323D2670AC
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2019 01:07:14 +0100 (CET)
In-Reply-To: <20190114233641.13375-1-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: rohkumar@qti.qualcomm.com, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, vinod.koul@linaro.org, plai@codeaurora.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, srinivas.kandagatla@linaro.org, Rohit kumar <rohitkr@codeaurora.org>, asishb@codeaurora.org, Ajit Pandey <ajitp@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: core: Make snd_soc_find_component() more robust

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

>From 5a7b2aabc1aa0393f067d9325ada96fdf67f8cb7 Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie@kernel.org>
Date: Mon, 14 Jan 2019 23:29:36 +0000
Subject: [PATCH] ASoC: core: Make snd_soc_find_component() more robust

There are some use cases where you're checking for a lot of things on a
card and it makes sense that you might end up trying to call
snd_soc_find_component() without either a name or an of_node.  Currently
in that case we try to dereference the name and crash but it's more
useful to allow the caller to just treat that as a case where we don't
find anything, that error handling will already exist.

Inspired by a patch from Ajit Pandey fixing some callers.

Fixes: 8780cf1142a5 ("ASoC: soc-core: defer card probe until all component is added to list")
Reported-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index cdcc417c94ca..b680c673c553 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -742,7 +742,7 @@ static struct snd_soc_component *soc_find_component(
 		if (of_node) {
 			if (component->dev->of_node == of_node)
 				return component;
-		} else if (strcmp(component->name, name) == 0) {
+		} else if (name && strcmp(component->name, name) == 0) {
 			return component;
 		}
 	}
-- 
2.20.1
