From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 1/2] ALSA: asound.h - use
	SNDRV_CTL_ELEM_ID_NAME_MAXLEN
Date: Fri, 17 Apr 2015 22:53:32 +0530
Message-ID: <1429291413-30668-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A9E9260600
 for <alsa-devel@alsa-project.org>; Fri, 17 Apr 2015 19:28:39 +0200 (CEST)
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

we have defined SNDRV_CTL_ELEM_ID_NAME_MAXLEN as size of name array so use
this define instead of numeric value

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/uapi/sound/asound.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index 46145a5277fe..a45be6bdcf5b 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -864,7 +864,7 @@ struct snd_ctl_elem_id {
 	snd_ctl_elem_iface_t iface;	/* interface identifier */
 	unsigned int device;		/* device/client number */
 	unsigned int subdevice;		/* subdevice (substream) number */
-	unsigned char name[44];		/* ASCII name of item */
+	unsigned char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];		/* ASCII name of item */
 	unsigned int index;		/* index of item */
 };
 
-- 
1.7.9.5
