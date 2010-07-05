From: linux@audioscience.com
Subject: [PATCH 5/6] Minor HPI error handling fixes.
Date: Tue, 06 Jul 2010 08:37:10 +1200
Message-ID: <1278362231-10160-6-git-send-email-linux@audioscience.com>
References: <1278362231-10160-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <1278362231-10160-1-git-send-email-linux@audioscience.com>
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

Handle errors in tuner level caching,
Ccorrect error code for aesebu rx status.

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 pci/asihpi/hpicmn.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/pci/asihpi/hpicmn.c b/pci/asihpi/hpicmn.c
index fcd6453..dda4f1c 100644
--- a/pci/asihpi/hpicmn.c
+++ b/pci/asihpi/hpicmn.c
@@ -353,7 +353,12 @@ short hpi_check_control_cache(struct hpi_control_cache *p_cache,
 			phr->u.c.param1 = pC->u.t.band;
 		else if ((phm->u.c.attribute == HPI_TUNER_LEVEL)
 			&& (phm->u.c.param1 == HPI_TUNER_LEVEL_AVERAGE))
-			phr->u.c.param1 = pC->u.t.level;
+			if (pC->u.t.level == HPI_ERROR_ILLEGAL_CACHE_VALUE) {
+				phr->u.c.param1 = 0;
+				phr->error =
+					HPI_ERROR_INVALID_CONTROL_ATTRIBUTE;
+			} else
+				phr->u.c.param1 = pC->u.t.level;
 		else
 			found = 0;
 		break;
@@ -397,7 +402,8 @@ short hpi_check_control_cache(struct hpi_control_cache *p_cache,
 			if (pC->u.clk.source_index ==
 				HPI_ERROR_ILLEGAL_CACHE_VALUE) {
 				phr->u.c.param1 = 0;
-				phr->error = HPI_ERROR_INVALID_OPERATION;
+				phr->error =
+					HPI_ERROR_INVALID_CONTROL_ATTRIBUTE;
 			} else
 				phr->u.c.param1 = pC->u.clk.source_index;
 		} else if (phm->u.c.attribute == HPI_SAMPLECLOCK_SAMPLERATE)
-- 
1.7.0.4
