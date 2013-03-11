From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] ALSA: asihpi - fix potential NULL pointer dereference
Date: Tue, 12 Mar 2013 00:16:40 +0800
Message-ID: <CAPgLHd8oUa=YMtQ1P5Qo4=M0ysqJV4L7U9RCN0W7aB+A4xLbvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.de
Cc: yongjun_wei@trendmicro.com.cn, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

The dereference should be moved below the NULL test.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 sound/pci/asihpi/asihpi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/asihpi/asihpi.c b/sound/pci/asihpi/asihpi.c
index 3536b07..0aabfed 100644
--- a/sound/pci/asihpi/asihpi.c
+++ b/sound/pci/asihpi/asihpi.c
@@ -2549,7 +2549,7 @@ static int snd_asihpi_sampleclock_add(struct snd_card_asihpi *asihpi,
 
 static int snd_card_asihpi_mixer_new(struct snd_card_asihpi *asihpi)
 {
-	struct snd_card *card = asihpi->card;
+	struct snd_card *card;
 	unsigned int idx = 0;
 	unsigned int subindex = 0;
 	int err;
@@ -2557,6 +2557,7 @@ static int snd_card_asihpi_mixer_new(struct snd_card_asihpi *asihpi)
 
 	if (snd_BUG_ON(!asihpi))
 		return -EINVAL;
+	card = asihpi->card;
 	strcpy(card->mixername, "Asihpi Mixer");
 
 	err =
