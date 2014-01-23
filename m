From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH Resend 2/8] ASoC: simple-card: fix
	__asoc_simple_card_dai_init
Date: Thu, 23 Jan 2014 13:02:44 +0800
Message-ID: <1390453370-29194-3-git-send-email-Li.Xiubo@freescale.com>
References: <1390453370-29194-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe005.messaging.microsoft.com [213.199.154.208])
 by alsa0.perex.cz (Postfix) with ESMTP id E6016265165
 for <alsa-devel@alsa-project.org>; Thu, 23 Jan 2014 07:01:55 +0100 (CET)
In-Reply-To: <1390453370-29194-1-git-send-email-Li.Xiubo@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, shawn.guo@linaro.org, kuninori.morimoto.gx@renesas.com
Cc: moinejf@free.fr, alsa-devel@alsa-project.org, Xiubo Li <Li.Xiubo@freescale.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

If the CPU/CODEC DAI set_sysclk() is not support, the -ENOTSUPP will returnd.
Here do the check like set_fmt().

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---



The VF610 Tower and VF610 LS1 platforms' ESAI and SPDIF will depend on this
patch too.




 sound/soc/generic/simple-card.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 6443c87..3b8c9a2 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -31,16 +31,21 @@ static int __asoc_simple_card_dai_init(struct snd_soc_dai *dai,
 
 	daifmt |= set->fmt;
 
-	if (daifmt)
+	if (daifmt) {
 		ret = snd_soc_dai_set_fmt(dai, daifmt);
-
-	if (ret == -ENOTSUPP) {
-		dev_dbg(dai->dev, "ASoC: set_fmt is not supported\n");
-		ret = 0;
+		if (ret && ret != -ENOTSUPP) {
+			dev_err(dai->dev, "simple-card: set_fmt error\n");
+			return ret;
+		}
 	}
 
-	if (!ret && set->sysclk)
+	if (set->sysclk) {
 		ret = snd_soc_dai_set_sysclk(dai, 0, set->sysclk, 0);
+		if (ret && ret != -ENOTSUPP) {
+			dev_err(dai->dev, "simple-card: set_sysclk error\n");
+			return ret;
+		}
+	}
 
 	return ret;
 }
-- 
1.8.4
