From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/4] ALSA: firewire: block .remove callback of
	bus driver till all of ALSA character devices are released
Date: Wed, 10 Oct 2018 15:34:59 +0900
Message-ID: <20181010063502.4698-2-o-takashi@sakamocchi.jp>
References: <20181010063502.4698-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
 [209.85.210.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 752232678CC
 for <alsa-devel@alsa-project.org>; Wed, 10 Oct 2018 08:35:13 +0200 (CEST)
Received: by mail-pf1-f196.google.com with SMTP id j23-v6so2111464pfi.4
 for <alsa-devel@alsa-project.org>; Tue, 09 Oct 2018 23:35:13 -0700 (PDT)
In-Reply-To: <20181010063502.4698-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

At present, in .remove callback of bus driver just decrease reference
count of device for ALSA card instance. This delegates release of the
device to a process in which the last of ALSA character device is
released.

On the other hand, the other drivers such as for devices on PCIe are
programmed to block .remove callback of bus driver till all of ALSA
character devices are released.

For consistency of behaviour for whole drivers, this probably confuses
users. This commit takes drivers in ALSA firewire stack to imitate the
above behaviour.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob.c         | 4 ++--
 sound/firewire/digi00x/digi00x.c     | 4 ++--
 sound/firewire/fireface/ff.c         | 4 ++--
 sound/firewire/fireworks/fireworks.c | 4 ++--
 sound/firewire/isight.c              | 3 ++-
 sound/firewire/motu/motu.c           | 4 ++--
 sound/firewire/oxfw/oxfw.c           | 4 ++--
 sound/firewire/tascam/tascam.c       | 4 ++--
 8 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/sound/firewire/bebob/bebob.c b/sound/firewire/bebob/bebob.c
index 72b04214a3b5..3a5579cb3aa8 100644
--- a/sound/firewire/bebob/bebob.c
+++ b/sound/firewire/bebob/bebob.c
@@ -374,8 +374,8 @@ static void bebob_remove(struct fw_unit *unit)
 	cancel_delayed_work_sync(&bebob->dwork);
 
 	if (bebob->registered) {
-		/* No need to wait for releasing card object in this context. */
-		snd_card_free_when_closed(bebob->card);
+		// Block till all of ALSA character devices are released.
+		snd_card_free(bebob->card);
 	} else {
 		/* Don't forget this case. */
 		bebob_free(bebob);
diff --git a/sound/firewire/digi00x/digi00x.c b/sound/firewire/digi00x/digi00x.c
index 654420f1c9bd..554d7ff737a2 100644
--- a/sound/firewire/digi00x/digi00x.c
+++ b/sound/firewire/digi00x/digi00x.c
@@ -172,8 +172,8 @@ static void snd_dg00x_remove(struct fw_unit *unit)
 	cancel_delayed_work_sync(&dg00x->dwork);
 
 	if (dg00x->registered) {
-		/* No need to wait for releasing card object in this context. */
-		snd_card_free_when_closed(dg00x->card);
+		// Block till all of ALSA character devices are released.
+		snd_card_free(dg00x->card);
 	} else {
 		/* Don't forget this case. */
 		dg00x_free(dg00x);
diff --git a/sound/firewire/fireface/ff.c b/sound/firewire/fireface/ff.c
index 98731bd8816f..73425dfe63bf 100644
--- a/sound/firewire/fireface/ff.c
+++ b/sound/firewire/fireface/ff.c
@@ -145,8 +145,8 @@ static void snd_ff_remove(struct fw_unit *unit)
 	cancel_work_sync(&ff->dwork.work);
 
 	if (ff->registered) {
-		/* No need to wait for releasing card object in this context. */
-		snd_card_free_when_closed(ff->card);
+		// Block till all of ALSA character devices are released.
+		snd_card_free(ff->card);
 	} else {
 		/* Don't forget this case. */
 		ff_free(ff);
diff --git a/sound/firewire/fireworks/fireworks.c b/sound/firewire/fireworks/fireworks.c
index f680e2f27806..5a17ead86e61 100644
--- a/sound/firewire/fireworks/fireworks.c
+++ b/sound/firewire/fireworks/fireworks.c
@@ -358,8 +358,8 @@ static void efw_remove(struct fw_unit *unit)
 	cancel_delayed_work_sync(&efw->dwork);
 
 	if (efw->registered) {
-		/* No need to wait for releasing card object in this context. */
-		snd_card_free_when_closed(efw->card);
+		// Block till all of ALSA character devices are released.
+		snd_card_free(efw->card);
 	} else {
 		/* Don't forget this case. */
 		efw_free(efw);
diff --git a/sound/firewire/isight.c b/sound/firewire/isight.c
index 30957477e005..1f591c8805ea 100644
--- a/sound/firewire/isight.c
+++ b/sound/firewire/isight.c
@@ -703,7 +703,8 @@ static void isight_remove(struct fw_unit *unit)
 	isight_stop_streaming(isight);
 	mutex_unlock(&isight->mutex);
 
-	snd_card_free_when_closed(isight->card);
+	// Block till all of ALSA character devices are released.
+	snd_card_free(isight->card);
 }
 
 static const struct ieee1394_device_id isight_id_table[] = {
diff --git a/sound/firewire/motu/motu.c b/sound/firewire/motu/motu.c
index fd5726424c7a..12680c85b37f 100644
--- a/sound/firewire/motu/motu.c
+++ b/sound/firewire/motu/motu.c
@@ -172,8 +172,8 @@ static void motu_remove(struct fw_unit *unit)
 	cancel_delayed_work_sync(&motu->dwork);
 
 	if (motu->registered) {
-		/* No need to wait for releasing card object in this context. */
-		snd_card_free_when_closed(motu->card);
+		// Block till all of ALSA character devices are released.
+		snd_card_free(motu->card);
 	} else {
 		/* Don't forget this case. */
 		motu_free(motu);
diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index 6ac551786b93..36f905b371e6 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -327,8 +327,8 @@ static void oxfw_remove(struct fw_unit *unit)
 	cancel_delayed_work_sync(&oxfw->dwork);
 
 	if (oxfw->registered) {
-		/* No need to wait for releasing card object in this context. */
-		snd_card_free_when_closed(oxfw->card);
+		// Block till all of ALSA character devices are released.
+		snd_card_free(oxfw->card);
 	} else {
 		/* Don't forget this case. */
 		oxfw_free(oxfw);
diff --git a/sound/firewire/tascam/tascam.c b/sound/firewire/tascam/tascam.c
index 53f20153ba71..6f7aaa8c84aa 100644
--- a/sound/firewire/tascam/tascam.c
+++ b/sound/firewire/tascam/tascam.c
@@ -212,8 +212,8 @@ static void snd_tscm_remove(struct fw_unit *unit)
 	cancel_delayed_work_sync(&tscm->dwork);
 
 	if (tscm->registered) {
-		/* No need to wait for releasing card object in this context. */
-		snd_card_free_when_closed(tscm->card);
+		// Block till all of ALSA character devices are released.
+		snd_card_free(tscm->card);
 	} else {
 		/* Don't forget this case. */
 		tscm_free(tscm);
-- 
2.19.0
