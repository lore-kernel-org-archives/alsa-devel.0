From: Ed Blake <ed.blake@sondrel.com>
Subject: [PATCH] ASoC: img-parallel-out: Add pm_runtime_get/put
	to set_fmt callback
Date: Mon,  2 Oct 2017 11:00:33 +0100
Message-ID: <1506938433-681-1-git-send-email-ed.blake@sondrel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0043.outbound.protection.outlook.com [104.47.2.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B90326719A
 for <alsa-devel@alsa-project.org>; Mon,  2 Oct 2017 12:00:54 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, Ed Blake <ed.blake@sondrel.com>
List-Id: alsa-devel@alsa-project.org

Add pm_runtime_get_sync and pm_runtime_put calls to set_fmt callback
function. This fixes a bus error during boot when CONFIG_SUSPEND is
defined when this function gets called while the device is runtime
disabled and device registers are accessed while the clock is disabled.

Signed-off-by: Ed Blake <ed.blake@sondrel.com>
---
 sound/soc/img/img-parallel-out.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/img/img-parallel-out.c b/sound/soc/img/img-parallel-out.c
index 23b0f0f..2fc8a63 100644
--- a/sound/soc/img/img-parallel-out.c
+++ b/sound/soc/img/img-parallel-out.c
@@ -164,9 +164,11 @@ static int img_prl_out_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		return -EINVAL;
 	}
 
+	pm_runtime_get_sync(prl->dev);
 	reg = img_prl_out_readl(prl, IMG_PRL_OUT_CTL);
 	reg = (reg & ~IMG_PRL_OUT_CTL_EDGE_MASK) | control_set;
 	img_prl_out_writel(prl, reg, IMG_PRL_OUT_CTL);
+	pm_runtime_put(prl->dev);
 
 	return 0;
 }
-- 
1.9.1
