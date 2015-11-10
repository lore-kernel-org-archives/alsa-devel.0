From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dapm: Reset dapm wcache after freeing
	damp widgets" to the asoc tree
Date: Tue, 10 Nov 2015 18:53:35 +0000
Message-ID: <E1ZwE2x-0001iB-Pj@debutante>
References: <1447171962-15736-1-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B8930265357
 for <alsa-devel@alsa-project.org>; Tue, 10 Nov 2015 19:53:42 +0100 (CET)
In-Reply-To: <1447171962-15736-1-git-send-email-jsarha@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>, Felipe Balbi <balbi@ti.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dapm: Reset dapm wcache after freeing damp widgets

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From fd589a1be20fdd76ef97700dd0185e7a060546dc Mon Sep 17 00:00:00 2001
From: Jyri Sarha <jsarha@ti.com>
Date: Tue, 10 Nov 2015 18:12:42 +0200
Subject: [PATCH] ASoC: dapm: Reset dapm wcache after freeing damp widgets

If there is anything in damp->path_source_cache or
damp->path_sink_cache, it can not be valid after the widgets have been
freed. Without this patch a repeated remove and load of a machine
driver may cause NULL pointer reference in dapm_wcache_lookup() when a
freed widget, not belonging to any list, is haunting in the wcache.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
Reported-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-dapm.h | 1 +
 sound/soc/soc-dapm.c     | 7 +++++++
 sound/soc/soc-topology.c | 1 +
 3 files changed, 9 insertions(+)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 7855cfe46b69..95a937eafb79 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -398,6 +398,7 @@ int snd_soc_dapm_del_routes(struct snd_soc_dapm_context *dapm,
 int snd_soc_dapm_weak_routes(struct snd_soc_dapm_context *dapm,
 			     const struct snd_soc_dapm_route *route, int num);
 void snd_soc_dapm_free_widget(struct snd_soc_dapm_widget *w);
+void snd_soc_dapm_reset_cache(struct snd_soc_dapm_context *dapm);
 
 /* dapm events */
 void snd_soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd, int stream,
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 016eba10b1ec..7d009428934a 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2293,6 +2293,12 @@ void snd_soc_dapm_free_widget(struct snd_soc_dapm_widget *w)
 	kfree(w);
 }
 
+void snd_soc_dapm_reset_cache(struct snd_soc_dapm_context *dapm)
+{
+	dapm->path_sink_cache.widget = NULL;
+	dapm->path_source_cache.widget = NULL;
+}
+
 /* free all dapm widgets and resources */
 static void dapm_free_widgets(struct snd_soc_dapm_context *dapm)
 {
@@ -2303,6 +2309,7 @@ static void dapm_free_widgets(struct snd_soc_dapm_context *dapm)
 			continue;
 		snd_soc_dapm_free_widget(w);
 	}
+	snd_soc_dapm_reset_cache(dapm);
 }
 
 static struct snd_soc_dapm_widget *dapm_find_widget(
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 8d7ec80af51b..cce63fe65dd9 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1805,6 +1805,7 @@ void snd_soc_tplg_widget_remove_all(struct snd_soc_dapm_context *dapm,
 		snd_soc_tplg_widget_remove(w);
 		snd_soc_dapm_free_widget(w);
 	}
+	snd_soc_dapm_reset_cache(dapm);
 }
 EXPORT_SYMBOL_GPL(snd_soc_tplg_widget_remove_all);
 
-- 
2.6.2
