From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 1/7] ASoC: Intel: Skylake: Update the delay
	check
Date: Fri,  5 Feb 2016 12:19:04 +0530
Message-ID: <1454654950-23091-2-git-send-email-vinod.koul@intel.com>
References: <1454654950-23091-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 185692605D2
 for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2016 07:45:47 +0100 (CET)
In-Reply-To: <1454654950-23091-1-git-send-email-vinod.koul@intel.com>
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

Delay check was using ternary operator, it can be simplified to
simple if condition, so update it

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index b6e6b61d10ec..cc9a5599ab9d 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -863,7 +863,9 @@ static int skl_get_delay_from_lpib(struct hdac_ext_bus *ebus,
 		else
 			delay += hstream->bufsize;
 	}
-	delay = (hstream->bufsize == delay) ? 0 : delay;
+
+	if (hstream->bufsize == delay)
+		delay = 0;
 
 	if (delay >= hstream->period_bytes) {
 		dev_info(bus->dev,
-- 
1.9.1
