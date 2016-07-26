From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 5/5] ALSA: soc-tpa6130a2: add static qualifier
	for file local symbols
Date: Tue, 26 Jul 2016 22:41:57 +0900
Message-ID: <1469540517-32466-6-git-send-email-o-takashi@sakamocchi.jp>
References: <1469540517-32466-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 5BAFC26813F
 for <alsa-devel@alsa-project.org>; Tue, 26 Jul 2016 15:42:04 +0200 (CEST)
In-Reply-To: <1469540517-32466-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, Helen Koike <helen.koike@collabora.co.uk>
List-Id: alsa-devel@alsa-project.org

Sparse reports a below warning.

tpa6130a2.c:193:33: warning: symbol 'tpa6130a2_component_driver' was not declared. Should it be static?

These two symbols are just used inner the file, thus it's better to add
static qualifier.

This commit adds it.

Fixes: cb7e62256e99 ('ASoC: tpa6130a2: Register component')
CC: Helen Koike <helen.koike@collabora.co.uk>
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/soc/codecs/tpa6130a2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index f1ea052..8c67f3a 100644
--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -190,7 +190,7 @@ static const struct snd_soc_dapm_route tpa6130a2_dapm_routes[] = {
 	{ "Right PGA", NULL, "Power" },
 };
 
-struct snd_soc_component_driver tpa6130a2_component_driver = {
+static struct snd_soc_component_driver tpa6130a2_component_driver = {
 	.name = "tpa6130a2",
 	.probe = tpa6130a2_component_probe,
 	.dapm_widgets = tpa6130a2_dapm_widgets,
-- 
2.7.4
