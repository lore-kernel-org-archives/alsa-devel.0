From: linux@audioscience.com
Subject: [PATCH 08/15] Fix minor typos and spelling
Date: Fri, 22 Jul 2011 15:52:51 +1200
Message-ID: <1311306785-23116-17-git-send-email-linux@audioscience.com>
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
 sound/pci/asihpi/hpi_internal.h |    2 +-
 sound/pci/asihpi/hpicmn.c       |    2 +-
 sound/pci/asihpi/hpimsgx.c      |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/pci/asihpi/hpi_internal.h b/sound/pci/asihpi/hpi_internal.h
index 332fb59..93d2908 100644
--- a/sound/pci/asihpi/hpi_internal.h
+++ b/sound/pci/asihpi/hpi_internal.h
@@ -602,7 +602,7 @@ struct hpi_data_compat32 {
 #endif
 
 struct hpi_buffer {
-  /** placehoder for backward compatibility (see dwBufferSize) */
+  /** placeholder for backward compatibility (see dwBufferSize) */
 	struct hpi_msg_format reserved;
 	u32 command; /**< HPI_BUFFER_CMD_xxx*/
 	u32 pci_address; /**< PCI physical address of buffer for DSP DMA */
diff --git a/sound/pci/asihpi/hpicmn.c b/sound/pci/asihpi/hpicmn.c
index fe2e1ae..808f184 100644
--- a/sound/pci/asihpi/hpicmn.c
+++ b/sound/pci/asihpi/hpicmn.c
@@ -57,7 +57,7 @@ u16 hpi_validate_response(struct hpi_message *phm, struct hpi_response *phr)
 	}
 
 	if (phr->function != phm->function) {
-		HPI_DEBUG_LOG(ERROR, "header type %d invalid\n",
+		HPI_DEBUG_LOG(ERROR, "header function %d invalid\n",
 			phr->function);
 		return HPI_ERROR_INVALID_RESPONSE;
 	}
diff --git a/sound/pci/asihpi/hpimsgx.c b/sound/pci/asihpi/hpimsgx.c
index 83b7e73..2e77942 100644
--- a/sound/pci/asihpi/hpimsgx.c
+++ b/sound/pci/asihpi/hpimsgx.c
@@ -16,7 +16,7 @@
     along with this program; if not, write to the Free Software
     Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 
-Extended Message Function With Response Cacheing
+Extended Message Function With Response Caching
 
 (C) Copyright AudioScience Inc. 2002
 *****************************************************************************/
-- 
1.7.0.4
