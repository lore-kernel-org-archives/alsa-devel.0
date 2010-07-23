From: Seungwhan Youn <sw.youn@samsung.com>
Subject: [PATCH] ASoC: multi-component - Fix Core AC97 set
	device name
Date: Fri, 23 Jul 2010 09:50:31 +0900
Message-ID: <1279846231-29820-1-git-send-email-sw.youn@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id C06AE243B0
	for <alsa-devel@alsa-project.org>;
	Fri, 23 Jul 2010 03:01:29 +0200 (CEST)
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
Cc: Seungwhan Youn <sw.youn@samsung.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Seungwhan Youn <claude.youn@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

AC97 driver needs to make kobject with id which from codec.
But in multi-component, this id was removed, so this patch
fix this same as 'sound/pci/ac97/ac97_codec.c'.

Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
---
 sound/soc/soc-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 23dad36..d074b2b 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -310,7 +310,7 @@ static int soc_ac97_dev_register(struct snd_soc_codec *codec)
 	codec->ac97->dev.release = soc_ac97_device_release;
 
 	dev_set_name(&codec->ac97->dev, "%d-%d:%s",
-		     codec->id, 0, codec->name);
+		     codec->ac97->bus->card->number, 0, codec->name);
 	err = device_register(&codec->ac97->dev);
 	if (err < 0) {
 		snd_printk(KERN_ERR "Can't register ac97 bus\n");
-- 
1.6.2.5
