From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH] ASoC: add snd_soc_of_parse_master_clkdir() for
	dt
Date: Tue, 31 Dec 2013 16:10:44 +0800
Message-ID: <1388477444-18745-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0250.outbound.messaging.microsoft.com [213.199.154.250])
 by alsa0.perex.cz (Postfix) with ESMTP id BC209261983
 for <alsa-devel@alsa-project.org>; Tue, 31 Dec 2013 10:05:37 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, Xiubo Li <Li.Xiubo@freescale.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch adds snd_soc_of_parse_master_clkdir() and supports below
style on dt:

[prefix]master-clkdir;

If this property is absent 0 will be returned, 1 otherwise.
0 : SND_SOC_CLOCK_IN
1 : SND_SOC_CLOCK_OUT

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---

I'm not very sure whether this patch is need for dt.

For the CPU and CODEC devices' sysclk directions maybe different of
the same DAI link.



 include/sound/soc.h  |  2 ++
 sound/soc/soc-core.c | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 5a049d9..1d6396a 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1170,6 +1170,8 @@ int snd_soc_of_parse_card_name(struct snd_soc_card *card,
 			       const char *propname);
 int snd_soc_of_parse_audio_routing(struct snd_soc_card *card,
 				   const char *propname);
+unsigned int snd_soc_of_parse_master_clkdir(struct device_node *np,
+					    const char *prefix);
 unsigned int snd_soc_of_parse_daifmt(struct device_node *np,
 				     const char *prefix);
 int snd_soc_of_get_dai_name(struct device_node *of_node,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index be88df5..faf102f 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -4472,6 +4472,25 @@ int snd_soc_of_parse_audio_routing(struct snd_soc_card *card,
 }
 EXPORT_SYMBOL_GPL(snd_soc_of_parse_audio_routing);
 
+unsigned int snd_soc_of_parse_master_clkdir(struct device_node *np,
+					    const char *prefix)
+{
+	char prop[128];
+
+	if (!prefix)
+		prefix = "";
+
+	/*
+	 * check "[prefix]master-clkdir"
+	 * true means SND_SOC_CLOCK_OUT
+	 * false means SND_SOC_CLOCK_IN
+	 */
+	snprintf(prop, sizeof(prop), "%smaster-clkdir", prefix);
+
+	return !!of_property_read_bool(np, prop);
+}
+EXPORT_SYMBOL_GPL(snd_soc_of_parse_master_clkdir);
+
 unsigned int snd_soc_of_parse_daifmt(struct device_node *np,
 				     const char *prefix)
 {
-- 
1.8.4
