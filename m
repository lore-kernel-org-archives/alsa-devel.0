From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 3/3] sound/soc/soc-core.c: drop kfree of
	devm_kzalloc's data
Date: Sat,  4 Aug 2012 14:00:32 +0200
Message-ID: <1344081632-4729-3-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1-relais-roc.national.inria.fr
 (mail1-relais-roc.national.inria.fr [192.134.164.82])
 by alsa0.perex.cz (Postfix) with ESMTP id 433922652B3
 for <alsa-devel@alsa-project.org>; Sat,  4 Aug 2012 14:00:40 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, matthias@kaehlcke.net
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Using kfree to free data allocated with devm_kzalloc causes double frees.

The semantic patch that fixes this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression x;
@@

x = devm_kzalloc(...)
...
?-kfree(x);
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
The kfrees were introduced in b761c0ca.

 sound/soc/soc-core.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index f81c597..86d7a36 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -4136,7 +4136,6 @@ int snd_soc_of_parse_audio_routing(struct snd_soc_card *card,
 			dev_err(card->dev,
 				"Property '%s' index %d could not be read: %d\n",
 				propname, 2 * i, ret);
-			kfree(routes);
 			return -EINVAL;
 		}
 		ret = of_property_read_string_index(np, propname,
@@ -4145,7 +4144,6 @@ int snd_soc_of_parse_audio_routing(struct snd_soc_card *card,
 			dev_err(card->dev,
 				"Property '%s' index %d could not be read: %d\n",
 				propname, (2 * i) + 1, ret);
-			kfree(routes);
 			return -EINVAL;
 		}
 	}
