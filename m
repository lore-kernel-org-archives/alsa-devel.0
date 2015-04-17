From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v3 1/2] ALSA: hda - add ASoC device type for
	hda core
Date: Fri, 17 Apr 2015 17:58:57 +0530
Message-ID: <1429273738-24666-2-git-send-email-vinod.koul@intel.com>
References: <1429273738-24666-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A82C260578
 for <alsa-devel@alsa-project.org>; Fri, 17 Apr 2015 14:34:07 +0200 (CEST)
In-Reply-To: <1429273738-24666-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, Ramesh Babu <ramesh.babu@intel.com>, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org
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
index dbeb195eb4e8..d05931fc6f28 100644
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
