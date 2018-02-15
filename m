From: Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v13 3/8] media: add digital video decoder
	entity functions
Date: Thu, 15 Feb 2018 09:55:31 -0800
Message-ID: <1518717336-6271-4-git-send-email-tharvey@gateworks.com>
References: <1518717336-6271-1-git-send-email-tharvey@gateworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f65.google.com (mail-pg0-f65.google.com [74.125.83.65])
 by alsa0.perex.cz (Postfix) with ESMTP id EA345267CE5
 for <alsa-devel@alsa-project.org>; Thu, 15 Feb 2018 18:56:16 +0100 (CET)
Received: by mail-pg0-f65.google.com with SMTP id f6so337194pgs.10
 for <alsa-devel@alsa-project.org>; Thu, 15 Feb 2018 09:56:16 -0800 (PST)
In-Reply-To: <1518717336-6271-1-git-send-email-tharvey@gateworks.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-media@vger.kernel.org, alsa-devel@alsa-project.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Hans Verkuil <hansverk@cisco.com>, Mauro Carvalho Chehab <mchehab@s-opensource.com>, Philipp Zabel <p.zabel@pengutronix.de>, Steve Longerbeam <slongerbeam@gmail.com>, shawnguo@kernel.org
List-Id: alsa-devel@alsa-project.org

Add a new media entity function definition for digital TV decoders:
MEDIA_ENT_F_DTV_DECODER

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 Documentation/media/uapi/mediactl/media-types.rst | 11 +++++++++++
 include/uapi/linux/media.h                        |  5 +++++
 2 files changed, 16 insertions(+)

diff --git a/Documentation/media/uapi/mediactl/media-types.rst b/Documentation/media/uapi/mediactl/media-types.rst
index 8d64b0c..195400e 100644
--- a/Documentation/media/uapi/mediactl/media-types.rst
+++ b/Documentation/media/uapi/mediactl/media-types.rst
@@ -321,6 +321,17 @@ Types and flags used to represent the media graph elements
          MIPI CSI-2, ...), and outputs them on its source pad to an output
          video bus of another type (eDP, MIPI CSI-2, parallel, ...).
 
+    -  ..  row 31
+
+       ..  _MEDIA-ENT-F-DTV-DECODER:
+
+       -  ``MEDIA_ENT_F_DTV_DECODER``
+
+       -  Digital video decoder. The basic function of the video decoder is
+	  to accept digital video from a wide variety of sources
+	  and output it in some digital video standard, with appropriate
+	  timing signals.
+
 ..  tabularcolumns:: |p{5.5cm}|p{12.0cm}|
 
 .. _media-entity-flag:
diff --git a/include/uapi/linux/media.h b/include/uapi/linux/media.h
index b9b9446..2f12328 100644
--- a/include/uapi/linux/media.h
+++ b/include/uapi/linux/media.h
@@ -110,6 +110,11 @@ struct media_device_info {
 #define MEDIA_ENT_F_VID_IF_BRIDGE		(MEDIA_ENT_F_BASE + 0x5002)
 
 /*
+ * Digital video decoder entities
+ */
+#define MEDIA_ENT_F_DTV_DECODER			(MEDIA_ENT_F_BASE + 0x6001)
+
+/*
  * Connectors
  */
 /* It is a responsibility of the entity drivers to add connectors and links */
-- 
2.7.4
