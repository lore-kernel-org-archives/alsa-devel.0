From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 4/4] ASoC: Intel: Skylake: power down all link
	in suspend
Date: Fri,  9 Oct 2015 09:01:51 +0100
Message-ID: <1444377711-9720-5-git-send-email-vinod.koul@intel.com>
References: <1444377711-9720-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B635265158
 for <alsa-devel@alsa-project.org>; Fri,  9 Oct 2015 10:02:15 +0200 (CEST)
In-Reply-To: <1444377711-9720-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

This ensures that the link is not requesting any clock and the
PLL can turn off. The link is powered when controller is brought
out of reset.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index ca135b8ab5c0..5319529aedf7 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -173,6 +173,9 @@ static int skl_runtime_suspend(struct device *dev)
 
 	/* enable controller wake up event */
 	snd_hdac_chip_updatew(bus, WAKEEN, 0, STATESTS_INT_MASK);
+
+	snd_hdac_ext_bus_link_power_down_all(ebus);
+
 	ret = skl_suspend_dsp(skl);
 	if (ret < 0)
 		return ret;
-- 
2.4.3
