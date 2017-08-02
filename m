From: srinivas.kandagatla@linaro.org
Subject: [PATCH v2 1/6] ASoC: jack: fix snd_soc_codec_set_jack
	return error
Date: Wed,  2 Aug 2017 19:09:25 +0200
Message-ID: <20170802170930.26083-2-srinivas.kandagatla@linaro.org>
References: <20170802170930.26083-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f54.google.com (mail-it0-f54.google.com
 [209.85.214.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 59B52267359
 for <alsa-devel@alsa-project.org>; Wed,  2 Aug 2017 19:09:44 +0200 (CEST)
Received: by mail-it0-f54.google.com with SMTP id h199so27909619ith.1
 for <alsa-devel@alsa-project.org>; Wed, 02 Aug 2017 10:09:44 -0700 (PDT)
In-Reply-To: <20170802170930.26083-1-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Banajit Goswami <bgoswami@codeaurora.org>, alsa-devel@alsa-project.org
Cc: damien.riegel@savoirfairelinux.com, Patrick Lai <plai@codeaurora.org>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch changes the error code returned by snd_soc_codec_set_jack()
from -EINVAL to -ENOTSUPP. The reason to do this is to make the caller
aware that the underlying codec does not support this callback. This can
make the caller write the code to handle this case properly.
Other reason is that -EINVAL is not the correct error to return in this
case anyway.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/soc-jack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index 7daf21f..42ca9f1 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -36,7 +36,7 @@ int snd_soc_codec_set_jack(struct snd_soc_codec *codec,
 	if (codec->driver->set_jack)
 		return codec->driver->set_jack(codec, jack, data);
 	else
-		return -EINVAL;
+		return -ENOTSUPP;
 }
 EXPORT_SYMBOL_GPL(snd_soc_codec_set_jack);
 
-- 
2.9.3
