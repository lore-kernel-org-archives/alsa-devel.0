From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: JZ4740: Fix i2s shutdown
Date: Sat, 30 Apr 2011 22:28:20 +0200
Message-ID: <1304195300-5483-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-170.synserver.de (smtp-out-171.synserver.de
	[212.40.185.171]) by alsa0.perex.cz (Postfix) with SMTP id DB75624543
	for <alsa-devel@alsa-project.org>;
	Sat, 30 Apr 2011 22:28:34 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The i2s shutdown callback has the check whether it should be disabled reversed.
Currently it is disabled if another stream is still active, but kept enabled if
the last stream is closed. This patch fixes it.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/jz4740/jz4740-i2s.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index 419bf4f..cd22a54 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -133,7 +133,7 @@ static void jz4740_i2s_shutdown(struct snd_pcm_substream *substream,
 	struct jz4740_i2s *i2s = snd_soc_dai_get_drvdata(dai);
 	uint32_t conf;
 
-	if (!dai->active)
+	if (dai->active)
 		return;
 
 	conf = jz4740_i2s_read(i2s, JZ_REG_AIC_CONF);
-- 
1.7.2.5
