From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 2/3] ALSA: ASoC: cs4271: fix property check
Date: Fri, 30 Nov 2012 11:28:56 +0100
Message-ID: <1354271337-15113-2-git-send-email-zonque@gmail.com>
References: <1354271337-15113-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 770952650FF
 for <alsa-devel@alsa-project.org>; Fri, 30 Nov 2012 11:29:14 +0100 (CET)
In-Reply-To: <1354271337-15113-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@opensource.wolfsonmicro.com, lrg@ti.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

The driver had the property check for 'cirrus,amutec_eq_bmutec' the
wrong way around. That happens if you misspell the property in the
bindings during tests.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/soc/codecs/cs4271.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
index 70de900..ac99238 100644
--- a/sound/soc/codecs/cs4271.c
+++ b/sound/soc/codecs/cs4271.c
@@ -481,7 +481,7 @@ static int cs4271_probe(struct snd_soc_codec *codec)
 		gpio_nreset = of_get_named_gpio(codec->dev->of_node,
 						"reset-gpio", 0);
 
-		if (!of_get_property(codec->dev->of_node,
+		if (of_get_property(codec->dev->of_node,
 				     "cirrus,amutec-eq-bmutec", NULL))
 			amutec_eq_bmutec = true;
 	}
-- 
1.7.11.7
