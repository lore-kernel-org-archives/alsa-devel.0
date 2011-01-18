From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH 1/2] ASoC: PXA: Fix jack detection on Zipit Z2
Date: Tue, 18 Jan 2011 16:54:24 +0200
Message-ID: <1295362465-21794-1-git-send-email-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 4FA38103867
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2011 15:56:38 +0100 (CET)
Received: by ewy19 with SMTP id 19so3148205ewy.38
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2011 06:56:38 -0800 (PST)
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

Fix jack detection on Zipit Z2, otherwise it
disables headphones output when jack is connected

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 sound/soc/pxa/z2.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/pxa/z2.c b/sound/soc/pxa/z2.c
index 4cc841b..0da889d 100644
--- a/sound/soc/pxa/z2.c
+++ b/sound/soc/pxa/z2.c
@@ -105,6 +105,7 @@ static struct snd_soc_jack_gpio hs_jack_gpios[] = {
 		.name		= "hsdet-gpio",
 		.report		= SND_JACK_HEADSET,
 		.debounce_time	= 200,
+		.invert		= 1,
 	},
 };
 
-- 
1.7.4.rc1
