From: Tzung-Bi Shih <tzungbi@google.com>
Subject: [PATCH 3/4] ASoC: mediatek: mt8183: remove forward
	declaration of headset_init
Date: Fri, 30 Aug 2019 15:42:39 +0800
Message-ID: <20190830074240.195166-4-tzungbi@google.com>
References: <20190830074240.195166-1-tzungbi@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com
 [IPv6:2607:f8b0:4864:20::74a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 291ADF805F7
 for <alsa-devel@alsa-project.org>; Fri, 30 Aug 2019 09:43:02 +0200 (CEST)
Received: by mail-qk1-x74a.google.com with SMTP id y188so6327713qke.18
 for <alsa-devel@alsa-project.org>; Fri, 30 Aug 2019 00:43:02 -0700 (PDT)
In-Reply-To: <20190830074240.195166-1-tzungbi@google.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org
Cc: tzungbi@google.com, alsa-devel@alsa-project.org, dgreid@google.com, cychiang@google.com
List-Id: alsa-devel@alsa-project.org

The forward declaration of mt8183_mt6358_ts3a227_max98357_headset_init
is for cyclic dependency between card, headset_dev, and headset_init.

It used to be:
- card depends on headset_dev
- headset_dev depends on headset_init
- headset_init depends on card

Commit a962a809e5e4 ("ASoC: mediatek: mt8183: make headset codec
optional") removed the cyclic dependency.

Thus, it is safe to remove the forward declaration.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 .../mt8183/mt8183-mt6358-ts3a227-max98357.c         | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
index a7ad41b6e885..30a7735c4af3 100644
--- a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
+++ b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
@@ -390,14 +390,6 @@ mt8183_mt6358_ts3a227_max98357_dai_links[] = {
 	},
 };
 
-static int
-mt8183_mt6358_ts3a227_max98357_headset_init(struct snd_soc_component *cpnt);
-
-static struct snd_soc_aux_dev mt8183_mt6358_ts3a227_max98357_headset_dev = {
-	.dlc = COMP_EMPTY(),
-	.init = mt8183_mt6358_ts3a227_max98357_headset_init,
-};
-
 static struct snd_soc_card mt8183_mt6358_ts3a227_max98357_card = {
 	.name = "mt8183_mt6358_ts3a227_max98357",
 	.owner = THIS_MODULE,
@@ -428,6 +420,11 @@ mt8183_mt6358_ts3a227_max98357_headset_init(struct snd_soc_component *component)
 	return ret;
 }
 
+static struct snd_soc_aux_dev mt8183_mt6358_ts3a227_max98357_headset_dev = {
+	.dlc = COMP_EMPTY(),
+	.init = mt8183_mt6358_ts3a227_max98357_headset_init,
+};
+
 static int
 mt8183_mt6358_ts3a227_max98357_dev_probe(struct platform_device *pdev)
 {
-- 
2.23.0.187.g17f5b7556c-goog
