From: Kirill Marinushkin <k.marinushkin@gmail.com>
Subject: [PATCH] ASoC: Intel: Skylake: Fix compiler warning
	-Wmaybe-uninitialized
Date: Mon, 19 Feb 2018 07:02:29 +0100
Message-ID: <20180219060229.17215-1-k.marinushkin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f65.google.com (mail-wm0-f65.google.com [74.125.82.65])
 by alsa0.perex.cz (Postfix) with ESMTP id BA9E1266C0E
 for <alsa-devel@alsa-project.org>; Mon, 19 Feb 2018 07:04:43 +0100 (CET)
Received: by mail-wm0-f65.google.com with SMTP id t74so12910246wme.3
 for <alsa-devel@alsa-project.org>; Sun, 18 Feb 2018 22:04:43 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Harsha Priya N <harshapriya.n@intel.com>, Mark Brown <broonie@kernel.org>, Naveen Manohar <naveen.m@intel.com>, Kirill Marinushkin <k.marinushkin@gmail.com>
List-Id: alsa-devel@alsa-project.org

Configuration:

SND_SOC_INTEL_SKYLAKE=y
PM_SLEEP=y

Warning message:

sound/soc/intel/skylake/skl.c: In function 'skl_resume':
sound/soc/intel/skylake/skl.c:326:6: warning: 'ret' may be used
uninitialized in this function [-Wmaybe-uninitialized]
  int ret;
      ^~~

Fixes: 4557c305d4fc ("ASoC: Intel: Skylake: Add support for active suspend")
Signed-off-by: Kirill Marinushkin <k.marinushkin@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Guneshwor Singh <guneshwor.o.singh@intel.com>
Cc: Naveen Manohar <naveen.m@intel.com>
Cc: Harsha Priya N <harshapriya.n@intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
---
 sound/soc/intel/skylake/skl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 31d8634e8aa1..273a9ab75489 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -323,7 +323,7 @@ static int skl_resume(struct device *dev)
 	struct skl *skl  = ebus_to_skl(ebus);
 	struct hdac_bus *bus = ebus_to_hbus(ebus);
 	struct hdac_ext_link *hlink = NULL;
-	int ret;
+	int ret = 0;
 
 	/* Turned OFF in HDMI codec driver after codec reconfiguration */
 	if (IS_ENABLED(CONFIG_SND_SOC_HDAC_HDMI)) {
-- 
2.13.6
