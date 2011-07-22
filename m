From: linux@audioscience.com
Subject: [PATCH 10/15] Add new node and message defines
Date: Fri, 22 Jul 2011 15:52:54 +1200
Message-ID: <1311306785-23116-20-git-send-email-linux@audioscience.com>
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
 sound/pci/asihpi/hpi.h          |   15 +++++++++++----
 sound/pci/asihpi/hpi_internal.h |    6 ++++--
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/sound/pci/asihpi/hpi.h b/sound/pci/asihpi/hpi.h
index 255429c..9538f12 100644
--- a/sound/pci/asihpi/hpi.h
+++ b/sound/pci/asihpi/hpi.h
@@ -211,8 +211,12 @@ enum HPI_SOURCENODES {
 	HPI_SOURCENODE_COBRANET = 109,
 	HPI_SOURCENODE_ANALOG = 110,	     /**< analog input node. */
 	HPI_SOURCENODE_ADAPTER = 111,	     /**< adapter node. */
+	/** RTP stream input node - This node is a destination for
+	    packets of RTP audio samples from other devices. */
+	HPI_SOURCENODE_RTP_DESTINATION = 112,
+	HPI_SOURCENODE_GP_IN = 113,	     /**< general purpose input. */
 	/* !!!Update this  AND hpidebug.h if you add a new sourcenode type!!! */
-	HPI_SOURCENODE_LAST_INDEX = 111	     /**< largest ID */
+	HPI_SOURCENODE_LAST_INDEX = 113	     /**< largest ID */
 		/* AX6 max sourcenode types = 15 */
 };
 
@@ -228,7 +232,7 @@ enum HPI_DESTNODES {
 	HPI_DESTNODE_NONE = 200,
 	/** In Stream (Record) node. */
 	HPI_DESTNODE_ISTREAM = 201,
-	HPI_DESTNODE_LINEOUT = 202,	    /**< line out node. */
+	HPI_DESTNODE_LINEOUT = 202,	     /**< line out node. */
 	HPI_DESTNODE_AESEBU_OUT = 203,	     /**< AES/EBU output node. */
 	HPI_DESTNODE_RF = 204,		     /**< RF output node. */
 	HPI_DESTNODE_SPEAKER = 205,	     /**< speaker output node. */
@@ -236,9 +240,12 @@ enum HPI_DESTNODES {
 	    Audio samples from the device are sent out on the Cobranet network.*/
 	HPI_DESTNODE_COBRANET = 206,
 	HPI_DESTNODE_ANALOG = 207,	     /**< analog output node. */
-
+	/** RTP stream output node - This node is a source for
+	    packets of RTP audio samples that are sent to other devices. */
+	HPI_DESTNODE_RTP_SOURCE = 208,
+	HPI_DESTNODE_GP_OUT = 209,	     /**< general purpose output node. */
 	/* !!!Update this AND hpidebug.h if you add a new destnode type!!! */
-	HPI_DESTNODE_LAST_INDEX = 207	     /**< largest ID */
+	HPI_DESTNODE_LAST_INDEX = 209	     /**< largest ID */
 		/* AX6 max destnode types = 15 */
 };
 
diff --git a/sound/pci/asihpi/hpi_internal.h b/sound/pci/asihpi/hpi_internal.h
index 93d2908..d497030 100644
--- a/sound/pci/asihpi/hpi_internal.h
+++ b/sound/pci/asihpi/hpi_internal.h
@@ -1,7 +1,7 @@
 /******************************************************************************
 
     AudioScience HPI driver
-    Copyright (C) 1997-2010  AudioScience Inc. <support@audioscience.com>
+    Copyright (C) 1997-2011  AudioScience Inc. <support@audioscience.com>
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of version 2 of the GNU General Public License as
@@ -361,7 +361,9 @@ enum HPI_MESSAGE_TYPES {
 	HPI_TYPE_REQUEST = 1,
 	HPI_TYPE_RESPONSE = 2,
 	HPI_TYPE_DATA = 3,
-	HPI_TYPE_SSX2BYPASS_MESSAGE = 4
+	HPI_TYPE_SSX2BYPASS_MESSAGE = 4,
+	HPI_TYPE_COMMAND = 5,
+	HPI_TYPE_NOTIFICATION = 6
 };
 
 enum HPI_OBJECT_TYPES {
-- 
1.7.0.4
