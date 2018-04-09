From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH] ASoC: fsl_esai: Add freq check in
	set_dai_sysclk()
Date: Sun,  8 Apr 2018 17:33:54 -0700
Message-ID: <1523234034-33018-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f195.google.com (mail-pf0-f195.google.com
 [209.85.192.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 9BF642673C7
 for <alsa-devel@alsa-project.org>; Mon,  9 Apr 2018 02:34:44 +0200 (CEST)
Received: by mail-pf0-f195.google.com with SMTP id p15so4745602pff.11
 for <alsa-devel@alsa-project.org>; Sun, 08 Apr 2018 17:34:44 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com, fabio.estevam@nxp.com, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

The freq parameter indicates the physical frequency of an actual
input clock or a desired frequency of an output clock for HCKT/R.
It should never be passed 0. This might cause Division-by-zero.

So this patch adds a check to fix it.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/fsl_esai.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index da8fd98..d79e99e 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -226,6 +226,12 @@ static int fsl_esai_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
 	unsigned long clk_rate;
 	int ret;
 
+	if (freq == 0) {
+		dev_err(dai->dev, "%sput freq of HCK%c should not be 0Hz\n",
+			in ? "in" : "out", tx ? 'T' : 'R');
+		return -EINVAL;
+	}
+
 	/* Bypass divider settings if the requirement doesn't change */
 	if (freq == esai_priv->hck_rate[tx] && dir == esai_priv->hck_dir[tx])
 		return 0;
-- 
2.7.4
