From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 7/13] ASoC: fsi: Deletion of unnecessary checks before the
 function call "clk_enable"
Date: Sun, 04 Jan 2015 14:11:58 +0100
Message-ID: <54A93C1E.4050200@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net> <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6> <530A086E.8010901@users.sourceforge.net> <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6> <530A72AA.3000601@users.sourceforge.net> <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6> <530B5FB6.6010207@users.sourceforge.net> <alpine.DEB.2.10.1402241710370.2074@hadrien> <530C5E18.1020800@users.sourceforge.net> <alpine.DEB.2.10.1402251014170.2080@hadrien> <530CD2C4.4050903@users.sourceforge.net> <alpine.DEB.2.10.1402251840450.7035@hadrien> <530CF8FF.8080600@users.sourceforge.net> <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6> <530DD06F.4090703@users.sourceforge.net> <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6> <5317A59D.4@users.so
 urceforge.net> <54A9355F.4050102@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54A9355F.4050102@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 3 Jan 2015 19:25:55 +0100

The clk_enable() function tests whether its argument is NULL and then
returns immediately. Thus the test around the call is not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/soc/sh/fsi.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
index 8869971..d49f25f 100644
--- a/sound/soc/sh/fsi.c
+++ b/sound/soc/sh/fsi.c
@@ -820,12 +820,9 @@ static int fsi_clk_enable(struct device *dev,
 			return ret;
 		}
 
-		if (clock->xck)
-			clk_enable(clock->xck);
-		if (clock->ick)
-			clk_enable(clock->ick);
-		if (clock->div)
-			clk_enable(clock->div);
+		clk_enable(clock->xck);
+		clk_enable(clock->ick);
+		clk_enable(clock->div);
 
 		clock->count++;
 	}
-- 
2.2.1
