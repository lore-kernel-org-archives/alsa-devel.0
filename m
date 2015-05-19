From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/7] ASoC: alc5623: Replace direct
	snd_soc_codec dapm field access
Date: Tue, 19 May 2015 21:49:05 +0200
Message-ID: <1432064952-31997-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-051.synserver.de (smtp-out-051.synserver.de
 [212.40.185.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B47926058A
 for <alsa-devel@alsa-project.org>; Tue, 19 May 2015 21:49:19 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The dapm field of the snd_soc_codec struct is eventually going to be
removed, in preparation for this replace all manual access to
codec->dapm with snd_soc_codec_get_dapm().

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
Full series depends on topic/dapm
---
 sound/soc/codecs/alc5623.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/alc5623.c b/sound/soc/codecs/alc5623.c
index e92b5ae..0fc24e0 100644
--- a/sound/soc/codecs/alc5623.c
+++ b/sound/soc/codecs/alc5623.c
@@ -893,7 +893,7 @@ static int alc5623_resume(struct snd_soc_codec *codec)
 static int alc5623_probe(struct snd_soc_codec *codec)
 {
 	struct alc5623_priv *alc5623 = snd_soc_codec_get_drvdata(codec);
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 
 	alc5623_reset(codec);
 
-- 
1.8.0
