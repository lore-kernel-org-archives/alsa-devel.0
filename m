From: libin.yang@linux.intel.com
Subject: [RFC PATCH 1/2] ALSA: hda - add hda_dev_t typedef for
	DP MST audio
Date: Tue,  3 Nov 2015 16:22:52 +0800
Message-ID: <1446538973-109373-2-git-send-email-libin.yang@linux.intel.com>
References: <1446538973-109373-1-git-send-email-libin.yang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 301B626055C
 for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2015 09:24:15 +0100 (CET)
In-Reply-To: <1446538973-109373-1-git-send-email-libin.yang@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: Libin Yang <libin.yang@intel.com>, mengdong.lin@linux.intel.com
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@intel.com>

Signed-off-by: Libin Yang <libin.yang@intel.com>
---
 include/sound/hdaudio.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index e2b712c..1f54964 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -15,6 +15,7 @@
 
 /* codec node id */
 typedef u16 hda_nid_t;
+typedef u8 hda_dev_t;
 
 struct hdac_bus;
 struct hdac_stream;
-- 
1.9.1
