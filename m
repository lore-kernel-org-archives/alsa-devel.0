From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 7/9] ASoC: Intel: Skylake: Fix to check return
	value of dsp init
Date: Thu, 22 Oct 2015 23:22:40 +0530
Message-ID: <1445536362-26670-8-git-send-email-vinod.koul@intel.com>
References: <1445536362-26670-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B04E261492
 for <alsa-devel@alsa-project.org>; Thu, 22 Oct 2015 19:53:33 +0200 (CEST)
In-Reply-To: <1445536362-26670-1-git-send-email-vinod.koul@intel.com>
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

If DSP initialization fails, ipc to disable notification
will cause NULL ptr exception as ipc is not initialized.
This patch returns error if dsp init fails before
sending disable notification ipc.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-messages.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index ca7bbeea2cd9..a1001a686aa9 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -97,6 +97,9 @@ int skl_init_dsp(struct skl *skl)
 
 	ret = skl_sst_dsp_init(bus->dev, mmio_base, irq,
 			loader_ops, &skl->skl_sst);
+	if (ret < 0)
+		return ret;
+
 	skl_dsp_enable_notification(skl->skl_sst, false);
 	dev_dbg(bus->dev, "dsp registration status=%d\n", ret);
 
-- 
1.9.1
