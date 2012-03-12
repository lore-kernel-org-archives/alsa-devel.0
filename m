From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: jack: Push locking for jacks down to the
	jack
Date: Mon, 12 Mar 2012 14:08:26 +0000
Message-ID: <1331561306-25183-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B596F1041EA
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 15:09:24 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Currently operations on jack reporting take the CODEC mutex both to protect
the current jack status and also to protect the DAPM run which is triggered
on status updates. Since the addition of a DAPM-specific lock we no longer
need to worry about locking DAPM as it has its own finer grained lock so
create a per jack lock to take care of the jack status.

This is both cleaner where the jack isn't specifically associated with a
CODEC and clearer as it's much more obvious what the lock is protecting.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h  |    1 +
 sound/soc/soc-jack.c |    5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 0989987..b8163dd 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -518,6 +518,7 @@ struct snd_soc_jack_gpio {
 #endif
 
 struct snd_soc_jack {
+	struct mutex mutex;
 	struct snd_jack *jack;
 	struct snd_soc_codec *codec;
 	struct list_head pins;
diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index 17717fc..9db15ba 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -36,6 +36,7 @@
 int snd_soc_jack_new(struct snd_soc_codec *codec, const char *id, int type,
 		     struct snd_soc_jack *jack)
 {
+	mutex_init(&jack->mutex);
 	jack->codec = codec;
 	INIT_LIST_HEAD(&jack->pins);
 	INIT_LIST_HEAD(&jack->jack_zones);
@@ -75,7 +76,7 @@ void snd_soc_jack_report(struct snd_soc_jack *jack, int status, int mask)
 	codec = jack->codec;
 	dapm =  &codec->dapm;
 
-	mutex_lock(&codec->mutex);
+	mutex_lock(&jack->mutex);
 
 	oldstatus = jack->status;
 
@@ -109,7 +110,7 @@ void snd_soc_jack_report(struct snd_soc_jack *jack, int status, int mask)
 	snd_jack_report(jack->jack, jack->status);
 
 out:
-	mutex_unlock(&codec->mutex);
+	mutex_unlock(&jack->mutex);
 }
 EXPORT_SYMBOL_GPL(snd_soc_jack_report);
 
-- 
1.7.9.1
