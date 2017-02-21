From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ASoC: Intel: Skylake: fix spelling mistake:
	"allocationf" -> "allocation"
Date: Tue, 21 Feb 2017 18:50:05 +0000
Message-ID: <20170221185005.27973-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 59195266A65
 for <alsa-devel@alsa-project.org>; Tue, 21 Feb 2017 19:50:17 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, Dharageswari R <dharageswari.r@intel.com>, "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>, Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in dev_err message.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/intel/skylake/skl-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index e12520e..635cbb1 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -1165,7 +1165,7 @@ static int skl_pcm_new(struct snd_soc_pcm_runtime *rtd)
 						snd_dma_pci_data(skl->pci),
 						size, MAX_PREALLOC_SIZE);
 		if (retval) {
-			dev_err(dai->dev, "dma buffer allocationf fail\n");
+			dev_err(dai->dev, "dma buffer allocation fail\n");
 			return retval;
 		}
 	}
-- 
2.10.2
