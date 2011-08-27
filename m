From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/3] ASoC: snd_soc_codec_{readable,
	writable}_register change default to true
Date: Sat, 27 Aug 2011 18:24:12 +0200
Message-ID: <1314462254-11717-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-092.synserver.de (smtp-out-093.synserver.de
	[212.40.185.93]) by alsa0.perex.cz (Postfix) with SMTP id 7A3B6247F0
	for <alsa-devel@alsa-project.org>;
	Sat, 27 Aug 2011 18:25:09 +0200 (CEST)
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

Change the default return value of snd_soc_codec_{readable,writable}_register to
true when no codec specific callback for this function is given. Otherwise all
registers of that codec will neither be readable nor writable, which is most
certainly not what we want.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index fd173f6..4065d4e 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1635,7 +1635,7 @@ int snd_soc_codec_readable_register(struct snd_soc_codec *codec,
 	if (codec->readable_register)
 		return codec->readable_register(codec, reg);
 	else
-		return 0;
+		return 1;
 }
 EXPORT_SYMBOL_GPL(snd_soc_codec_readable_register);
 
@@ -1653,7 +1653,7 @@ int snd_soc_codec_writable_register(struct snd_soc_codec *codec,
 	if (codec->writable_register)
 		return codec->writable_register(codec, reg);
 	else
-		return 0;
+		return 1;
 }
 EXPORT_SYMBOL_GPL(snd_soc_codec_writable_register);
 
-- 
1.7.2.5
