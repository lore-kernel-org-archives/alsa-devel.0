From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: add snd_soc_get_dai_id() function" to the asoc tree
Date: Wed, 24 May 2017 18:41:09 +0100
Message-ID: <E1dDaHV-0002eM-Q6@debutante>
References: <87d1b7oslu.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87d1b7oslu.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Archit Taneja <architt@codeaurora.org>, Jose Abreu <joabreu@synopsys.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: add snd_soc_get_dai_id() function

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From a180e8b988437b3e84a1b501ac4d073467602ca6 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 18 May 2017 01:39:25 +0000
Subject: [PATCH] ASoC: add snd_soc_get_dai_id() function

ALSA SoC needs to know connected DAI ID for detecting.
It is not a big problem if device/driver was only for sound,
but getting DAI ID will be difficult if device includes both
Video/Sound, like HDMI.
To solve this issue, this patch adds new snd_soc_get_dai_id() and
its related .of_xlate_dai_id callback on component driver.
In below case, we can handle Sound port (= port@2) as ID = 0
if .of_xlate_dai_id has its support.

	hdmi {
		port@0 { /* VIDEO */ };
		port@1 { /* VIDEO */ };
		port@2 { /* SOUND */ };
	};

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  |  3 +++
 sound/soc/soc-core.c | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 5170fd81e1fd..9c94b97c17f8 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -803,6 +803,8 @@ struct snd_soc_component_driver {
 	int (*of_xlate_dai_name)(struct snd_soc_component *component,
 				 struct of_phandle_args *args,
 				 const char **dai_name);
+	int (*of_xlate_dai_id)(struct snd_soc_component *comment,
+			       struct device_node *endpoint);
 	void (*seq_notifier)(struct snd_soc_component *, enum snd_soc_dapm_type,
 		int subseq);
 	int (*stream_event)(struct snd_soc_component *, int event);
@@ -1676,6 +1678,7 @@ unsigned int snd_soc_of_parse_daifmt(struct device_node *np,
 				     const char *prefix,
 				     struct device_node **bitclkmaster,
 				     struct device_node **framemaster);
+int snd_soc_get_dai_id(struct device_node *ep);
 int snd_soc_get_dai_name(struct of_phandle_args *args,
 			 const char **dai_name);
 int snd_soc_of_get_dai_name(struct device_node *of_node,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index aae099c0e502..b0fb17082691 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -34,6 +34,7 @@
 #include <linux/ctype.h>
 #include <linux/slab.h>
 #include <linux/of.h>
+#include <linux/of_graph.h>
 #include <linux/dmi.h>
 #include <sound/core.h>
 #include <sound/jack.h>
@@ -4044,6 +4045,42 @@ unsigned int snd_soc_of_parse_daifmt(struct device_node *np,
 }
 EXPORT_SYMBOL_GPL(snd_soc_of_parse_daifmt);
 
+int snd_soc_get_dai_id(struct device_node *ep)
+{
+	struct snd_soc_component *pos;
+	struct device_node *node;
+	int ret;
+
+	node = of_graph_get_port_parent(ep);
+
+	/*
+	 * For example HDMI case, HDMI has video/sound port,
+	 * but ALSA SoC needs sound port number only.
+	 * Thus counting HDMI DT port/endpoint doesn't work.
+	 * Then, it should have .of_xlate_dai_id
+	 */
+	ret = -ENOTSUPP;
+	mutex_lock(&client_mutex);
+	list_for_each_entry(pos, &component_list, list) {
+		struct device_node *component_of_node = pos->dev->of_node;
+
+		if (!component_of_node && pos->dev->parent)
+			component_of_node = pos->dev->parent->of_node;
+
+		if (component_of_node != node)
+			continue;
+
+		if (pos->driver->of_xlate_dai_id)
+			ret = pos->driver->of_xlate_dai_id(pos, ep);
+
+		break;
+	}
+	mutex_unlock(&client_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_soc_get_dai_id);
+
 int snd_soc_get_dai_name(struct of_phandle_args *args,
 				const char **dai_name)
 {
-- 
2.11.0
