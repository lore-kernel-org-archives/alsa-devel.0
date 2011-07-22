From: linux@audioscience.com
Subject: [PATCH 12/15] Use size_t for sizeof result
Date: Fri, 22 Jul 2011 15:52:59 +1200
Message-ID: <1311306785-23116-25-git-send-email-linux@audioscience.com>
References: <1311306785-23116-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <1311306785-23116-1-git-send-email-linux@audioscience.com>
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
 sound/pci/asihpi/hpicmn.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/asihpi/hpicmn.c b/sound/pci/asihpi/hpicmn.c
index 808f184..65b7ca1 100644
--- a/sound/pci/asihpi/hpicmn.c
+++ b/sound/pci/asihpi/hpicmn.c
@@ -315,7 +315,7 @@ short hpi_check_control_cache(struct hpi_control_cache *p_cache,
 	short found = 1;
 	struct hpi_control_cache_info *pI;
 	struct hpi_control_cache_single *pC;
-	u16 response_size;
+	size_t response_size;
 	if (!find_control(phm->obj_index, p_cache, &pI)) {
 		HPI_DEBUG_LOG(VERBOSE,
 			"HPICMN find_control() failed for adap %d\n",
@@ -532,7 +532,7 @@ short hpi_check_control_cache(struct hpi_control_cache *p_cache,
 		pI->control_index, pI->control_type, phm->u.c.attribute);
 
 	if (found)
-		phr->size = response_size;
+		phr->size = (u16)response_size;
 
 	return found;
 }
-- 
1.7.0.4
