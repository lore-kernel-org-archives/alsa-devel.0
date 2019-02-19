From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5/6] ASoC: qcom: Fix of-node refcount unbalance
	in qcom_snd_parse_of()
Date: Tue, 19 Feb 2019 16:46:51 +0100
Message-ID: <20190219154652.13644-6-tiwai@suse.de>
References: <20190219154652.13644-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 42C6D26554B
 for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2019 16:46:55 +0100 (CET)
In-Reply-To: <20190219154652.13644-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

Although qcom_snd_parse_of() tries to manage the of-node refcount,
there are still a few places that lead to the unblanced refcount in
the error code path.  Namely,

- for_each_child_of_node() needs to unreference the iterator node if
  aborting the loop in the middle,
- cpu, codec and platform node objects have to be unreferenced at each
  iteration,
- platform and codec node objects have to be referred before jumping
  to the error handling code that unreference them unconditionally.

This patch tries to address these by moving the assignment of platform
and codec node objects to the beginning of the loop and adding the
of_node_put() calls adequately.

Fixes: c25e295cd77b ("ASoC: qcom: Add support to parse common audio device nodes")
Cc: Patrick Lai <plai@codeaurora.org>
Cc: Banajit Goswami <bgoswami@codeaurora.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---

Only compile-tested.  Please review carefully.  Thanks!

 sound/soc/qcom/common.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/common.c b/sound/soc/qcom/common.c
index 4715527054e5..5661025e8cec 100644
--- a/sound/soc/qcom/common.c
+++ b/sound/soc/qcom/common.c
@@ -42,6 +42,9 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 	link = card->dai_link;
 	for_each_child_of_node(dev->of_node, np) {
 		cpu = of_get_child_by_name(np, "cpu");
+		platform = of_get_child_by_name(np, "platform");
+		codec = of_get_child_by_name(np, "codec");
+
 		if (!cpu) {
 			dev_err(dev, "Can't find cpu DT node\n");
 			ret = -EINVAL;
@@ -63,8 +66,6 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 			goto err;
 		}
 
-		platform = of_get_child_by_name(np, "platform");
-		codec = of_get_child_by_name(np, "codec");
 		if (codec && platform) {
 			link->platform_of_node = of_parse_phandle(platform,
 					"sound-dai",
@@ -100,10 +101,15 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 		link->dpcm_capture = 1;
 		link->stream_name = link->name;
 		link++;
+
+		of_node_put(cpu);
+		of_node_put(codec);
+		of_node_put(platform);
 	}
 
 	return 0;
 err:
+	of_node_put(np);
 	of_node_put(cpu);
 	of_node_put(codec);
 	of_node_put(platform);
-- 
2.16.4
