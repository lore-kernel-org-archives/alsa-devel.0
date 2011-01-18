From: Misael Lopez Cruz <misael.lopez@ti.com>
Subject: [PATCH] ASoC: dapm: Fix race condition in widgets
	power list creation
Date: Mon, 17 Jan 2011 20:36:36 -0600
Message-ID: <1295318196-18136-1-git-send-email-misael.lopez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
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
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Multiple calls to dapm_power_widgets() can create a race condition
causing power list to be corrupted. Those scenarios can occur in
multistream usecases, stream start/stop along with simultaneous
update power calls (mixer, mux, dapm_sync, stream_event).

A new 'dapm_mutex' is added to soc_card, which is held while power
list is created.

Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
---
 include/sound/soc.h  |    1 +
 sound/soc/soc-core.c |    1 +
 sound/soc/soc-dapm.c |    2 ++
 3 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 7e65b01..3dfc608 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -614,6 +614,7 @@ struct snd_soc_card {
 
 	struct list_head list;
 	struct mutex mutex;
+	struct mutex dapm_mutex;
 
 	bool instantiated;
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 1dc4b11..583a821 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3124,6 +3124,7 @@ static int snd_soc_register_card(struct snd_soc_card *card)
 	INIT_LIST_HEAD(&card->list);
 	card->instantiated = 0;
 	mutex_init(&card->mutex);
+	mutex_init(&card->dapm_mutex);
 
 	mutex_lock(&client_mutex);
 	list_add(&card->list, &card_list);
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 3d310af..faee456 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -940,6 +940,7 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 	/* Check which widgets we need to power and store them in
 	 * lists indicating if they should be powered up or down.
 	 */
+	mutex_lock(&card->dapm_mutex);
 	list_for_each_entry(w, &dapm->widgets, list) {
 		switch (w->id) {
 		case snd_soc_dapm_pre:
@@ -974,6 +975,7 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 			break;
 		}
 	}
+	mutex_unlock(&card->dapm_mutex);
 
 	/* If there are no DAPM widgets then try to figure out power from the
 	 * event type.
-- 
1.6.3.3

