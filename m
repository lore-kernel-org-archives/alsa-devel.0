From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/3] ALSA: HDA: Dont check return for
	snd_hdac_chip_readl
Date: Tue,  4 Aug 2015 09:28:39 +0530
Message-ID: <1438660720-30033-3-git-send-email-vinod.koul@intel.com>
References: <1438660720-30033-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 980032654F2
 for <alsa-devel@alsa-project.org>; Tue,  4 Aug 2015 05:57:03 +0200 (CEST)
In-Reply-To: <1438660720-30033-1-git-send-email-vinod.koul@intel.com>
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

From: Jeeja KP <jeeja.kp@intel.com>

The snd_hdac_chip_readl return can never be less than zeros,
so no point in checking for the return value

This fixes following static checker warnings in
snd_hdac_ext_bus_parse_capabilities

       sound/hda/ext/hdac_ext_controller.c:47
 snd_hdac_ext_bus_parse_capabilities()
       warn: unsigned 'offset' is never less than zero.

       sound/hda/ext/hdac_ext_controller.c:54
 snd_hdac_ext_bus_parse_capabilities()
       warn: unsigned 'cur_cap' is never less than zero.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/hda/ext/hdac_ext_controller.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/hda/ext/hdac_ext_controller.c b/sound/hda/ext/hdac_ext_controller.c
index b2da19b60f4e..358f16195483 100644
--- a/sound/hda/ext/hdac_ext_controller.c
+++ b/sound/hda/ext/hdac_ext_controller.c
@@ -44,16 +44,10 @@ int snd_hdac_ext_bus_parse_capabilities(struct hdac_ext_bus *ebus)
 
 	offset = snd_hdac_chip_readl(bus, LLCH);
 
-	if (offset < 0)
-		return -EIO;
-
 	/* Lets walk the linked capabilities list */
 	do {
 		cur_cap = _snd_hdac_chip_read(l, bus, offset);
 
-		if (cur_cap < 0)
-			return -EIO;
-
 		dev_dbg(bus->dev, "Capability version: 0x%x\n",
 				((cur_cap & AZX_CAP_HDR_VER_MASK) >> AZX_CAP_HDR_VER_OFF));
 
-- 
1.9.1
