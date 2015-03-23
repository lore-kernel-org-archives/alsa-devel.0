From: Qais Yousef <qais.yousef@imgtec.com>
Subject: [TINYCOMPRESS][PATCH 4/6] Android.mk: Update to use
	the new location of source files
Date: Mon, 23 Mar 2015 13:09:03 +0000
Message-ID: <1427116145-519-5-git-send-email-qais.yousef@imgtec.com>
References: <1427116145-519-1-git-send-email-qais.yousef@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by alsa0.perex.cz (Postfix) with ESMTP id DD690260651
 for <alsa-devel@alsa-project.org>; Mon, 23 Mar 2015 14:09:20 +0100 (CET)
In-Reply-To: <1427116145-519-1-git-send-email-qais.yousef@imgtec.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: vinod.koul@intel.com
Cc: alsa-devel@alsa-project.org, Qais Yousef <qais.yousef@imgtec.com>
List-Id: alsa-devel@alsa-project.org

---
 Android.mk | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Android.mk b/Android.mk
index 3cdd3d050c05..14878cccc805 100644
--- a/Android.mk
+++ b/Android.mk
@@ -2,7 +2,7 @@ LOCAL_PATH:= $(call my-dir)
 
 include $(CLEAR_VARS)
 LOCAL_C_INCLUDES:= $(LOCAL_PATH)/include
-LOCAL_SRC_FILES:= compress.c utils.c
+LOCAL_SRC_FILES:= src/lib/compress.c src/lib/utils.c
 LOCAL_MODULE := libtinycompress
 LOCAL_SHARED_LIBRARIES:= libcutils libutils
 LOCAL_MODULE_TAGS := optional
@@ -13,7 +13,7 @@ include $(BUILD_SHARED_LIBRARY)
 include $(CLEAR_VARS)
 
 LOCAL_C_INCLUDES:= $(LOCAL_PATH)/include
-LOCAL_SRC_FILES:= cplay.c
+LOCAL_SRC_FILES:= src/utils/cplay.c
 LOCAL_MODULE := cplay
 LOCAL_SHARED_LIBRARIES:= libcutils libutils libtinycompress
 LOCAL_MODULE_TAGS := optional
@@ -23,7 +23,7 @@ include $(BUILD_EXECUTABLE)
 include $(CLEAR_VARS)
 
 LOCAL_C_INCLUDES:= $(LOCAL_PATH)/include
-LOCAL_SRC_FILES:= crec.c
+LOCAL_SRC_FILES:= src/utils/crec.c
 LOCAL_MODULE := crec
 LOCAL_SHARED_LIBRARIES:= libcutils libutils libtinycompress
 LOCAL_MODULE_TAGS := optional
-- 
2.1.0
