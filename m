From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH] ASoC: sta32x: set ->component pointer in
	private struct
Date: Thu, 11 Oct 2018 20:32:05 +0200
Message-ID: <20181011183205.18671-1-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
 by alsa0.perex.cz (Postfix) with ESMTP id 54B1A2678E9
 for <alsa-devel@alsa-project.org>; Thu, 11 Oct 2018 20:32:13 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

The ESD watchdog code in sta32x_watchdog() dereferences the pointer
which is never assigned.

This is a regression from a1be4cead9b950 ("ASoC: sta32x: Convert to direct
regmap API usage.") which went unnoticed since nobody seems to use that ESD
workaround.

Fixes: a1be4cead9b950 ("ASoC: sta32x: Convert to direct regmap API usage.")
Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 sound/soc/codecs/sta32x.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/sta32x.c b/sound/soc/codecs/sta32x.c
index 22de1593443c..a878c8d92e68 100644
--- a/sound/soc/codecs/sta32x.c
+++ b/sound/soc/codecs/sta32x.c
@@ -879,6 +879,9 @@ static int sta32x_probe(struct snd_soc_component *component)
 	struct sta32x_priv *sta32x = snd_soc_component_get_drvdata(component);
 	struct sta32x_platform_data *pdata = sta32x->pdata;
 	int i, ret = 0, thermal = 0;
+
+	sta32x->component = component;
+
 	ret = regulator_bulk_enable(ARRAY_SIZE(sta32x->supplies),
 				    sta32x->supplies);
 	if (ret != 0) {
-- 
2.17.1
