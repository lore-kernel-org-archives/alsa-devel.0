From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/3] ASoC: soc_codec_reg_show use
	snd_soc_codec_readable_register
Date: Sat, 27 Aug 2011 18:24:14 +0200
Message-ID: <1314462254-11717-3-git-send-email-lars@metafoo.de>
References: <1314462254-11717-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-092.synserver.de (smtp-out-093.synserver.de
	[212.40.185.93]) by alsa0.perex.cz (Postfix) with SMTP id C4EF2247EE
	for <alsa-devel@alsa-project.org>;
	Sat, 27 Aug 2011 18:25:10 +0200 (CEST)
In-Reply-To: <1314462254-11717-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Use snd_soc_codec_readable_register instead of open-coding it.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 4065d4e..fc7fff3 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -143,7 +143,7 @@ static ssize_t soc_codec_reg_show(struct snd_soc_codec *codec, char *buf,
 		step = codec->driver->reg_cache_step;
 
 	for (i = 0; i < codec->driver->reg_cache_size; i += step) {
-		if (codec->readable_register && !codec->readable_register(codec, i))
+		if (!snd_soc_codec_readable_register(codec, i))
 			continue;
 		if (codec->driver->display_register) {
 			count += codec->driver->display_register(codec, buf + count,
-- 
1.7.2.5
