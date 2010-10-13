From: Mika Westerberg <mika.westerberg@iki.fi>
Subject: [PATCH 1/3] ASoC: ac97: don't call
	snd_soc_new_ac97_codec at probe
Date: Wed, 13 Oct 2010 11:30:31 +0300
Message-ID: <68ef7d7befb310b714a9db7ee7ab936bf3aa4b0e.1286958072.git.mika.westerberg@iki.fi>
References: <cover.1286958072.git.mika.westerberg@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id EB09A1039F9
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Oct 2010 10:30:27 +0200 (CEST)
Received: by mail-bw0-f51.google.com with SMTP id 18so3567297bwz.38
	for <alsa-devel@alsa-project.org>; Wed, 13 Oct 2010 01:30:27 -0700 (PDT)
In-Reply-To: <cover.1286958072.git.mika.westerberg@iki.fi>
In-Reply-To: <cover.1286958072.git.mika.westerberg@iki.fi>
References: <cover.1286958072.git.mika.westerberg@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mika Westerberg <mika.westerberg@iki.fi>, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

It is not needed since snd_ac97_mixer() will create a new ac97 object for us.
Removing the call also fixes a memory leak since codec->ac97 is set to NULL at
the beginning of snd_ac97_mixer().

Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
---
 sound/soc/codecs/ac97.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/ac97.c b/sound/soc/codecs/ac97.c
index 2c824a5..f5139ae 100644
--- a/sound/soc/codecs/ac97.c
+++ b/sound/soc/codecs/ac97.c
@@ -79,12 +79,6 @@ static int ac97_soc_probe(struct snd_soc_codec *codec)
 	struct snd_ac97_template ac97_template;
 	int ret;
 
-	ret = snd_soc_new_ac97_codec(codec, &soc_ac97_ops, 0);
-	if (ret < 0) {
-		printk(KERN_ERR "ASoC: failed to init generic ac97 glue\n");
-		return ret;
-	}
-
 	/* add codec as bus device for standard ac97 */
 	ret = snd_ac97_bus(codec->card->snd_card, 0, &soc_ac97_ops, NULL, &ac97_bus);
 	if (ret < 0)
-- 
1.5.6.5
