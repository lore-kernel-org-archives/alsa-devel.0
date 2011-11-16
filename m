From: Leon Romanovsky <leon@leon.nu>
Subject: [PATCH 3/6] ASoC: alc5632: Fix compile without
	CONFIG_PM
Date: Wed, 16 Nov 2011 12:07:00 +0200
Message-ID: <1321438023-29660-4-git-send-email-leon@leon.nu>
References: <1321438023-29660-1-git-send-email-leon@leon.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 30CF424452
	for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2011 11:07:21 +0100 (CET)
Received: by mail-ey0-f179.google.com with SMTP id 10so213890eyz.38
	for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2011 02:07:21 -0800 (PST)
In-Reply-To: <1321438023-29660-1-git-send-email-leon@leon.nu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@ti.com
Cc: alsa-devel@alsa-project.org, Leon Romanovsky <leon@leon.nu>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Leon Romanovsky <leon@leon.nu>
---
 sound/soc/codecs/alc5632.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/alc5632.c b/sound/soc/codecs/alc5632.c
index b72d467..902f178 100644
--- a/sound/soc/codecs/alc5632.c
+++ b/sound/soc/codecs/alc5632.c
@@ -1023,6 +1023,7 @@ static struct snd_soc_dai_driver alc5632_dai = {
 	.symmetric_rates = 1,
 };
 
+#ifdef CONFIG_PM
 static int alc5632_suspend(struct snd_soc_codec *codec, pm_message_t mesg)
 {
 	alc5632_set_bias_level(codec, SND_SOC_BIAS_OFF);
@@ -1038,6 +1039,10 @@ static int alc5632_resume(struct snd_soc_codec *codec)
 	alc5632_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 	return 0;
 }
+#else
+#define	alc5632_suspend	NULL
+#define	alc5632_resume	NULL
+#endif
 
 static int alc5632_probe(struct snd_soc_codec *codec)
 {
-- 
1.7.3.4
