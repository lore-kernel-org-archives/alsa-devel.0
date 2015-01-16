From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/4] ALSA: ak411x: Add PM helper functions
Date: Fri, 16 Jan 2015 18:16:42 +0100
Message-ID: <1421428603-6739-4-git-send-email-tiwai@suse.de>
References: <1421428603-6739-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 097B126043C
 for <alsa-devel@alsa-project.org>; Fri, 16 Jan 2015 18:16:47 +0100 (CET)
In-Reply-To: <1421428603-6739-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Pavel Hofman <pavel.hofman@ivitera.com>
List-Id: alsa-devel@alsa-project.org

Define snd_ak4114_suspend() and snd_ak4114_resume() functions to
handle PM properly, stopping and restarting the work at PM.
Currently only ice1712/juli.c deals with the PM and ak4114, so fix the
calls there appropriately.

The same PM functions are defined in ak4113.c, too, although they
aren't currently called yet (ice1712/quartet.c may be enhanced to
support PM later).

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/ak4113.h   |  8 ++++++++
 include/sound/ak4114.h   |  8 ++++++++
 sound/i2c/other/ak4113.c | 16 ++++++++++++++++
 sound/i2c/other/ak4114.c | 16 ++++++++++++++++
 sound/pci/ice1712/juli.c |  4 +++-
 5 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/include/sound/ak4113.h b/include/sound/ak4113.h
index 3a34f6edc2d1..f4fbf6888e78 100644
--- a/include/sound/ak4113.h
+++ b/include/sound/ak4113.h
@@ -317,5 +317,13 @@ int snd_ak4113_build(struct ak4113 *ak4113,
 int snd_ak4113_external_rate(struct ak4113 *ak4113);
 int snd_ak4113_check_rate_and_errors(struct ak4113 *ak4113, unsigned int flags);
 
+#ifdef CONFIG_PM
+void snd_ak4113_suspend(struct ak4113 *chip);
+void snd_ak4113_resume(struct ak4113 *chip);
+#else
+static inline void snd_ak4113_suspend(struct ak4113 *chip) {}
+static inline void snd_ak4113_resume(struct ak4113 *chip) {}
+#endif
+
 #endif /* __SOUND_AK4113_H */
 
diff --git a/include/sound/ak4114.h b/include/sound/ak4114.h
index 069299a88915..e681df2c95e1 100644
--- a/include/sound/ak4114.h
+++ b/include/sound/ak4114.h
@@ -199,5 +199,13 @@ int snd_ak4114_build(struct ak4114 *ak4114,
 int snd_ak4114_external_rate(struct ak4114 *ak4114);
 int snd_ak4114_check_rate_and_errors(struct ak4114 *ak4114, unsigned int flags);
 
+#ifdef CONFIG_PM
+void snd_ak4114_suspend(struct ak4114 *chip);
+void snd_ak4114_resume(struct ak4114 *chip);
+#else
+static inline void snd_ak4114_suspend(struct ak4114 *chip) {}
+static inline void snd_ak4114_resume(struct ak4114 *chip) {}
+#endif
+
 #endif /* __SOUND_AK4114_H */
 
diff --git a/sound/i2c/other/ak4113.c b/sound/i2c/other/ak4113.c
index c6bba99a90b2..c2b14d981fa1 100644
--- a/sound/i2c/other/ak4113.c
+++ b/sound/i2c/other/ak4113.c
@@ -636,3 +636,19 @@ static void ak4113_stats(struct work_struct *work)
 	if (atomic_dec_and_test(&chip->wq_processing))
 		schedule_delayed_work(&chip->work, HZ / 10);
 }
+
+#ifdef CONFIG_PM
+void snd_ak4113_suspend(struct ak4113 *chip)
+{
+	atomic_inc(&chip->wq_processing); /* don't schedule new work */
+	cancel_delayed_work_sync(&chip->work);
+}
+EXPORT_SYMBOL(snd_ak4113_suspend);
+
+void snd_ak4113_resume(struct ak4113 *chip)
+{
+	atomic_dec(&chip->wq_processing);
+	snd_ak4113_reinit(chip);
+}
+EXPORT_SYMBOL(snd_ak4113_resume);
+#endif
diff --git a/sound/i2c/other/ak4114.c b/sound/i2c/other/ak4114.c
index f6ee1e7a9bbd..ee639f57b664 100644
--- a/sound/i2c/other/ak4114.c
+++ b/sound/i2c/other/ak4114.c
@@ -621,3 +621,19 @@ static void ak4114_stats(struct work_struct *work)
 	if (atomic_dec_and_test(&chip->wq_processing))
 		schedule_delayed_work(&chip->work, HZ / 10);
 }
+
+#ifdef CONFIG_PM
+void snd_ak4114_suspend(struct ak4114 *chip)
+{
+	atomic_inc(&chip->wq_processing); /* don't schedule new work */
+	cancel_delayed_work_sync(&chip->work);
+}
+EXPORT_SYMBOL(snd_ak4114_suspend);
+
+void snd_ak4114_resume(struct ak4114 *chip)
+{
+	atomic_dec(&chip->wq_processing);
+	snd_ak4114_reinit(chip);
+}
+EXPORT_SYMBOL(snd_ak4114_resume);
+#endif
diff --git a/sound/pci/ice1712/juli.c b/sound/pci/ice1712/juli.c
index a1536c1a7ed4..4f0213427152 100644
--- a/sound/pci/ice1712/juli.c
+++ b/sound/pci/ice1712/juli.c
@@ -491,15 +491,17 @@ static int juli_resume(struct snd_ice1712 *ice)
 	/* akm4358 un-reset, un-mute */
 	snd_akm4xxx_reset(ak, 0);
 	/* reinit ak4114 */
-	snd_ak4114_reinit(spec->ak4114);
+	snd_ak4114_resume(spec->ak4114);
 	return 0;
 }
 
 static int juli_suspend(struct snd_ice1712 *ice)
 {
 	struct snd_akm4xxx *ak = ice->akm;
+	struct juli_spec *spec = ice->spec;
 	/* akm4358 reset and soft-mute */
 	snd_akm4xxx_reset(ak, 1);
+	snd_ak4114_suspend(spec->ak4114);
 	return 0;
 }
 #endif
-- 
2.2.1
