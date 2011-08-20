From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: soc-core: use GFP_KERNEL flag for kmalloc  in
 snd_soc_cnew
Date: Sat, 20 Aug 2011 11:03:44 +0800
Message-ID: <1313809425.4691.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

GFP_ATOMIC is not needed here, use GFP_KERNEL instead.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/soc-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index ae93aa8..b6d8716 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1913,7 +1913,7 @@ struct snd_kcontrol *snd_soc_cnew(const struct snd_kcontrol_new *_template,
 
 	if (prefix) {
 		name_len = strlen(long_name) + strlen(prefix) + 2;
-		name = kmalloc(name_len, GFP_ATOMIC);
+		name = kmalloc(name_len, GFP_KERNEL);
 		if (!name)
 			return NULL;
 
-- 
1.7.4.1
