From: shuah@kernel.org
Subject: [RFC PATCH v8 3/4] media: media.h: Enable ALSA MEDIA_INTF_T* interface types
Date: Thu,  1 Nov 2018 18:31:32 -0600
Message-ID: <0f47952fd84fd275646e3c9a18e208ced08dd6bb.1541109584.git.shuah@kernel.org>
References: <cover.1541118238.git.shuah@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1541118238.git.shuah@kernel.org>
In-Reply-To: <cover.1541109584.git.shuah@kernel.org>
References: <cover.1541109584.git.shuah@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: mchehab@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: Shuah Khan <shuah@kernel.org>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Shuah Khan <shuah@kernel.org>

Move ALSA MEDIA_INTF_T* interface types back into __KERNEL__ scope
to get ready for adding ALSA support to the media controller.

Signed-off-by: Shuah Khan <shuah@kernel.org>
---
 include/uapi/linux/media.h | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/include/uapi/linux/media.h b/include/uapi/linux/media.h
index 36f76e777ef9..07be07263597 100644
--- a/include/uapi/linux/media.h
+++ b/include/uapi/linux/media.h
@@ -262,6 +262,16 @@ struct media_links_enum {
 #define MEDIA_INTF_T_V4L_SWRADIO		(MEDIA_INTF_T_V4L_BASE + 4)
 #define MEDIA_INTF_T_V4L_TOUCH			(MEDIA_INTF_T_V4L_BASE + 5)
 
+#define MEDIA_INTF_T_ALSA_BASE			0x00000300
+#define MEDIA_INTF_T_ALSA_PCM_CAPTURE		(MEDIA_INTF_T_ALSA_BASE)
+#define MEDIA_INTF_T_ALSA_PCM_PLAYBACK		(MEDIA_INTF_T_ALSA_BASE + 1)
+#define MEDIA_INTF_T_ALSA_CONTROL		(MEDIA_INTF_T_ALSA_BASE + 2)
+#define MEDIA_INTF_T_ALSA_COMPRESS		(MEDIA_INTF_T_ALSA_BASE + 3)
+#define MEDIA_INTF_T_ALSA_RAWMIDI		(MEDIA_INTF_T_ALSA_BASE + 4)
+#define MEDIA_INTF_T_ALSA_HWDEP			(MEDIA_INTF_T_ALSA_BASE + 5)
+#define MEDIA_INTF_T_ALSA_SEQUENCER		(MEDIA_INTF_T_ALSA_BASE + 6)
+#define MEDIA_INTF_T_ALSA_TIMER			(MEDIA_INTF_T_ALSA_BASE + 7)
+
 #if defined(__KERNEL__)
 
 /*
@@ -404,21 +414,6 @@ struct media_v2_topology {
 
 #define MEDIA_ENT_F_DTV_DECODER			MEDIA_ENT_F_DV_DECODER
 
-/*
- * There is still no ALSA support in the media controller. These
- * defines should not have been added and we leave them here only
- * in case some application tries to use these defines.
- */
-#define MEDIA_INTF_T_ALSA_BASE			0x00000300
-#define MEDIA_INTF_T_ALSA_PCM_CAPTURE		(MEDIA_INTF_T_ALSA_BASE)
-#define MEDIA_INTF_T_ALSA_PCM_PLAYBACK		(MEDIA_INTF_T_ALSA_BASE + 1)
-#define MEDIA_INTF_T_ALSA_CONTROL		(MEDIA_INTF_T_ALSA_BASE + 2)
-#define MEDIA_INTF_T_ALSA_COMPRESS		(MEDIA_INTF_T_ALSA_BASE + 3)
-#define MEDIA_INTF_T_ALSA_RAWMIDI		(MEDIA_INTF_T_ALSA_BASE + 4)
-#define MEDIA_INTF_T_ALSA_HWDEP			(MEDIA_INTF_T_ALSA_BASE + 5)
-#define MEDIA_INTF_T_ALSA_SEQUENCER		(MEDIA_INTF_T_ALSA_BASE + 6)
-#define MEDIA_INTF_T_ALSA_TIMER			(MEDIA_INTF_T_ALSA_BASE + 7)
-
 /* Obsolete symbol for media_version, no longer used in the kernel */
 #define MEDIA_API_VERSION			((0 << 16) | (1 << 8) | 0)
 
-- 
2.17.0
