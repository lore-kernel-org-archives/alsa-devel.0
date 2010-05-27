From: linux@audioscience.com
Subject: [PATCH 5/5] Minor code cleanup.
Date: Thu, 27 May 2010 17:53:55 +1200
Message-ID: <1274939635-1370-5-git-send-email-linux@audioscience.com>
References: <1274939635-1370-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <1274939635-1370-1-git-send-email-linux@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: tiwai@suse.de, Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eblennerhassett@audioscience.com>

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 sound/pci/asihpi/hpicmn.c |   38 +++++++++++++-------------------------
 1 files changed, 13 insertions(+), 25 deletions(-)

diff --git a/sound/pci/asihpi/hpicmn.c b/sound/pci/asihpi/hpicmn.c
index 565102c..fcd6453 100644
--- a/sound/pci/asihpi/hpicmn.c
+++ b/sound/pci/asihpi/hpicmn.c
@@ -347,20 +347,15 @@ short hpi_check_control_cache(struct hpi_control_cache *p_cache,
 			found = 0;
 		break;
 	case HPI_CONTROL_TUNER:
-		{
-			struct hpi_control_cache_single *pCT =
-				(struct hpi_control_cache_single *)pI;
-			if (phm->u.c.attribute == HPI_TUNER_FREQ)
-				phr->u.c.param1 = pCT->u.t.freq_ink_hz;
-			else if (phm->u.c.attribute == HPI_TUNER_BAND)
-				phr->u.c.param1 = pCT->u.t.band;
-			else if ((phm->u.c.attribute == HPI_TUNER_LEVEL)
-				&& (phm->u.c.param1 ==
-					HPI_TUNER_LEVEL_AVERAGE))
-				phr->u.c.param1 = pCT->u.t.level;
-			else
-				found = 0;
-		}
+		if (phm->u.c.attribute == HPI_TUNER_FREQ)
+			phr->u.c.param1 = pC->u.t.freq_ink_hz;
+		else if (phm->u.c.attribute == HPI_TUNER_BAND)
+			phr->u.c.param1 = pC->u.t.band;
+		else if ((phm->u.c.attribute == HPI_TUNER_LEVEL)
+			&& (phm->u.c.param1 == HPI_TUNER_LEVEL_AVERAGE))
+			phr->u.c.param1 = pC->u.t.level;
+		else
+			found = 0;
 		break;
 	case HPI_CONTROL_AESEBU_RECEIVER:
 		if (phm->u.c.attribute == HPI_AESEBURX_ERRORSTATUS)
@@ -503,6 +498,9 @@ void hpi_sync_control_cache(struct hpi_control_cache *p_cache,
 	struct hpi_control_cache_single *pC;
 	struct hpi_control_cache_info *pI;
 
+	if (phr->error)
+		return;
+
 	if (!find_control(phm, p_cache, &pI, &control_index))
 		return;
 
@@ -520,8 +518,6 @@ void hpi_sync_control_cache(struct hpi_control_cache *p_cache,
 		break;
 	case HPI_CONTROL_MULTIPLEXER:
 		/* mux does not return its setting on Set command. */
-		if (phr->error)
-			return;
 		if (phm->u.c.attribute == HPI_MULTIPLEXER_SOURCE) {
 			pC->u.x.source_node_type = (u16)phm->u.c.param1;
 			pC->u.x.source_node_index = (u16)phm->u.c.param2;
@@ -529,8 +525,6 @@ void hpi_sync_control_cache(struct hpi_control_cache *p_cache,
 		break;
 	case HPI_CONTROL_CHANNEL_MODE:
 		/* mode does not return its setting on Set command. */
-		if (phr->error)
-			return;
 		if (phm->u.c.attribute == HPI_CHANNEL_MODE_MODE)
 			pC->u.m.mode = (u16)phm->u.c.param1;
 		break;
@@ -545,20 +539,14 @@ void hpi_sync_control_cache(struct hpi_control_cache *p_cache,
 			pC->u.phantom_power.state = (u16)phm->u.c.param1;
 		break;
 	case HPI_CONTROL_AESEBU_TRANSMITTER:
-		if (phr->error)
-			return;
 		if (phm->u.c.attribute == HPI_AESEBUTX_FORMAT)
 			pC->u.aes3tx.format = phm->u.c.param1;
 		break;
 	case HPI_CONTROL_AESEBU_RECEIVER:
-		if (phr->error)
-			return;
 		if (phm->u.c.attribute == HPI_AESEBURX_FORMAT)
 			pC->u.aes3rx.source = phm->u.c.param1;
 		break;
 	case HPI_CONTROL_SAMPLECLOCK:
-		if (phr->error)
-			return;
 		if (phm->u.c.attribute == HPI_SAMPLECLOCK_SOURCE)
 			pC->u.clk.source = (u16)phm->u.c.param1;
 		else if (phm->u.c.attribute == HPI_SAMPLECLOCK_SOURCE_INDEX)
@@ -590,7 +578,7 @@ struct hpi_control_cache *hpi_alloc_control_cache(const u32
 
 void hpi_free_control_cache(struct hpi_control_cache *p_cache)
 {
-	if ((p_cache->init) && (p_cache->p_info)) {
+	if (p_cache->init) {
 		kfree(p_cache->p_info);
 		p_cache->p_info = NULL;
 		p_cache->init = 0;
-- 
1.7.0.4
