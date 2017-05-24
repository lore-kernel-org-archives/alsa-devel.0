From: Julian Scheel <julian@jusst.de>
Subject: [PATCH] ASoC: simple-card: Fix misleading error message
Date: Wed, 24 May 2017 12:28:23 +0200
Message-ID: <20170524102823.8253-1-julian@jusst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web01.jusst.de (jusst.de [188.40.114.84])
 by alsa0.perex.cz (Postfix) with ESMTP id C4C90267333
 for <alsa-devel@alsa-project.org>; Wed, 24 May 2017 12:29:14 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Nikita Yushchenko <nikita.yoush@cogentembedded.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Julian Scheel <julian@jusst.de>
List-Id: alsa-devel@alsa-project.org

In case cpu could not be found the error message would always refer to
/codec/ not being found in DT. Fix this by catching the cpu node not found
case explicitly.

Signed-off-by: Julian Scheel <julian@jusst.de>
---
 sound/soc/generic/simple-card.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 7ed84f811205..38d7b601546f 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -233,13 +233,19 @@ static int asoc_simple_card_dai_link_of(struct device_node *node,
 	snprintf(prop, sizeof(prop), "%scpu", prefix);
 	cpu = of_get_child_by_name(node, prop);
 
+	if (!cpu) {
+		ret = -EINVAL;
+		dev_err(dev, "%s: Can't find %s DT node\n", __func__, prop);
+		goto dai_link_of_err;
+	}
+
 	snprintf(prop, sizeof(prop), "%splat", prefix);
 	plat = of_get_child_by_name(node, prop);
 
 	snprintf(prop, sizeof(prop), "%scodec", prefix);
 	codec = of_get_child_by_name(node, prop);
 
-	if (!cpu || !codec) {
+	if (!codec) {
 		ret = -EINVAL;
 		dev_err(dev, "%s: Can't find %s DT node\n", __func__, prop);
 		goto dai_link_of_err;
-- 
2.12.2
