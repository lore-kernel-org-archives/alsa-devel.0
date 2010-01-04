From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH] ASoC: fixup oops in generic AC97 codec glue
Date: Mon,  4 Jan 2010 16:29:49 +0100
Message-ID: <1262618989-15018-1-git-send-email-manuel.lauss@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f217.google.com (mail-bw0-f217.google.com
	[209.85.218.217])
	by alsa0.perex.cz (Postfix) with ESMTP id 82C3C2459B
	for <alsa-devel@alsa-project.org>; Mon,  4 Jan 2010 16:27:58 +0100 (CET)
Received: by bwz9 with SMTP id 9so24048591bwz.32
	for <alsa-devel@alsa-project.org>; Mon, 04 Jan 2010 07:27:57 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Manuel Lauss <manuel.lauss@gmail.com>, alsa-devel@alsa-project.org, pascal@pabr.org
List-Id: alsa-devel@alsa-project.org

Initialize the glue by calling snd_soc_new_ac97_codec() as is done
in other ASoC AC97 codecs.  Fixes an oops caused by dereferencing
uninitialized members in snd_soc_new_pcms().

Run-tested on Au1250.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
Fixes the oops I reported here:
http://mailman.alsa-project.org/pipermail/alsa-devel/2009-December/023995.html

 sound/soc/codecs/ac97.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/ac97.c b/sound/soc/codecs/ac97.c
index 69bd0ac..a1bbe16 100644
--- a/sound/soc/codecs/ac97.c
+++ b/sound/soc/codecs/ac97.c
@@ -102,6 +102,12 @@ static int ac97_soc_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&codec->dapm_widgets);
 	INIT_LIST_HEAD(&codec->dapm_paths);
 
+	ret = snd_soc_new_ac97_codec(codec, &soc_ac97_ops, 0);
+	if (ret < 0) {
+		printk(KERN_ERR "ASoC: failed to init gen ac97 glue\n");
+		goto err;
+	}
+
 	/* register pcms */
 	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
 	if (ret < 0)
-- 
1.6.6.rc3
