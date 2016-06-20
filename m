From: Michel Normand <normand@linux.vnet.ibm.com>
Subject: [PATCH] gcc6 narrowing error
Date: Mon, 20 Jun 2016 10:10:24 +0200
Message-ID: <1466410224-19466-2-git-send-email-normand@linux.vnet.ibm.com>
References: <1466410224-19466-1-git-send-email-normand@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by alsa0.perex.cz (Postfix) with ESMTP id A2387261691
 for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2016 10:10:34 +0200 (CEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5K84FOX029591
 for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2016 04:10:33 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23n2u5pvpy-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2016 04:10:33 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <alsa-devel@alsa-project.org> from <normand@linux.vnet.ibm.com>;
 Mon, 20 Jun 2016 09:10:30 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3DB622190056
 for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2016 09:10:00 +0100 (BST)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
 [9.149.37.249])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5K8ATNN22413814
 for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2016 08:10:29 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5K8ATCo016960
 for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2016 02:10:29 -0600
Received: from mnow541.ibm.com (sig-9-83-70-219.evts.uk.ibm.com [9.83.70.219])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with
 ESMTP id u5K8APws016763
 for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2016 02:10:28 -0600
In-Reply-To: <1466410224-19466-1-git-send-email-normand@linux.vnet.ibm.com>
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
List-Id: alsa-devel@alsa-project.org

gcc6 narrowing error compiling for PowerPC archi
===
[   51s] Cus428Midi.cc: At global scope:
[   51s] Cus428Midi.cc:83:1: error: narrowing conversion of '-1' from 'int' to 'char' inside { } [-Wnarrowing]
[   51s]  };
===

proposed patch as suggested in
https://gcc.gnu.org/gcc-6/porting_to.html

Signed-off-by: Michel Normand <normand@linux.vnet.ibm.com>
---
 hdspmixer/src/channelmap.cxx | 158 +++++++++++++++++++++----------------------
 us428control/Cus428Midi.cc   |  30 ++++----
 2 files changed, 94 insertions(+), 94 deletions(-)

diff --git a/hdspmixer/src/channelmap.cxx b/hdspmixer/src/channelmap.cxx
index b7bdded..bfb136d 100644
--- a/hdspmixer/src/channelmap.cxx
+++ b/hdspmixer/src/channelmap.cxx
@@ -55,7 +55,7 @@ char channel_map_mf_ss[26] = {
 	16, 17, 18, 19, 20, 21, 22, 23, /* ADAT */
 	24, 25,				/* SPDIF */
 	26, 27,             /* Phones L+R, only a destination channel */
-	-1, -1, -1, -1, -1, -1
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1
 };
 
 // Digiface/Multiface
