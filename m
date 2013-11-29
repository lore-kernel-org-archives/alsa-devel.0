From: Vinod Koul <vinod.koul@intel.com>
Subject: [RFC] ALSA: add new alsa control byte extended
Date: Fri, 29 Nov 2013 09:59:57 +0530
Message-ID: <1385699397-18662-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 8AF9C2654CA
 for <alsa-devel@alsa-project.org>; Fri, 29 Nov 2013 06:27:09 +0100 (CET)
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
Cc: tiwai@suse.de, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

As discussed in the last Audio uConf we need to improve byte controls to allow
larger size data to be sent to DSPs  The modern DSPs require alsa byte controls
size which far exceeds the today 512bytes limit. In order for usermode to send
larger sizes (few 100s of KBs) along with size information we add extended byte
control interface which sends any size bytes parameter buffer for DSPs to use
Obviosly the size must be supported by the device and would be required to
inform the max size allowed for the control.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/uapi/sound/asound.h |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index 9fc6219..8c10359 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -782,7 +782,8 @@ typedef int __bitwise snd_ctl_elem_type_t;
 #define	SNDRV_CTL_ELEM_TYPE_BYTES	((__force snd_ctl_elem_type_t) 4) /* byte array */
 #define	SNDRV_CTL_ELEM_TYPE_IEC958	((__force snd_ctl_elem_type_t) 5) /* IEC958 (S/PDIF) setup */
 #define	SNDRV_CTL_ELEM_TYPE_INTEGER64	((__force snd_ctl_elem_type_t) 6) /* 64-bit integer type */
-#define	SNDRV_CTL_ELEM_TYPE_LAST	SNDRV_CTL_ELEM_TYPE_INTEGER64
+#define SNDRV_CTL_ELEM_TYPE_BYTES_EXT	((__force snd_ctl_elem_type_t) 7) /* bytes array extended */
+#define	SNDRV_CTL_ELEM_TYPE_LAST	SNDRV_CTL_ELEM_TYPE_BYTES_EXT
 
 typedef int __bitwise snd_ctl_elem_iface_t;
 #define	SNDRV_CTL_ELEM_IFACE_CARD	((__force snd_ctl_elem_iface_t) 0) /* global control */
@@ -891,6 +892,11 @@ struct snd_ctl_elem_value {
 			unsigned char data[512];
 			unsigned char *data_ptr;	/* obsoleted */
 		} bytes;
+		struct {
+			unsigned long size;	/* size of buffer */
+			__u64 data;	i	/* user data pointer */
+		} bytes_ext;
+
 		struct snd_aes_iec958 iec958;
 	} value;		/* RO */
 	struct timespec tstamp;
-- 
1.7.0.4
