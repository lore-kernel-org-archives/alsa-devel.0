From: linux@audioscience.com
Subject: [PATCH 19/28] Allow adapters with duplicate index
 jumpers to be discovered.
Date: Thu, 10 Feb 2011 17:26:12 +1300
Message-ID: <1297311981-30448-20-git-send-email-linux@audioscience.com>
References: <1297311981-30448-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <1297311981-30448-1-git-send-email-linux@audioscience.com>
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
 pci/asihpi/hpicmn.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/pci/asihpi/hpicmn.c b/pci/asihpi/hpicmn.c
index 4b3f476..3e9c5c2 100644
--- a/pci/asihpi/hpicmn.c
+++ b/pci/asihpi/hpicmn.c
@@ -78,8 +78,18 @@ u16 hpi_add_adapter(struct hpi_adapter_obj *pao)
 	}
 
 	if (adapters.adapter[pao->index].adapter_type) {
-		{
-			retval = HPI_DUPLICATE_ADAPTER_NUMBER;
+		int a;
+		for (a = HPI_MAX_ADAPTERS - 1; a >= 0; a--) {
+			if (!adapters.adapter[a].adapter_type) {
+				HPI_DEBUG_LOG(WARNING,
+					"ASI%X duplicate index %d moved to %d\n",
+					pao->adapter_type, pao->index, a);
+				pao->index = a;
+				break;
+			}
+		}
+		if (a < 0) {
+			retval = HPI_ERROR_DUPLICATE_ADAPTER_NUMBER;
 			goto unlock;
 		}
 	}
-- 
1.7.0.4
