From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 1/3] ALSA: hdac: Fix size allocation for ext
	device allocation
Date: Sun, 23 Aug 2015 11:52:49 +0530
Message-ID: <1440310971-14849-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 5FC6F260470
 for <alsa-devel@alsa-project.org>; Sun, 23 Aug 2015 08:20:43 +0200 (CEST)
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

While creating hdac_ext_device, we used hdev for sizeof insteadof
edev, which resulted in eventual crash of the system Fix the size
here

Fixes: a512f5611646 ('ALSA: hdac: add hdac extended device')
Reported-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/hda/ext/hdac_ext_bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/hda/ext/hdac_ext_bus.c b/sound/hda/ext/hdac_ext_bus.c
index 8544e4fb1cd3..4449d1a99089 100644
--- a/sound/hda/ext/hdac_ext_bus.c
+++ b/sound/hda/ext/hdac_ext_bus.c
@@ -139,7 +139,7 @@ int snd_hdac_ext_bus_device_init(struct hdac_ext_bus *ebus, int addr)
 	char name[15];
 	int ret;
 
-	edev = kzalloc(sizeof(*hdev), GFP_KERNEL);
+	edev = kzalloc(sizeof(*edev), GFP_KERNEL);
 	if (!edev)
 		return -ENOMEM;
 	hdev = &edev->hdac;
-- 
1.9.1
