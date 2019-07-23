From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-dai: add snd_soc_dai_resume()" to
	the asoc tree
Date: Tue, 23 Jul 2019 18:18:51 +0100 (BST)
Message-ID: <20190723171851.5F8302742BAC@ypsilon.sirena.org.uk>
References: <87lfwqhn2j.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DE9ACF8045F
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2019 19:18:52 +0200 (CEST)
In-Reply-To: <87lfwqhn2j.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-dai: add snd_soc_dai_resume()

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

>From 24b09d051164680f0a1d1910efe21ce36ad5c1ca Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 22 Jul 2019 10:34:43 +0900
Subject: [PATCH] ASoC: soc-dai: add snd_soc_dai_resume()

Current ALSA SoC is directly using dai->driver->xxx,
thus, it has deep nested bracket, and it makes code unreadable.
This patch adds new snd_soc_dai_resume() and use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/87lfwqhn2j.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-dai.h | 1 +
 sound/soc/soc-core.c    | 8 ++++----
 sound/soc/soc-dai.c     | 6 ++++++
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 6c5604a7dbc2..ed78e34a814e 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -163,6 +163,7 @@ int snd_soc_dai_bespoke_trigger(struct snd_soc_dai *dai,
 snd_pcm_sframes_t snd_soc_dai_delay(struct snd_soc_dai *dai,
 				    struct snd_pcm_substream *substream);
 void snd_soc_dai_suspend(struct snd_soc_dai *dai);
+void snd_soc_dai_resume(struct snd_soc_dai *dai);
 
 struct snd_soc_dai_ops {
 	/*
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 7493afb2371c..5c02f90cea69 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -631,8 +631,8 @@ static void soc_resume_deferred(struct work_struct *work)
 		if (rtd->dai_link->ignore_suspend)
 			continue;
 
-		if (cpu_dai->driver->resume && cpu_dai->driver->bus_control)
-			cpu_dai->driver->resume(cpu_dai);
+		if (cpu_dai->driver->bus_control)
+			snd_soc_dai_resume(cpu_dai);
 	}
 
 	for_each_card_components(card, component) {
@@ -678,8 +678,8 @@ static void soc_resume_deferred(struct work_struct *work)
 		if (rtd->dai_link->ignore_suspend)
 			continue;
 
-		if (cpu_dai->driver->resume && !cpu_dai->driver->bus_control)
-			cpu_dai->driver->resume(cpu_dai);
+		if (!cpu_dai->driver->bus_control)
+			snd_soc_dai_resume(cpu_dai);
 	}
 
 	if (card->resume_post)
diff --git a/sound/soc/soc-dai.c b/sound/soc/soc-dai.c
index 3373598e0682..ddb6f217c0ed 100644
--- a/sound/soc/soc-dai.c
+++ b/sound/soc/soc-dai.c
@@ -359,3 +359,9 @@ void snd_soc_dai_suspend(struct snd_soc_dai *dai)
 	if (dai->driver->suspend)
 		dai->driver->suspend(dai);
 }
+
+void snd_soc_dai_resume(struct snd_soc_dai *dai)
+{
+	if (dai->driver->resume)
+		dai->driver->resume(dai);
+}
-- 
2.20.1
