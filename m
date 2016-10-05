From: Petr Kulhavy <brain@jikos.cz>
Subject: [PATCH v2 3/4] ASoC: tas571x: wait 50ms after
	oscillator trim
Date: Wed,  5 Oct 2016 15:51:06 +0200
Message-ID: <1475675467-5575-4-git-send-email-brain@jikos.cz>
References: <1475675467-5575-1-git-send-email-brain@jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fep27.mx.upcmail.net (fep27.mx.upcmail.net [62.179.121.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 671DA266610
 for <alsa-devel@alsa-project.org>; Wed,  5 Oct 2016 15:51:22 +0200 (CEST)
Received: from edge03.upcmail.net ([192.168.13.238]) by viefep27-int.chello.at
 (InterMail vM.8.01.05.21 201-2260-151-156-20141103) with ESMTP
 id <20161005135121.GQOC20850.viefep27-int.chello.at@edge03.upcmail.net>
 for <alsa-devel@alsa-project.org>; Wed, 5 Oct 2016 15:51:21 +0200
In-Reply-To: <1475675467-5575-1-git-send-email-brain@jikos.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, Petr Kulhavy <brain@jikos.cz>
List-Id: alsa-devel@alsa-project.org

Wait extra 50ms after writing the oscillator trim register in probe(), as
recommended by the TAS5721 and TAS5711 datasheets.

Signed-off-by: Petr Kulhavy <brain@jikos.cz>
---
 sound/soc/codecs/tas571x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/tas571x.c b/sound/soc/codecs/tas571x.c
index a8a3279..f3252af 100644
--- a/sound/soc/codecs/tas571x.c
+++ b/sound/soc/codecs/tas571x.c
@@ -744,6 +744,7 @@ static int tas571x_i2c_probe(struct i2c_client *client,
 	if (ret)
 		return ret;
 
+	usleep_range(50000, 60000);
 
 	memcpy(&priv->codec_driver, &tas571x_codec, sizeof(priv->codec_driver));
 	priv->codec_driver.component_driver.controls = priv->chip->controls;
-- 
2.7.4
