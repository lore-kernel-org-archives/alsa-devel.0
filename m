From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH] ASoC: mc13783: Provide codec->control_data
Date: Thu, 26 Jul 2012 15:29:03 -0300
Message-ID: <1343327343-10159-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe004.messaging.microsoft.com [213.199.154.207])
 by alsa0.perex.cz (Postfix) with ESMTP id 01978265EBC
 for <alsa-devel@alsa-project.org>; Thu, 26 Jul 2012 20:29:13 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: Fabio Estevam <fabio.estevam@freescale.com>, philippe.retornaz@epfl.ch, alsa-devel@alsa-project.org, lee.jones@linaro.org, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

If codec->control_data is not provided, the following crash happens:

Unable to handle kernel NULL pointer dereference at virtual address 00000078
pgd = 80004000
[00000078] *pgd=00000000
Internal error: Oops: 5 [#1] SMP ARM
Modules linked in:
CPU: 0    Tainted: G        W     (3.5.0-next-20120725+ #1263)
PC is at regmap_read+0x18/0x64
LR is at hw_read+0x50/0x98
pc : [<802bcd90>]    lr : [<803cad18>]    psr: 60000013
...

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/codecs/mc13783.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/mc13783.c b/sound/soc/codecs/mc13783.c
index 6276e35..c8251af 100644
--- a/sound/soc/codecs/mc13783.c
+++ b/sound/soc/codecs/mc13783.c
@@ -581,6 +581,8 @@ static int mc13783_probe(struct snd_soc_codec *codec)
 {
 	struct mc13783_priv *priv = snd_soc_codec_get_drvdata(codec);
 
+	codec->control_data = priv->mc13xxx;
+
 	mc13xxx_lock(priv->mc13xxx);
 
 	/* these are the reset values */
-- 
1.7.1
