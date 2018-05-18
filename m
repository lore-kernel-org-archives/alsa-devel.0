From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] ALSA: dice: fix a bounds check in
 snd_dice_detect_tcelectronic_formats()
Date: Fri, 18 May 2018 12:16:07 +0300
Message-ID: <20180518091607.GA32078@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 by alsa0.perex.cz (Postfix) with ESMTP id CD237266F44
 for <alsa-devel@alsa-project.org>; Fri, 18 May 2018 11:16:21 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

The "entry" pointer is always non-NULL so this test for out of bounds
won't work.

Fixes: f1f0f330b1d0 ("ALSA: dice: add parameters of stream formats for models produced by TC Electronic")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/firewire/dice/dice-tcelectronic.c b/sound/firewire/dice/dice-tcelectronic.c
index af8203b9d1a6..e134a5110c6c 100644
--- a/sound/firewire/dice/dice-tcelectronic.c
+++ b/sound/firewire/dice/dice-tcelectronic.c
@@ -75,13 +75,12 @@ int snd_dice_detect_tcelectronic_formats(struct snd_dice *dice)
 		}
 	}
 
-	entry = NULL;
 	for (i = 0; i < ARRAY_SIZE(entries); ++i) {
 		entry = entries + i;
 		if (entry->model_id == model_id)
 			break;
 	}
-	if (!entry)
+	if (i == ARRAY_SIZE(entries))
 		return -ENODEV;
 
 	memcpy(dice->tx_pcm_chs, entry->spec->tx_pcm_chs,
