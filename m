From: Vishal Thanki <vishalthanki@gmail.com>
Subject: [PATCH] ASoC: simple-card: Add a NULL pointer check in
 asoc_simple_card_dai_link_of
Date: Tue, 3 Mar 2015 18:59:00 +0530
Message-ID: <20150303132900.GA22246@vishal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: kernel-janitors@vger.kernel.org, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Make sure devm_kzalloc() succeeds.

Signed-off-by: Vishal Thanki <vishalthanki@gmail.com>
---
 sound/soc/generic/simple-card.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index f7c6734..fb550b5 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -372,6 +372,11 @@ static int asoc_simple_card_dai_link_of(struct device_node *node,
 			    strlen(dai_link->cpu_dai_name)   +
 			    strlen(dai_link->codec_dai_name) + 2,
 			    GFP_KERNEL);
+	if (!name) {
+		ret = -ENOMEM;
+		goto dai_link_of_err;
+	}
+
 	sprintf(name, "%s-%s", dai_link->cpu_dai_name,
 				dai_link->codec_dai_name);
 	dai_link->name = dai_link->stream_name = name;
-- 
1.7.9.5

