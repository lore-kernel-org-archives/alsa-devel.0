From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 1/7] ALSA: hda - add ASoC device type for
	hda core
Date: Fri, 17 Apr 2015 14:43:14 +0530
Message-ID: <1429262000-21517-2-git-send-email-vinod.koul@intel.com>
References: <1429262000-21517-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B44626053B
 for <alsa-devel@alsa-project.org>; Fri, 17 Apr 2015 11:18:50 +0200 (CEST)
In-Reply-To: <1429262000-21517-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, lgirdwood@gmail.com, Ramesh Babu <ramesh.babu@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Ramesh Babu <ramesh.babu@intel.com>

Add HDA_DEV_ASOC device/driver type to support
ASoC HDA drivers.

Signed-off-by: Ramesh Babu <ramesh.babu@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/hdaudio.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index 15bc039de78d..b871f00bb185 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -90,6 +90,7 @@ struct hdac_device {
 enum {
 	HDA_DEV_CORE,
 	HDA_DEV_LEGACY,
+	HDA_DEV_ASOC,
 };
 
 /* direction */
-- 
1.7.9.5