@@ -65,13 +65,13 @@ char meter_map_ds[26] = {
 	16, 17, 18, 19, /* ADAT on Multiface, ADAT3 on Digiface */
 	24, 25, /* SPDIF */
 	26, 27, /* Headphones */
-	-1, -1, -1, -1, -1, -1, -1, -1, -1, -1
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1
 };
 
 char channel_map_ds[26] = {
 	1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23,
 	24, 25,
-	-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1
 };
 
 char dest_map_ds[8] = {
@@ -84,10 +84,10 @@ char dest_map_rpm[3] = {
 };
 
 char channel_map_rpm[26] = {
-     0,  1,  2,  3,  4,  5, -1, -1,
-    -1, -1, -1, -1, -1, -1, -1, -1,
-    -1, -1, -1, -1, -1, -1, -1, -1,
-    -1, -1
+     0,  1,  2,  3,  4,  5, (char)-1, (char)-1,
+    (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
+    (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
+    (char)-1, (char)-1
 };
 
 // HDSP 9652
@@ -158,21 +158,21 @@ char channel_map_unity_ds[HDSPM_MAX_CHANNELS] = {
 	16, 18, 20, 22, 24, 26, 28, 30,
 	32, 34, 36, 38, 40, 42, 44, 46,
 	48, 50, 52, 54, 56, 58, 60, 62,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
 };
 
 char channel_map_unity_qs[HDSPM_MAX_CHANNELS] = {
 	0, 4, 8, 12, 16, 20, 24, 28,
 	32, 36, 40, 44, 48, 52, 56, 60,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
 };
 
 // HDSPe RayDAT
@@ -208,10 +208,10 @@ char channel_map_raydat_ss[HDSPM_MAX_CHANNELS] = {
 	28, 29, 30, 31, 32, 33, 34, 35,	/* ADAT 4 */
 	0, 1,			/* AES */
 	2, 3,			/* SPDIF */
-	-1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
+	(char)-1, (char)-1, (char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
 };
 
 char channel_map_raydat_ds[HDSPM_MAX_CHANNELS] = {
@@ -221,12 +221,12 @@ char channel_map_raydat_ds[HDSPM_MAX_CHANNELS] = {
 	16, 17, 18, 19,		/* ADAT 4 */
 	0, 1,			/* AES */
 	2, 3,			/* SPDIF */
-	-1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
+	(char)-1, (char)-1, (char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
 };
 
 char channel_map_raydat_qs[HDSPM_MAX_CHANNELS] = {
@@ -236,13 +236,13 @@ char channel_map_raydat_qs[HDSPM_MAX_CHANNELS] = {
 	10, 11,			/* ADAT 4 */
 	0, 1,			/* AES */
 	2, 3,			/* SPDIF */
-	-1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
+	(char)-1, (char)-1, (char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
 };
 
 // HDSPe AIO
@@ -284,12 +284,12 @@ char channel_map_aio_in_ss[HDSPM_MAX_CHANNELS] = {
 	10, 11,			/* spdif in */
 	12, 13, 14, 15, 16, 17, 18, 19,	/* ADAT in */
 	2, 3, 4, 5,		/* AEB */
-	-1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
 };
 
 char channel_map_aio_out_ss[HDSPM_MAX_CHANNELS] = {
@@ -299,12 +299,12 @@ char channel_map_aio_out_ss[HDSPM_MAX_CHANNELS] = {
 	12, 13, 14, 15, 16, 17, 18, 19,	/* ADAT out */
 	6, 7,			/* phone out */
 	2, 3, 4, 5,		/* AEB */
-	-1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
+	(char)-1, (char)-1, (char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
 };
 
 char channel_map_aio_in_ds[HDSPM_MAX_CHANNELS] = {
@@ -313,13 +313,13 @@ char channel_map_aio_in_ds[HDSPM_MAX_CHANNELS] = {
 	10, 11,			/* spdif in */
 	12, 14, 16, 18,		/* adat in */
 	2, 3, 4, 5,		/* AEB */
-	-1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1
+	(char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1
 };
 
 char channel_map_aio_out_ds[HDSPM_MAX_CHANNELS] = {
@@ -329,12 +329,12 @@ char channel_map_aio_out_ds[HDSPM_MAX_CHANNELS] = {
 	12, 14, 16, 18,		/* adat out */
 	6, 7,			/* phone out */
 	2, 3, 4, 5,		/* AEB */
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1
 };
 
 char channel_map_aio_in_qs[HDSPM_MAX_CHANNELS] = {
@@ -343,13 +343,13 @@ char channel_map_aio_in_qs[HDSPM_MAX_CHANNELS] = {
 	10, 11,			/* spdif in */
 	12, 16,			/* adat in */
 	2, 3, 4, 5,		/* AEB */
-	-1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1
+	(char)-1, (char)-1, (char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1
 };
 
 char channel_map_aio_out_qs[HDSPM_MAX_CHANNELS] = {
@@ -359,13 +359,13 @@ char channel_map_aio_out_qs[HDSPM_MAX_CHANNELS] = {
 	12, 16,			/* adat out */
 	6, 7,			/* phone out */
 	2, 3, 4, 5,		/* AEB */
-	-1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1
+	(char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1
 };
 
 // HDSP AES32 and HDSPe AES
@@ -383,11 +383,11 @@ char channel_map_aes32[HDSPM_MAX_CHANNELS] = {
 	10, 11,			/* AES 6 */
 	12, 13,			/* AES 7 */
 	14, 15,			/* AES 8 */
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1,
+	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1
 };
 
diff --git a/us428control/Cus428Midi.cc b/us428control/Cus428Midi.cc
index b9e6783..374eb29 100644
--- a/us428control/Cus428Midi.cc
+++ b/us428control/Cus428Midi.cc
@@ -32,22 +32,22 @@ char Cus428Midi::KnobParam[] = {
 	0x2A,
 	0x29,
 	0x28,
-	-1,
+	(char)-1,
 	0x10,
 	0x11,
 	0x18,
 	0x19,
 	0x1A,
-	-1,
-	-1,
-	-1,
-	-1,
+	(char)-1,
+	(char)-1,
+	(char)-1,
+	(char)-1,
 	0x2C,
 	0x2D,
 	0x2E,
 	0x2F,
-	-1,
-	-1,
+	(char)-1,
+	(char)-1,
 	0x20,
 	0x21,
 	0x22,
@@ -64,14 +64,14 @@ char Cus428Midi::KnobParam[] = {
 	5,
 	6,
 	7,
-	-1,
-	-1,
-	-1,
-	-1,
-	-1,
-	-1,
-	-1,
-	-1,
+	(char)-1,
+	(char)-1,
+	(char)-1,
+	(char)-1,
+	(char)-1,
+	(char)-1,
+	(char)-1,
+	(char)-1,
 	0x30,
 	0x31,
 	0x32,
-- 
1.9.1
