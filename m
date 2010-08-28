From: linux@audioscience.com
Subject: [PATCH] Return hw error directly from oustream_write.
Date: Sat, 28 Aug 2010 19:52:24 +1200
Message-ID: <1282981944-2781-1-git-send-email-linux@audioscience.com>
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
To: patch@alsa-project.org
Cc: tiwai@suse.de, Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eblennerhassett@audioscience.com>

If hw error is ignored, status is updated with invalid info.

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 sound/pci/asihpi/hpi6205.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/pci/asihpi/hpi6205.c b/sound/pci/asihpi/hpi6205.c
index 3b44134..22c5fc6 100644
--- a/sound/pci/asihpi/hpi6205.c
+++ b/sound/pci/asihpi/hpi6205.c
@@ -941,8 +941,7 @@ static void outstream_host_buffer_free(struct hpi_adapter_obj *pao,
 
 }
 
-static u32 outstream_get_space_available(struct hpi_hostbuffer_status
-	*status)
+static u32 outstream_get_space_available(struct hpi_hostbuffer_status *status)
 {
 	return status->size_in_bytes - (status->host_index -
 		status->dSP_index);
@@ -987,6 +986,10 @@ static void outstream_write(struct hpi_adapter_obj *pao,
 		/* write it */
 		phm->function = HPI_OSTREAM_WRITE;
 		hw_message(pao, phm, phr);
+
+		if (phr->error)
+			return;
+
 		/* update status information that the DSP would typically
 		 * update (and will update next time the DSP
 		 * buffer update task reads data from the host BBM buffer)
-- 
1.7.0.4
