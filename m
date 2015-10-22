From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 1/9] ASoC: Intel: Skylake: Fix return for
	pm_runtime_get_sync()
Date: Thu, 22 Oct 2015 23:22:34 +0530
Message-ID: <1445536362-26670-2-git-send-email-vinod.koul@intel.com>
References: <1445536362-26670-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 596FA260545
 for <alsa-devel@alsa-project.org>; Thu, 22 Oct 2015 19:49:30 +0200 (CEST)
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

pm_runtime_get_sync() will return a negative value in case of
error and can return postive value for success.  The return check
for pm_runtime_get_sync() must be less than 0, so fix it

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index a8f53da11ae3..a2f94ce1679d 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -116,7 +116,7 @@ static int skl_pcm_open(struct snd_pcm_substream *substream,
 
 	dev_dbg(dai->dev, "%s: %s\n", __func__, dai->name);
 	ret = pm_runtime_get_sync(dai->dev);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	stream = snd_hdac_ext_stream_assign(ebus, substream,
-- 
1.9.1
