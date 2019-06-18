From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH] ASoC: qcom: common: Fix NULL pointer in of
	parser
Date: Mon, 17 Jun 2019 22:28:13 -0700
Message-ID: <20190618052813.32523-1-bjorn.andersson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 37BE8F8075C
 for <alsa-devel@alsa-project.org>; Tue, 18 Jun 2019 07:28:17 +0200 (CEST)
Received: by mail-pg1-x543.google.com with SMTP id w10so2372747pgj.7
 for <alsa-devel@alsa-project.org>; Mon, 17 Jun 2019 22:28:17 -0700 (PDT)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

A snd_soc_dai_link_component is allocated and associated with the first
link, so when the code tries to assign the of_node of the second link's
"cpu" member it dereferences a NULL pointer.

Fix this by moving the allocation and assignement of
snd_soc_dai_link_components into the loop, giving us one pair per link.

Fixes: 1e36ea360ab9 ("ASoC: qcom: common: use modern dai_link style")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 sound/soc/qcom/common.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/qcom/common.c b/sound/soc/qcom/common.c
index c7a878507220..97488b5cc515 100644
--- a/sound/soc/qcom/common.c
+++ b/sound/soc/qcom/common.c
@@ -42,17 +42,17 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 	card->num_links = num_links;
 	link = card->dai_link;
 
-	dlc = devm_kzalloc(dev, 2 * sizeof(*dlc), GFP_KERNEL);
-	if (!dlc)
-		return -ENOMEM;
+	for_each_child_of_node(dev->of_node, np) {
+		dlc = devm_kzalloc(dev, 2 * sizeof(*dlc), GFP_KERNEL);
+		if (!dlc)
+			return -ENOMEM;
 
-	link->cpus	= &dlc[0];
-	link->platforms	= &dlc[1];
+		link->cpus	= &dlc[0];
+		link->platforms	= &dlc[1];
 
-	link->num_cpus		= 1;
-	link->num_platforms	= 1;
+		link->num_cpus		= 1;
+		link->num_platforms	= 1;
 
-	for_each_child_of_node(dev->of_node, np) {
 		cpu = of_get_child_by_name(np, "cpu");
 		platform = of_get_child_by_name(np, "platform");
 		codec = of_get_child_by_name(np, "codec");
-- 
2.18.0
