From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 1/2] ALSA: hda: fix the missing ptr
	initialization
Date: Thu, 28 Apr 2016 18:36:04 +0530
Message-ID: <1461848765-20212-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 71A3B26512B
 for <alsa-devel@alsa-project.org>; Thu, 28 Apr 2016 15:00:23 +0200 (CEST)
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
Cc: tiwai@suse.de, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

ebus is a member of extended device and was never initialized, so
do this at device creation.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/hda/ext/hdac_ext_bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/ext/hdac_ext_bus.c b/sound/hda/ext/hdac_ext_bus.c
index 2433f7c81472..64de0a3d6d93 100644
--- a/sound/hda/ext/hdac_ext_bus.c
+++ b/sound/hda/ext/hdac_ext_bus.c
@@ -144,6 +144,7 @@ int snd_hdac_ext_bus_device_init(struct hdac_ext_bus *ebus, int addr)
 	if (!edev)
 		return -ENOMEM;
 	hdev = &edev->hdac;
+	edev->ebus = ebus;
 
 	snprintf(name, sizeof(name), "ehdaudio%dD%d", ebus->idx, addr);
 
-- 
1.9.1
