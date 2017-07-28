From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [PATCH 1/4] ASoC: Intel: Skylake: Reset the controller
	in probe
Date: Fri, 28 Jul 2017 16:12:13 +0530
Message-ID: <20170728104216.26859-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 317682676D1
 for <alsa-devel@alsa-project.org>; Fri, 28 Jul 2017 12:42:19 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Patches Audio <patches.audio@intel.com>
List-Id: alsa-devel@alsa-project.org

Controller can be in reset state by default. Capability structure
traversal requires the controller to be out of reset else it
results in broken capability parsing. Hence make sure that controller is
out of reset before parsing capabilities by doing a full reset.

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
---
 sound/soc/intel/skylake/skl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 334917ee41cf..a56dfde3928c 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -702,6 +702,8 @@ static int skl_first_init(struct hdac_ext_bus *ebus)
 		return -ENXIO;
 	}
 
+	skl_init_chip(bus, true);
+
 	snd_hdac_bus_parse_capabilities(bus);
 
 	if (skl_acquire_irq(ebus, 0) < 0)
-- 
2.13.0
