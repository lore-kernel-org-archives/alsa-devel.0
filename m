From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dpcm: prevent snd_soc_dpcm use after
	free" to the asoc tree
Date: Mon, 18 Mar 2019 14:51:18 +0000 (GMT)
Message-ID: <20190318145118.336831128874@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C8DA2F89722
 for <alsa-devel@alsa-project.org>; Mon, 18 Mar 2019 15:51:19 +0100 (CET)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dpcm: prevent snd_soc_dpcm use after free

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

>From bbfaa7d36c1eb465f120f2a3dfe25c1fe022195d Mon Sep 17 00:00:00 2001
From: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Date: Thu, 7 Mar 2019 07:51:09 +0800
Subject: [PATCH] ASoC: dpcm: prevent snd_soc_dpcm use after free

The dpcm get from fe_clients/be_clients
may be free before use

Add a spin lock at snd_soc_card level,
to protect the dpcm instance.
The lock may be used in atomic context, so use spin lock.

possible race condition between
void dpcm_be_disconnect(
	...
	list_del(&dpcm->list_be);
	list_del(&dpcm->list_fe);
	kfree(dpcm);
	...

and
	for_each_dpcm_fe()
	for_each_dpcm_be*()

race condition example
Thread 1:
    snd_soc_dapm_mixer_update_power()
        -> soc_dpcm_runtime_update()
            -> dpcm_be_disconnect()
                -> kfree(dpcm);
Thread 2:
    dpcm_fe_dai_trigger()
        -> dpcm_be_dai_trigger()
            -> snd_soc_dpcm_can_be_free_stop()
                -> if (dpcm->fe == fe)

Excpetion Scenario:
	two FE link to same BE
	FE1 -> BE
	FE2 ->

	Thread 1: switch of mixer between FE2 -> BE
	Thread 2: pcm_stop FE1

Exception:

Unable to handle kernel paging request at virtual address dead0000000000e0

pc=<> [<ffffff8960e2cd10>] dpcm_be_dai_trigger+0x29c/0x47c
	sound/soc/soc-pcm.c:3226
		if (dpcm->fe == fe)
lr=<> [<ffffff8960e2f694>] dpcm_fe_dai_do_trigger+0x94/0x26c

Backtrace:
[<ffffff89602dba80>] notify_die+0x68/0xb8
[<ffffff896028c7dc>] die+0x118/0x2a8
[<ffffff89602a2f84>] __do_kernel_fault+0x13c/0x14c
[<ffffff89602a27f4>] do_translation_fault+0x64/0xa0
[<ffffff8960280cf8>] do_mem_abort+0x4c/0xd0
[<ffffff8960282ad0>] el1_da+0x24/0x40
[<ffffff8960e2cd10>] dpcm_be_dai_trigger+0x29c/0x47c
[<ffffff8960e2f694>] dpcm_fe_dai_do_trigger+0x94/0x26c
[<ffffff8960e2edec>] dpcm_fe_dai_trigger+0x3c/0x44
[<ffffff8960de5588>] snd_pcm_do_stop+0x50/0x5c
[<ffffff8960dded24>] snd_pcm_action+0xb4/0x13c
[<ffffff8960ddfdb4>] snd_pcm_drop+0xa0/0x128
[<ffffff8960de69bc>] snd_pcm_common_ioctl+0x9d8/0x30f0
[<ffffff8960de1cac>] snd_pcm_ioctl_compat+0x29c/0x2f14
[<ffffff89604c9d60>] compat_SyS_ioctl+0x128/0x244
[<ffffff8960283740>] el0_svc_naked+0x34/0x38
[<ffffffffffffffff>] 0xffffffffffffffff

Signed-off-by: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  |  2 ++
 sound/soc/soc-core.c |  1 +
 sound/soc/soc-pcm.c  | 33 ++++++++++++++++++++++++++-------
 3 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index eb7db605955b..1e2be35ed36f 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1083,6 +1083,8 @@ struct snd_soc_card {
 	struct mutex mutex;
 	struct mutex dapm_mutex;
 
+	spinlock_t dpcm_lock;
+
 	bool instantiated;
 	bool topology_shortname_created;
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 93d316d5bf8e..d05bf9322fa9 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2819,6 +2819,7 @@ int snd_soc_register_card(struct snd_soc_card *card)
 	card->instantiated = 0;
 	mutex_init(&card->mutex);
 	mutex_init(&card->dapm_mutex);
+	spin_lock_init(&card->dpcm_lock);
 
 	return snd_soc_bind_card(card);
 }
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 0d5ec68a1e50..42f2e06452b2 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1228,8 +1228,10 @@ static int dpcm_be_connect(struct snd_soc_pcm_runtime *fe,
 	dpcm->fe = fe;
 	be->dpcm[stream].runtime = fe->dpcm[stream].runtime;
 	dpcm->state = SND_SOC_DPCM_LINK_STATE_NEW;
+	spin_lock(&fe->card->dpcm_lock);
 	list_add(&dpcm->list_be, &fe->dpcm[stream].be_clients);
 	list_add(&dpcm->list_fe, &be->dpcm[stream].fe_clients);
+	spin_unlock(&fe->card->dpcm_lock);
 
 	dev_dbg(fe->dev, "connected new DPCM %s path %s %s %s\n",
 			stream ? "capture" : "playback",  fe->dai_link->name,
@@ -1294,8 +1296,10 @@ void dpcm_be_disconnect(struct snd_soc_pcm_runtime *fe, int stream)
 #ifdef CONFIG_DEBUG_FS
 		debugfs_remove(dpcm->debugfs_state);
 #endif
+		spin_lock(&fe->card->dpcm_lock);
 		list_del(&dpcm->list_be);
 		list_del(&dpcm->list_fe);
+		spin_unlock(&fe->card->dpcm_lock);
 		kfree(dpcm);
 	}
 }
@@ -1548,9 +1552,11 @@ void dpcm_clear_pending_state(struct snd_soc_pcm_runtime *fe, int stream)
 {
 	struct snd_soc_dpcm *dpcm;
 
+	spin_lock(&fe->card->dpcm_lock);
 	for_each_dpcm_be(fe, stream, dpcm)
 		dpcm->be->dpcm[stream].runtime_update =
 						SND_SOC_DPCM_UPDATE_NO;
+	spin_unlock(&fe->card->dpcm_lock);
 }
 
 static void dpcm_be_dai_startup_unwind(struct snd_soc_pcm_runtime *fe,
@@ -2640,11 +2646,13 @@ static int dpcm_run_update_startup(struct snd_soc_pcm_runtime *fe, int stream)
 	dpcm_be_dai_shutdown(fe, stream);
 disconnect:
 	/* disconnect any non started BEs */
+	spin_lock(&fe->card->dpcm_lock);
 	for_each_dpcm_be(fe, stream, dpcm) {
 		struct snd_soc_pcm_runtime *be = dpcm->be;
 		if (be->dpcm[stream].state != SND_SOC_DPCM_STATE_START)
 				dpcm->state = SND_SOC_DPCM_LINK_STATE_FREE;
 	}
+	spin_unlock(&fe->card->dpcm_lock);
 
 	return ret;
 }
@@ -3221,7 +3229,9 @@ int snd_soc_dpcm_can_be_free_stop(struct snd_soc_pcm_runtime *fe,
 {
 	struct snd_soc_dpcm *dpcm;
 	int state;
+	int ret = 1;
 
+	spin_lock(&fe->card->dpcm_lock);
 	for_each_dpcm_fe(be, stream, dpcm) {
 
 		if (dpcm->fe == fe)
@@ -3230,12 +3240,15 @@ int snd_soc_dpcm_can_be_free_stop(struct snd_soc_pcm_runtime *fe,
 		state = dpcm->fe->dpcm[stream].state;
 		if (state == SND_SOC_DPCM_STATE_START ||
 			state == SND_SOC_DPCM_STATE_PAUSED ||
-			state == SND_SOC_DPCM_STATE_SUSPEND)
-			return 0;
+			state == SND_SOC_DPCM_STATE_SUSPEND) {
+			ret = 0;
+			break;
+		}
 	}
+	spin_unlock(&fe->card->dpcm_lock);
 
 	/* it's safe to free/stop this BE DAI */
-	return 1;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dpcm_can_be_free_stop);
 
@@ -3248,7 +3261,9 @@ int snd_soc_dpcm_can_be_params(struct snd_soc_pcm_runtime *fe,
 {
 	struct snd_soc_dpcm *dpcm;
 	int state;
+	int ret = 1;
 
+	spin_lock(&fe->card->dpcm_lock);
 	for_each_dpcm_fe(be, stream, dpcm) {
 
 		if (dpcm->fe == fe)
@@ -3258,12 +3273,15 @@ int snd_soc_dpcm_can_be_params(struct snd_soc_pcm_runtime *fe,
 		if (state == SND_SOC_DPCM_STATE_START ||
 			state == SND_SOC_DPCM_STATE_PAUSED ||
 			state == SND_SOC_DPCM_STATE_SUSPEND ||
-			state == SND_SOC_DPCM_STATE_PREPARE)
-			return 0;
+			state == SND_SOC_DPCM_STATE_PREPARE) {
+			ret = 0;
+			break;
+		}
 	}
+	spin_unlock(&fe->card->dpcm_lock);
 
 	/* it's safe to change hw_params */
-	return 1;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dpcm_can_be_params);
 
@@ -3329,6 +3347,7 @@ static ssize_t dpcm_show_state(struct snd_soc_pcm_runtime *fe,
 		goto out;
 	}
 
+	spin_lock(&fe->card->dpcm_lock);
 	for_each_dpcm_be(fe, stream, dpcm) {
 		struct snd_soc_pcm_runtime *be = dpcm->be;
 		params = &dpcm->hw_params;
@@ -3349,7 +3368,7 @@ static ssize_t dpcm_show_state(struct snd_soc_pcm_runtime *fe,
 				params_channels(params),
 				params_rate(params));
 	}
-
+	spin_unlock(&fe->card->dpcm_lock);
 out:
 	return offset;
 }
-- 
2.20.1
