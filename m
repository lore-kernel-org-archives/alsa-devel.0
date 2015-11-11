From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 9/9] ASoC: Intel: Skylake: Add pm ops for
	skl_rt286 machine
Date: Thu, 12 Nov 2015 00:16:49 +0530
Message-ID: <1447267609-27816-10-git-send-email-vinod.koul@intel.com>
References: <1447267609-27816-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id CFB77265963
 for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2015 19:43:52 +0100 (CET)
In-Reply-To: <1447267609-27816-1-git-send-email-vinod.koul@intel.com>
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

The PM ops are required so that DAPM will suspend and resume the DSP
pipelines properly

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/boards/skl_rt286.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/boards/skl_rt286.c b/sound/soc/intel/boards/skl_rt286.c
index 9c67e05a24b3..57333a476136 100644
--- a/sound/soc/intel/boards/skl_rt286.c
+++ b/sound/soc/intel/boards/skl_rt286.c
@@ -299,6 +299,7 @@ static struct platform_driver skylake_audio = {
 	.probe = skylake_audio_probe,
 	.driver = {
 		.name = "skl_alc286s_i2s",
+		.pm = &snd_soc_pm_ops,
 	},
 };
 
-- 
1.9.1
