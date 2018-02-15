From: Tim Harvey <tharvey-UMMOYl/HMS+akBO8gow8eQ@public.gmane.org>
Subject: [PATCH v12 3/8] media: add digital video decoder entity functions
Date: Thu, 15 Feb 2018 08:39:22 -0800
Message-ID: <1518712767-21928-4-git-send-email-tharvey@gateworks.com>
References: <1518712767-21928-1-git-send-email-tharvey@gateworks.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1518712767-21928-1-git-send-email-tharvey-UMMOYl/HMS+akBO8gow8eQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Steve Longerbeam <slongerbeam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Hans Verkuil <hansverk-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>, Mauro Carvalho Chehab <mchehab-JsYNTwtnfakRB7SZvlqPiA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Add a new media entity function definition for digital TV decoders:
MEDIA_ENT_F_DTV_DECODER

Signed-off-by: Tim Harvey <tharvey-UMMOYl/HMS+akBO8gow8eQ@public.gmane.org>
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
