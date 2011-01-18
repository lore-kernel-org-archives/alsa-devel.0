From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH 2/2] ASoC: PXA: Fix codec address on Zipit Z2
Date: Tue, 18 Jan 2011 16:54:25 +0200
Message-ID: <1295362465-21794-2-git-send-email-anarsoul@gmail.com>
References: <1295362465-21794-1-git-send-email-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 97083103867
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2011 15:57:01 +0100 (CET)
Received: by mail-ew0-f51.google.com with SMTP id 19so3148205ewy.38
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2011 06:57:01 -0800 (PST)
In-Reply-To: <1295362465-21794-1-git-send-email-anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Marek Vasut <marek.vasut@gmail.com>, anarsoul@gmail.com
List-Id: alsa-devel@alsa-project.org

WM8750 address is 0x1b, not 0x1a. Without this fix
ALSA detects no sound cards on Zipit

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 sound/soc/pxa/z2.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/pxa/z2.c b/sound/soc/pxa/z2.c
index 0da889d..62c77dc 100644
--- a/sound/soc/pxa/z2.c
+++ b/sound/soc/pxa/z2.c
@@ -193,7 +193,7 @@ static struct snd_soc_dai_link z2_dai = {
 	.cpu_dai_name	= "pxa2xx-i2s",
 	.codec_dai_name	= "wm8750-hifi",
 	.platform_name = "pxa-pcm-audio",
-	.codec_name	= "wm8750-codec.0-001a",
+	.codec_name	= "wm8750-codec.0-001b",
 	.init		= z2_wm8750_init,
 	.ops		= &z2_ops,
 };
-- 
1.7.4.rc1
