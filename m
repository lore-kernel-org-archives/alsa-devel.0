From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] ASoC: Intel: Skylake: Fix error return code in skl_probe()
Date: Fri, 12 Aug 2016 11:45:18 +0000
Message-ID: <1471002318-20209-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Vinod Koul <vinod.koul@intel.com>, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Jayachandran B <jayachandran.b@intel.com>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Fix to return error code -ENODEV from the error handling
case instead of 0, as done elsewhere in this function.

Fixes: 87b2bdf02278 ("ASoC: Intel: Skylake: Initialize NHLT table")
Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
---
 sound/soc/intel/skylake/skl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index a893ca1..2989c16 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -672,8 +672,10 @@ static int skl_probe(struct pci_dev *pci,
 
 	skl->nhlt = skl_nhlt_init(bus->dev);
 
-	if (skl->nhlt == NULL)
+	if (skl->nhlt == NULL) {
+		err = -ENODEV;
 		goto out_free;
+	}
 
 	skl_nhlt_update_topology_bin(skl);
