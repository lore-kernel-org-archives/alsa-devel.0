From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: add for_each_dpcm_fe() macro" to the
	asoc tree
Date: Thu, 20 Sep 2018 18:35:23 +0100 (BST)
Message-ID: <20180920173523.EEC41440078@finisterre.ee.mobilebroadband>
References: <87musfppig.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7875726789F
 for <alsa-devel@alsa-project.org>; Thu, 20 Sep 2018 19:35:26 +0200 (CEST)
In-Reply-To: <87musfppig.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: add for_each_dpcm_fe() macro

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

>From d2e24d64652bf9d272e5496ae8a562bc64facff3 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 18 Sep 2018 01:30:54 +0000
Subject: [PATCH] ASoC: add for_each_dpcm_fe() macro

To be more readable code, this patch adds
new for_each_dpcm_fe() macro, and replace existing code to it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-dpcm.h | 3 +++
 sound/soc/soc-pcm.c      | 6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/sound/soc-dpcm.h b/include/sound/soc-dpcm.h
index 9bb92f187af8..f130de6cfe8e 100644
--- a/include/sound/soc-dpcm.h
+++ b/include/sound/soc-dpcm.h
@@ -103,6 +103,9 @@ struct snd_soc_dpcm_runtime {
 	int trigger_pending; /* trigger cmd + 1 if pending, 0 if not */
 };
 
+#define for_each_dpcm_fe(be, stream, dpcm)				\
+	list_for_each_entry(dpcm, &(be)->dpcm[stream].fe_clients, list_fe)
+
 /* can this BE stop and free */
 int snd_soc_dpcm_can_be_free_stop(struct snd_soc_pcm_runtime *fe,
 		struct snd_soc_pcm_runtime *be, int stream);
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 09d0f668c78e..e7916630e6fa 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1252,7 +1252,7 @@ static void dpcm_be_reparent(struct snd_soc_pcm_runtime *fe,
 
 	be_substream = snd_soc_dpcm_get_substream(be, stream);
 
-	list_for_each_entry(dpcm, &be->dpcm[stream].fe_clients, list_fe) {
+	for_each_dpcm_fe(be, stream, dpcm) {
 		if (dpcm->fe == fe)
 			continue;
 
@@ -3219,7 +3219,7 @@ int snd_soc_dpcm_can_be_free_stop(struct snd_soc_pcm_runtime *fe,
 	struct snd_soc_dpcm *dpcm;
 	int state;
 
-	list_for_each_entry(dpcm, &be->dpcm[stream].fe_clients, list_fe) {
+	for_each_dpcm_fe(be, stream, dpcm) {
 
 		if (dpcm->fe == fe)
 			continue;
@@ -3246,7 +3246,7 @@ int snd_soc_dpcm_can_be_params(struct snd_soc_pcm_runtime *fe,
 	struct snd_soc_dpcm *dpcm;
 	int state;
 
-	list_for_each_entry(dpcm, &be->dpcm[stream].fe_clients, list_fe) {
+	for_each_dpcm_fe(be, stream, dpcm) {
 
 		if (dpcm->fe == fe)
 			continue;
-- 
2.19.0
