From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH] ASoC: cs4271: free reset gpio in
	cs4271_remove()
Date: Wed, 19 Feb 2014 12:07:12 +0100
Message-ID: <1392808032-25756-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f47.google.com (mail-bk0-f47.google.com
 [209.85.214.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 3928826530E
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 12:07:19 +0100 (CET)
Received: by mail-bk0-f47.google.com with SMTP id d7so151152bkh.6
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 03:07:18 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, subaparts@yandex.ru
Cc: brian.austin@cirrus.com, alsa-devel@alsa-project.org, Paul.Handrigan@cirrus.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

The reset GPIO line is acquired in cs4271_probe(), so it should be
freed from cs4271_remove() as well. This way, the driver can unloaded
and reloaded more than once.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/soc/codecs/cs4271.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
index ce05fd9..aeaa5c6 100644
--- a/sound/soc/codecs/cs4271.c
+++ b/sound/soc/codecs/cs4271.c
@@ -604,9 +604,11 @@ static int cs4271_remove(struct snd_soc_codec *codec)
 {
 	struct cs4271_private *cs4271 = snd_soc_codec_get_drvdata(codec);
 
-	if (gpio_is_valid(cs4271->gpio_nreset))
+	if (gpio_is_valid(cs4271->gpio_nreset)) {
 		/* Set codec to the reset state */
 		gpio_set_value(cs4271->gpio_nreset, 0);
+		devm_gpio_free(codec->dev, cs4271->gpio_nreset);
+	}
 
 	return 0;
 };
-- 
1.8.5.3
