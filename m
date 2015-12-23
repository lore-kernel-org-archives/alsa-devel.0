From: Andrzej Hajda <a.hajda@samsung.com>
Subject: [PATCH] ASoC: rsnd: fix usrcnt decrementing bug
Date: Wed, 23 Dec 2015 11:37:21 +0100
Message-ID: <1450867041-729-4-git-send-email-a.hajda@samsung.com>
References: <1450867041-729-1-git-send-email-a.hajda@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by alsa0.perex.cz (Postfix) with ESMTP id E8380265062
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2015 11:39:11 +0100 (CET)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NZT00CHV49638B0@mailout2.w1.samsung.com> for
 alsa-devel@alsa-project.org; Wed, 23 Dec 2015 10:39:06 +0000 (GMT)
In-reply-to: <1450867041-729-1-git-send-email-a.hajda@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Andrzej Hajda <a.hajda@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: alsa-devel@alsa-project.org

Field usrcnt is unsigned so it cannot be lesser than zero.

The problem has been detected using proposed semantic patch
scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci [1].

[1]: http://permalink.gmane.org/gmane.linux.kernel/2038576

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 sound/soc/sh/rcar/ssi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 0b91692..8ca30fd 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -381,9 +381,9 @@ rsnd_ssi_quit_end:
 
 	rsnd_mod_power_off(mod);
 
-	ssi->usrcnt--;
-
-	if (ssi->usrcnt < 0)
+	if (ssi->usrcnt > 0)
+		ssi->usrcnt--;
+	else
 		dev_err(dev, "%s[%d] usrcnt error\n",
 			rsnd_mod_name(mod), rsnd_mod_id(mod));
 
-- 
1.9.1
