From: eliot@blennerhassett.gen.nz
Subject: [PATCH 07/10] ALSA: asihpi: Turn off msg/resp logging
 after DSP has crashed.
Date: Thu, 20 Nov 2014 16:22:54 +1300
Message-ID: <1416453777-7155-8-git-send-email-eliot@blennerhassett.gen.nz>
References: <1416453777-7155-1-git-send-email-eliot@blennerhassett.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.clear.net.nz (smtp3.clear.net.nz [203.97.33.64])
 by alsa0.perex.cz (Postfix) with ESMTP id 2741926587C
 for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2014 04:25:44 +0100 (CET)
Received: from mxin1-orange.clear.net.nz
 (lb2-srcnat.clear.net.nz [203.97.32.237])
 by smtp3.clear.net.nz (CLEAR Net Mail)
 with ESMTP id <0NFB007V7IU4ZE20@smtp3.clear.net.nz> for
 alsa-devel@alsa-project.org; Thu, 20 Nov 2014 16:25:41 +1300 (NZDT)
In-reply-to: <1416453777-7155-1-git-send-email-eliot@blennerhassett.gen.nz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eliot@blennerhassett.gen.nz>

Prevents spewing of useless messages if app keeps trying to
access the card.

Signed-off-by: Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
---
 sound/pci/asihpi/hpimsgx.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/sound/pci/asihpi/hpimsgx.c b/sound/pci/asihpi/hpimsgx.c
index d4790dd..736f453 100644
--- a/sound/pci/asihpi/hpimsgx.c
+++ b/sound/pci/asihpi/hpimsgx.c
@@ -1,7 +1,7 @@
 /******************************************************************************
 
     AudioScience HPI driver
-    Copyright (C) 1997-2011  AudioScience Inc. <support@audioscience.com>
+    Copyright (C) 1997-2014  AudioScience Inc. <support@audioscience.com>
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of version 2 of the GNU General Public License as
@@ -35,6 +35,7 @@ static struct pci_device_id asihpi_pci_tbl[] = {
 static struct hpios_spinlock msgx_lock;
 
 static hpi_handler_func *hpi_entry_points[HPI_MAX_ADAPTERS];
+static int logging_enabled = 1;
 
 static hpi_handler_func *hpi_lookup_entry_point_function(const struct hpi_pci
 	*pci_info)
@@ -312,7 +313,9 @@ static void instream_message(struct hpi_message *phm,
 void hpi_send_recv_ex(struct hpi_message *phm, struct hpi_response *phr,
 	void *h_owner)
 {
-	HPI_DEBUG_MESSAGE(DEBUG, phm);
+
+	if (logging_enabled)
+		HPI_DEBUG_MESSAGE(DEBUG, phm);
 
 	if (phm->type != HPI_TYPE_REQUEST) {
 		hpi_init_response(phr, phm->object, phm->function,
@@ -352,8 +355,14 @@ void hpi_send_recv_ex(struct hpi_message *phm, struct hpi_response *phr,
 		hw_entry_point(phm, phr);
 		break;
 	}
-	HPI_DEBUG_RESPONSE(phr);
 
+	if (logging_enabled)
+		HPI_DEBUG_RESPONSE(phr);
+
+	if (phr->error >= HPI_ERROR_DSP_COMMUNICATION) {
+		hpi_debug_level_set(HPI_DEBUG_LEVEL_ERROR);
+		logging_enabled = 0;
+	}
 }
 
 static void adapter_open(struct hpi_message *phm, struct hpi_response *phr)
-- 
1.9.1
