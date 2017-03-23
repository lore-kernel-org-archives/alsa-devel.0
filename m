From: jeeja.kp@intel.com
Subject: [PATCH 01/11] ALSA: hda: Fix LLCH register read
Date: Thu, 23 Mar 2017 19:01:56 +0530
Message-ID: <1490275926-2270-2-git-send-email-jeeja.kp@intel.com>
References: <1490275926-2270-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 01D49266B57
 for <alsa-devel@alsa-project.org>; Thu, 23 Mar 2017 14:19:44 +0100 (CET)
In-Reply-To: <1490275926-2270-1-git-send-email-jeeja.kp@intel.com>
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
Cc: tiwai@suse.de, "B, Jayachandran" <jayachandran.b@intel.com>, patches.audio@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "B, Jayachandran" <jayachandran.b@intel.com>

LLCH is a 16 bit register. Use readw instead of readl API.

Signed-off-by: B, Jayachandran <jayachandran.b@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 sound/hda/hdac_controller.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/hda/hdac_controller.c b/sound/hda/hdac_controller.c
index 0430658..6f1e99c 100644
--- a/sound/hda/hdac_controller.c
+++ b/sound/hda/hdac_controller.c
@@ -268,7 +268,7 @@ int snd_hdac_bus_parse_capabilities(struct hdac_bus *bus)
 	unsigned int offset;
 	unsigned int counter = 0;
 
-	offset = snd_hdac_chip_readl(bus, LLCH);
+	offset = snd_hdac_chip_readw(bus, LLCH);
 
 	/* Lets walk the linked capabilities list */
 	do {
-- 
2.5.0
