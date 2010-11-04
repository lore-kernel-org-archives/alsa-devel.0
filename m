From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH] ASoC: core: Fix race in dapm_power_widgets
Date: Thu,  4 Nov 2010 10:16:45 +0200
Message-ID: <1288858605-8388-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa02.nokia.com (smtp.nokia.com [147.243.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id 03B65103840
	for <alsa-devel@alsa-project.org>; Thu,  4 Nov 2010 09:16:47 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

dapm_power_widgets can be called from different context.
When two calls are happening at the same time both will
try to change states/lists. This can lead to kernel crash.

A simple way to reproduce the problem:

while [ "1" = "1" ] ; do
amixer sset -Dhw:0 -q 'Mixer for loopback' on
amixer sset -Dhw:0 -q 'Mixer for loopback' off
done &

while [ "1" = "1" ] ; do
aplay -Dplughw:0 -fdat -d 3 /dev/urandom
echo "Playback finished"
sleep 6
done &

Add new card level mutex (dpw_mutex) to protect the
dapm_power_widgets from race.
The exisiting card->mutex can not be used for this purpose,
since it has been taken in probe time in the
snd_soc_instantiate_card function. Through probe calls from
this function eventually dapm_power_widgets will be called,
which will lead to dead lock.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 include/sound/soc.h  |    1 +
 sound/soc/soc-core.c |    1 +
 sound/soc/soc-dapm.c |    2 ++
 3 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 5c3bce8..c0175ab 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -563,6 +563,7 @@ struct snd_soc_card {
 
 	struct list_head list;
 	struct mutex mutex;
+	struct mutex dpw_mutex; /* To avoid dapm_power_widget race condition */
 
 	bool instantiated;
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 614a8b3..8017afc 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2872,6 +2872,7 @@ static int snd_soc_register_card(struct snd_soc_card *card)
 	INIT_LIST_HEAD(&card->list);
 	card->instantiated = 0;
 	mutex_init(&card->mutex);
+	mutex_init(&card->dpw_mutex);
 
 	mutex_lock(&client_mutex);
 	list_add(&card->list, &card_list);
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 7d85c64..89bfa37 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -902,6 +902,7 @@ static int dapm_power_widgets(struct snd_soc_codec *codec, int event)
 	/* Check which widgets we need to power and store them in
 	 * lists indicating if they should be powered up or down.
 	 */
+	mutex_lock(&card->dpw_mutex);
 	list_for_each_entry(w, &codec->dapm_widgets, list) {
 		switch (w->id) {
 		case snd_soc_dapm_pre:
@@ -1009,6 +1010,7 @@ static int dapm_power_widgets(struct snd_soc_codec *codec, int event)
 	pop_dbg(codec->pop_time, "DAPM sequencing finished, waiting %dms\n",
 		codec->pop_time);
 	pop_wait(codec->pop_time);
+	mutex_unlock(&card->dpw_mutex);
 
 	return 0;
 }
-- 
1.7.3.2
