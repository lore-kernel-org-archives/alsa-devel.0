From: Seungwhan Youn <sw.youn@samsung.com>
Subject: [PATCH] ASoC: SAMSUNG: Debug wrong parameter
Date: Wed, 22 Dec 2010 18:46:24 +0900
Message-ID: <1293011184-5171-1-git-send-email-sw.youn@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 2D57F1038A6
	for <alsa-devel@alsa-project.org>; Wed, 22 Dec 2010 11:07:37 +0100 (CET)
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
Cc: Seungwhan Youn <sw.youn@samsung.com>, cw00.choi@samsung.com, broonie@opensource.wolfsonmicro.com, jassi.brar@samsung.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

snd_soc_jack_new()'s first parameter was changed from snd_soc_card to
snd_soc_codec after Multi-Component support patches. So, this patch
fixes parameter that we missed.

Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
---
This patch-mail is just for sure about mail-delivery, because privious mail
that I sent(with same subject and content) doesn't look deliver to alsa-devel
mailing list. So, if you received same mail before few hours ago, please
ignore this mail.

Thanks,
Claude

 sound/soc/samsung/goni_wm8994.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/samsung/goni_wm8994.c b/sound/soc/samsung/goni_wm8994.c
index cc8528c..34dd9ef 100644
--- a/sound/soc/samsung/goni_wm8994.c
+++ b/sound/soc/samsung/goni_wm8994.c
@@ -131,7 +131,7 @@ static int goni_wm8994_init(struct snd_soc_pcm_runtime *rtd)
 	snd_soc_dapm_sync(dapm);
 
 	/* Headset jack detection */
-	ret = snd_soc_jack_new(&goni, "Headset Jack",
+	ret = snd_soc_jack_new(codec, "Headset Jack",
 			SND_JACK_HEADSET | SND_JACK_MECHANICAL | SND_JACK_AVOUT,
 			&jack);
 	if (ret)
-- 
1.6.2.5
