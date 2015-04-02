From: Vinod Koul <vinod.koul@intel.com>
Subject: [RFC 1/3] ALSA: hda - remove assigning dev type inside
	core
Date: Thu,  2 Apr 2015 15:27:29 +0530
Message-ID: <1427968651-7821-2-git-send-email-vinod.koul@intel.com>
References: <1427968651-7821-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B1952604CA
 for <alsa-devel@alsa-project.org>; Thu,  2 Apr 2015 12:02:01 +0200 (CEST)
In-Reply-To: <1427968651-7821-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, lgirdwood@gmail.com, Ramesh Babu <ramesh.babu@intel.com>, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, pathes.audio@intel.com
List-Id: alsa-devel@alsa-project.org

From: Ramesh Babu <ramesh.babu@intel.com>

We don't need to init the hda dev type inside
core device init code. It is expected to be
initialized by the caller.

Signed-off-by: Ramesh Babu <ramesh.babu@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/hda/hdac_device.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/hda/hdac_device.c b/sound/hda/hdac_device.c
index 6e8ee1d6974a..aefc80ffecee 100644
--- a/sound/hda/hdac_device.c
+++ b/sound/hda/hdac_device.c
@@ -51,7 +51,6 @@ int snd_hdac_device_init(struct hdac_device *codec, struct hdac_bus *bus,
 
 	codec->bus = bus;
 	codec->addr = addr;
-	codec->type = HDA_DEV_CORE;
 	pm_runtime_set_active(&codec->dev);
 	pm_runtime_get_noresume(&codec->dev);
 	atomic_set(&codec->in_pm, 0);
-- 
1.7.9.5
