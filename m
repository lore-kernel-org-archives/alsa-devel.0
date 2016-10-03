From: Petr Kulhavy <brain@jikos.cz>
Subject: [PATCH 1/5] ASoC: tas571x: fix missing bias save level
Date: Mon,  3 Oct 2016 16:40:46 +0200
Message-ID: <1475505650-8572-2-git-send-email-brain@jikos.cz>
References: <1475505650-8572-1-git-send-email-brain@jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fep23.mx.upcmail.net (fep23.mx.upcmail.net [62.179.121.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B9C0266B93
 for <alsa-devel@alsa-project.org>; Mon,  3 Oct 2016 16:41:08 +0200 (CEST)
Received: from edge01.upcmail.net ([192.168.13.236]) by viefep23-int.chello.at
 (InterMail vM.8.01.05.21 201-2260-151-156-20141103) with ESMTP
 id <20161003144107.FDMQ3040.viefep23-int.chello.at@edge01.upcmail.net>
 for <alsa-devel@alsa-project.org>; Mon, 3 Oct 2016 16:41:07 +0200
In-Reply-To: <1475505650-8572-1-git-send-email-brain@jikos.cz>
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

The tas571x_set_bias_level() was not saving the new bias level to
codec->dapm.bias_level. This had the effect that bias was switching between
standby and off levels and never entered the on level.

This fix saves the bias level before returning from the function.

Signed-off-by: Petr Kulhavy <brain@jikos.cz>
---
 sound/soc/codecs/tas571x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/tas571x.c b/sound/soc/codecs/tas571x.c
index df5e5cb..e996313 100644
--- a/sound/soc/codecs/tas571x.c
+++ b/sound/soc/codecs/tas571x.c
@@ -360,6 +360,7 @@ static int tas571x_set_bias_level(struct snd_soc_codec *codec,
 		break;
 	}
 
+	codec->dapm.bias_level = level;
 	return 0;
 }
 
-- 
2.7.4
