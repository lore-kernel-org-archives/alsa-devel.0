From: linux@audioscience.com
Subject: [PATCH 06/21] Correct stray capital letters in
	identifier.
Date: Thu, 22 Dec 2011 13:38:36 +1300
Message-ID: <1324514331-22570-7-git-send-email-linux@audioscience.com>
References: <1324514331-22570-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id E6E4A103C0B
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2011 01:40:04 +0100 (CET)
Received: from localhost.localdomain
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0LWK00D3EXTHNQ40@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Thu, 22 Dec 2011 13:39:24 +1300 (NZDT)
In-reply-to: <1324514331-22570-1-git-send-email-linux@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eblennerhassett@audioscience.com>

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 sound/pci/asihpi/hpi6205.c      |   12 ++++++------
 sound/pci/asihpi/hpi_internal.h |    4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/pci/asihpi/hpi6205.c b/sound/pci/asihpi/hpi6205.c
index 7f65602..95d1cd5 100644
--- a/sound/pci/asihpi/hpi6205.c
+++ b/sound/pci/asihpi/hpi6205.c
@@ -803,8 +803,8 @@ static void outstream_host_buffer_allocate(struct hpi_adapter_obj *pao,
 			obj_index];
 		status->samples_processed = 0;
 		status->stream_state = HPI_STATE_STOPPED;
-		status->dSP_index = 0;
-		status->host_index = status->dSP_index;
+		status->dsp_index = 0;
+		status->host_index = status->dsp_index;
 		status->size_in_bytes = phm->u.d.u.buffer.buffer_size;
 		status->auxiliary_data_available = 0;
 
@@ -878,7 +878,7 @@ static void outstream_host_buffer_free(struct hpi_adapter_obj *pao,
 static u32 outstream_get_space_available(struct hpi_hostbuffer_status *status)
 {
 	return status->size_in_bytes - (status->host_index -
-		status->dSP_index);
+		status->dsp_index);
 }
 
 static void outstream_write(struct hpi_adapter_obj *pao,
@@ -1080,8 +1080,8 @@ static void instream_host_buffer_allocate(struct hpi_adapter_obj *pao,
 			obj_index];
 		status->samples_processed = 0;
 		status->stream_state = HPI_STATE_STOPPED;
-		status->dSP_index = 0;
-		status->host_index = status->dSP_index;
+		status->dsp_index = 0;
+		status->host_index = status->dsp_index;
 		status->size_in_bytes = phm->u.d.u.buffer.buffer_size;
 		status->auxiliary_data_available = 0;
 
@@ -1162,7 +1162,7 @@ static void instream_start(struct hpi_adapter_obj *pao,
 
 static u32 instream_get_bytes_available(struct hpi_hostbuffer_status *status)
 {
-	return status->dSP_index - status->host_index;
+	return status->dsp_index - status->host_index;
 }
 
 static void instream_read(struct hpi_adapter_obj *pao,
diff --git a/sound/pci/asihpi/hpi_internal.h b/sound/pci/asihpi/hpi_internal.h
index d497030..e5e9e33 100644
--- a/sound/pci/asihpi/hpi_internal.h
+++ b/sound/pci/asihpi/hpi_internal.h
@@ -618,7 +618,7 @@ struct hpi_hostbuffer_status {
 	u32 auxiliary_data_available;
 	u32 stream_state;
 	/* DSP index in to the host bus master buffer. */
-	u32 dSP_index;
+	u32 dsp_index;
 	/* Host index in to the host bus master buffer. */
 	u32 host_index;
 	u32 size_in_bytes;
@@ -1461,7 +1461,7 @@ struct hpi_control_cache_pad {
 /* 2^N sized FIFO buffer (internal to HPI<->DSP interaction) */
 struct hpi_fifo_buffer {
 	u32 size;
-	u32 dSP_index;
+	u32 dsp_index;
 	u32 host_index;
 };
 
-- 
1.7.0.4
