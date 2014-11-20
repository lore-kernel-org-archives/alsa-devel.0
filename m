From: eliot@blennerhassett.gen.nz
Subject: [PATCH 10/10] ALSA: asihpi: used parts of
 message/response are zeroed before use
Date: Thu, 20 Nov 2014 16:22:57 +1300
Message-ID: <1416453777-7155-11-git-send-email-eliot@blennerhassett.gen.nz>
References: <1416453777-7155-1-git-send-email-eliot@blennerhassett.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.clear.net.nz (smtp3.clear.net.nz [203.97.33.64])
 by alsa0.perex.cz (Postfix) with ESMTP id D9B63265884
 for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2014 04:25:44 +0100 (CET)
Received: from mxin1-orange.clear.net.nz
 (lb2-srcnat.clear.net.nz [203.97.32.237])
 by smtp3.clear.net.nz (CLEAR Net Mail)
 with ESMTP id <0NFB007VJIU9ZE20@smtp3.clear.net.nz> for
 alsa-devel@alsa-project.org; Thu, 20 Nov 2014 16:25:42 +1300 (NZDT)
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

Signed-off-by: Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
---
 sound/pci/asihpi/hpimsginit.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/sound/pci/asihpi/hpimsginit.c b/sound/pci/asihpi/hpimsginit.c
index 032d563..7eb6171 100644
--- a/sound/pci/asihpi/hpimsginit.c
+++ b/sound/pci/asihpi/hpimsginit.c
@@ -1,7 +1,7 @@
 /******************************************************************************
 
     AudioScience HPI driver
-    Copyright (C) 1997-2011  AudioScience Inc. <support@audioscience.com>
+    Copyright (C) 1997-2014  AudioScience Inc. <support@audioscience.com>
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of version 2 of the GNU General Public License as
@@ -37,11 +37,15 @@ static u16 gwSSX2_bypass;
 static void hpi_init_message(struct hpi_message *phm, u16 object,
 	u16 function)
 {
-	memset(phm, 0, sizeof(*phm));
+	u16 size;
+
 	if ((object > 0) && (object <= HPI_OBJ_MAXINDEX))
-		phm->size = msg_size[object];
+		size = msg_size[object];
 	else
-		phm->size = sizeof(*phm);
+		size = sizeof(*phm);
+
+	memset(phm, 0, size);
+	phm->size = size;
 
 	if (gwSSX2_bypass)
 		phm->type = HPI_TYPE_SSX2BYPASS_MESSAGE;
@@ -60,12 +64,16 @@ static void hpi_init_message(struct hpi_message *phm, u16 object,
 void hpi_init_response(struct hpi_response *phr, u16 object, u16 function,
 	u16 error)
 {
-	memset(phr, 0, sizeof(*phr));
-	phr->type = HPI_TYPE_RESPONSE;
+	u16 size;
+
 	if ((object > 0) && (object <= HPI_OBJ_MAXINDEX))
-		phr->size = res_size[object];
+		size = res_size[object];
 	else
-		phr->size = sizeof(*phr);
+		size = sizeof(*phr);
+
+	memset(phr, 0, sizeof(*phr));
+	phr->size = size;
+	phr->type = HPI_TYPE_RESPONSE;
 	phr->object = object;
 	phr->function = function;
 	phr->error = error;
@@ -86,7 +94,7 @@ void hpi_init_message_response(struct hpi_message *phm,
 static void hpi_init_messageV1(struct hpi_message_header *phm, u16 size,
 	u16 object, u16 function)
 {
-	memset(phm, 0, sizeof(*phm));
+	memset(phm, 0, size);
 	if ((object > 0) && (object <= HPI_OBJ_MAXINDEX)) {
 		phm->size = size;
 		phm->type = HPI_TYPE_REQUEST;
@@ -100,7 +108,9 @@ static void hpi_init_messageV1(struct hpi_message_header *phm, u16 size,
 void hpi_init_responseV1(struct hpi_response_header *phr, u16 size,
 	u16 object, u16 function)
 {
-	memset(phr, 0, sizeof(*phr));
+	(void)object;
+	(void)function;
+	memset(phr, 0, size);
 	phr->size = size;
 	phr->version = 1;
 	phr->type = HPI_TYPE_RESPONSE;
-- 
1.9.1
