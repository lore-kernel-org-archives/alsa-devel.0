From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6/6] ASoC: samsung: Fix of-node refcount
	unbalance in odroid_audio_probe()
Date: Tue, 19 Feb 2019 16:46:52 +0100
Message-ID: <20190219154652.13644-7-tiwai@suse.de>
References: <20190219154652.13644-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4346426554C
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
Cc: Sangbeom Kim <sbkim73@samsung.com>, alsa-devel@alsa-project.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>
List-Id: alsa-devel@alsa-project.org

odroid_audio_probe() leaves of-nodes without unreferenced after use.
Fix it by shuffling some code a bit and add the missing of_node_put()
calls accordingly.

Fixes: aba611fc4c69 ("ASoC: samsung: Add Odroid ASoC machine driver")
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sangbeom Kim <sbkim73@samsung.com>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---

Only compile-tested.  Please review carefully.  Thanks!

 sound/soc/samsung/odroid.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/odroid.c b/sound/soc/samsung/odroid.c
index e7b371b07230..c96fbbc8c7cc 100644
--- a/sound/soc/samsung/odroid.c
+++ b/sound/soc/samsung/odroid.c
@@ -140,14 +140,14 @@ static int odroid_audio_probe(struct platform_device *pdev)
 	card->num_links = 1;
 
 	cpu = of_get_child_by_name(dev->of_node, "cpu");
-	codec = of_get_child_by_name(dev->of_node, "codec");
-
 	link->cpu_of_node = of_parse_phandle(cpu, "sound-dai", 0);
+	of_node_put(cpu);
 	if (!link->cpu_of_node) {
 		dev_err(dev, "Failed parsing cpu/sound-dai property\n");
 		return -EINVAL;
 	}
 
+	codec = of_get_child_by_name(dev->of_node, "codec");
 	ret = snd_soc_of_get_dai_link_codecs(dev, codec, link);
 	if (ret < 0)
 		goto err_put_codec_n;
@@ -186,6 +186,7 @@ static int odroid_audio_probe(struct platform_device *pdev)
 	of_node_put(link->cpu_of_node);
 err_put_codec_n:
 	snd_soc_of_put_dai_link_codecs(link);
+	of_node_put(codec);
 	return ret;
 }
 
-- 
2.16.4
