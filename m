From: Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Subject: [PATCH 2/3] asoc: (cosmetic) simplify a condition
Date: Wed, 30 Jan 2019 17:22:40 +0100
Message-ID: <1548865361-12816-3-git-send-email-guennadi.liakhovetski@intel.com>
References: <1548865361-12816-1-git-send-email-guennadi.liakhovetski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout-xforward.gmx.net (mout-xforward.gmx.net [82.165.159.13])
 by alsa0.perex.cz (Postfix) with ESMTP id CDAEF26790B
 for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2019 17:22:44 +0100 (CET)
Received: from axis700.grange ([87.78.226.14]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lqi70-1hK6eE0yAs-00eKNH for
 <alsa-devel@alsa-project.org>; Wed, 30 Jan 2019 17:22:44 +0100
Received: from 200r.grange (200r.grange [192.168.1.16])
 by axis700.grange (Postfix) with ESMTP id 5CFF461CE9
 for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2019 17:22:42 +0100 (CET)
In-Reply-To: <1548865361-12816-1-git-send-email-guennadi.liakhovetski@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>

Double negation is often used in the kernel to avoid explicit comparison
to 0. However an "if (!!a == !!b)" test can be trivially reduced to "if
(!a == !b)".

Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
---
 sound/soc/soc-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index aae450ba4f08..8c6b688837de 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1106,8 +1106,8 @@ static int soc_init_dai_link(struct snd_soc_card *card,
 		 * Codec must be specified by 1 of name or OF node,
 		 * not both or neither.
 		 */
-		if (!!codec->name ==
-		    !!codec->of_node) {
+		if (!codec->name ==
+		    !codec->of_node) {
 			dev_err(card->dev, "ASoC: Neither/both codec name/of_node are set for %s\n",
 				link->name);
 			return -EINVAL;
-- 
2.17.1
