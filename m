From: linux@audioscience.com
Subject: [PATCH 02/15] ALSA: asihpi - Increase request and
	response buffer sizes
Date: Fri, 22 Jul 2011 15:52:38 +1200
Message-ID: <1311306785-23116-4-git-send-email-linux@audioscience.com>
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

Allow for up to 256 bytes of extra data on top of standard hpi
request and response sizes.

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 sound/pci/asihpi/hpi6205.c |   15 ++++++++-------
 sound/pci/asihpi/hpi6205.h |   25 +++++++++++++++++++------
 sound/pci/asihpi/hpicmn.c  |   13 +++++++------
 3 files changed, 34 insertions(+), 19 deletions(-)

diff --git a/sound/pci/asihpi/hpi6205.c b/sound/pci/asihpi/hpi6205.c
index faff9e3..8831a6f 100644
--- a/sound/pci/asihpi/hpi6205.c
+++ b/sound/pci/asihpi/hpi6205.c
@@ -2085,13 +2085,13 @@ static u16 message_response_sequence(struct hpi_adapter_obj *pao,
 	u16 err = 0;
 
 	message_count++;
-	if (phm->size > sizeof(interface->u)) {
+	if (phm->size > sizeof(interface->u.message_buffer)) {
 		phr->error = HPI_ERROR_MESSAGE_BUFFER_TOO_SMALL;
-		phr->specific_error = sizeof(interface->u);
+		phr->specific_error = sizeof(interface->u.message_buffer);
 		phr->size = sizeof(struct hpi_response_header);
 		HPI_DEBUG_LOG(ERROR,
 			"message len %d too big for buffer %zd \n", phm->size,
-			sizeof(interface->u));
+			sizeof(interface->u.message_buffer));
 		return 0;
 	}
 
@@ -2123,18 +2123,19 @@ static u16 message_response_sequence(struct hpi_adapter_obj *pao,
 
 	/* read the result */
 	if (time_out) {
-		if (interface->u.response_buffer.size <= phr->size)
+		if (interface->u.response_buffer.response.size <= phr->size)
 			memcpy(phr, &interface->u.response_buffer,
-				interface->u.response_buffer.size);
+				interface->u.response_buffer.response.size);
 		else {
 			HPI_DEBUG_LOG(ERROR,
 				"response len %d too big for buffer %d\n",
-				interface->u.response_buffer.size, phr->size);
+				interface->u.response_buffer.response.size,
+				phr->size);
 			memcpy(phr, &interface->u.response_buffer,
 				sizeof(struct hpi_response_header));
 			phr->error = HPI_ERROR_RESPONSE_BUFFER_TOO_SMALL;
 			phr->specific_error =
-				interface->u.response_buffer.size;
+				interface->u.response_buffer.response.size;
 			phr->size = sizeof(struct hpi_response_header);
 		}
 	}
diff --git a/sound/pci/asihpi/hpi6205.h b/sound/pci/asihpi/hpi6205.h
index df2f02c..ec0827b 100644
--- a/sound/pci/asihpi/hpi6205.h
+++ b/sound/pci/asihpi/hpi6205.h
@@ -1,7 +1,7 @@
 /*****************************************************************************
 
     AudioScience HPI driver
-    Copyright (C) 1997-2010  AudioScience Inc. <support@audioscience.com>
+    Copyright (C) 1997-2011  AudioScience Inc. <support@audioscience.com>
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of version 2 of the GNU General Public License as
@@ -70,15 +70,28 @@ The Host located memory buffer that the 6205 will bus master
 in and out of.
 ************************************************************/
 #define HPI6205_SIZEOF_DATA (16*1024)
+
+struct message_buffer_6205 {
+	struct hpi_message message;
+	char data[256];
+};
+
+struct response_buffer_6205 {
+	struct hpi_response response;
+	char data[256];
+};
+
+union buffer_6205 {
+	struct message_buffer_6205 message_buffer;
+	struct response_buffer_6205 response_buffer;
+	u8 b_data[HPI6205_SIZEOF_DATA];
+};
+
 struct bus_master_interface {
 	u32 host_cmd;
 	u32 dsp_ack;
 	u32 transfer_size_in_bytes;
-	union {
-		struct hpi_message_header message_buffer;
-		struct hpi_response_header response_buffer;
-		u8 b_data[HPI6205_SIZEOF_DATA];
-	} u;
+	union buffer_6205 u;
 	struct controlcache_6205 control_cache;
 	struct async_event_buffer_6205 async_buffer;
 	struct hpi_hostbuffer_status
diff --git a/sound/pci/asihpi/hpicmn.c b/sound/pci/asihpi/hpicmn.c
index 801dcd8..fe2e1ae 100644
--- a/sound/pci/asihpi/hpicmn.c
+++ b/sound/pci/asihpi/hpicmn.c
@@ -315,8 +315,7 @@ short hpi_check_control_cache(struct hpi_control_cache *p_cache,
 	short found = 1;
 	struct hpi_control_cache_info *pI;
 	struct hpi_control_cache_single *pC;
-	struct hpi_control_cache_pad *p_pad;
-
+	u16 response_size;
 	if (!find_control(phm->obj_index, p_cache, &pI)) {
 		HPI_DEBUG_LOG(VERBOSE,
 			"HPICMN find_control() failed for adap %d\n",
@@ -326,11 +325,15 @@ short hpi_check_control_cache(struct hpi_control_cache *p_cache,
 
 	phr->error = 0;
 
+	/* set the default response size */
+	response_size =
+		sizeof(struct hpi_response_header) +
+		sizeof(struct hpi_control_res);
+
 	/* pC is the default cached control strucure. May be cast to
 	   something else in the following switch statement.
 	 */
 	pC = (struct hpi_control_cache_single *)pI;
-	p_pad = (struct hpi_control_cache_pad *)pI;
 
 	switch (pI->control_type) {
 
@@ -529,9 +532,7 @@ short hpi_check_control_cache(struct hpi_control_cache *p_cache,
 		pI->control_index, pI->control_type, phm->u.c.attribute);
 
 	if (found)
-		phr->size =
-			sizeof(struct hpi_response_header) +
-			sizeof(struct hpi_control_res);
+		phr->size = response_size;
 
 	return found;
 }
-- 
1.7.0.4
