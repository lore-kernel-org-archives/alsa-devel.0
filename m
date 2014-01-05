From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH] ASoC: simple-card: Do not set cpu_dai.name for
	snd_link in case DT
Date: Sun,  5 Jan 2014 10:09:58 +0400
Message-ID: <1388902199-29553-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp22.mail.ru (smtp22.mail.ru [94.100.176.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 25C66261ACD
 for <alsa-devel@alsa-project.org>; Sun,  5 Jan 2014 07:10:10 +0100 (CET)
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Alexander Shiyan <shc_work@mail.ru>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

Using cpu_dai.name for DT case will result driver cannot be
initialized. For example, device have name "ssi@10010000" in the DT
and this value is returning for us by snd_soc_of_get_dai_name()
but actual registered name of device is "10010000.ssi".

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 sound/soc/generic/simple-card.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 1d87db8..3a054c4 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -219,7 +219,8 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 	 */
 	cinfo->snd_link.name		= cinfo->name;
 	cinfo->snd_link.stream_name	= cinfo->name;
-	cinfo->snd_link.cpu_dai_name	= cinfo->cpu_dai.name;
+	if (!of_cpu)
+		cinfo->snd_link.cpu_dai_name = cinfo->cpu_dai.name;
 	cinfo->snd_link.platform_name	= cinfo->platform;
 	cinfo->snd_link.codec_name	= cinfo->codec;
 	cinfo->snd_link.codec_dai_name	= cinfo->codec_dai.name;
-- 
1.8.3.2
