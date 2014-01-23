From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ALSA: bits vs bytes bug in snd_card_create()
Date: Thu, 23 Jan 2014 11:21:28 +0300
Message-ID: <20140123082128.GA28688@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, Yacine Belkadi <yacine.belkadi.1@gmail.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The test here is intended intended to prevent shift wrapping bugs when
we do "1U << idx2".  We should consider the number of bits in a u32
instead of the number of bytes.

Fixes: 7bb2491b35a2 ('ALSA: Add kconfig to specify the max card numbers')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
WARNING:  Please check this one carefully because I might be wrong.

diff --git a/sound/core/init.c b/sound/core/init.c
index 1351f22f651c..e9e3db321e64 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -183,7 +183,7 @@ int snd_card_create(int idx, const char *xid,
 	if (idx < 0) {
 		for (idx2 = 0; idx2 < SNDRV_CARDS; idx2++) {
 			/* idx == -1 == 0xffff means: take any free slot */
-			if (idx2 < sizeof(int) && !(idx & (1U << idx2)))
+			if (idx2 < 32 && !(idx & (1U << idx2)))
 				continue;
 			if (!test_bit(idx2, snd_cards_lock)) {
 				if (!slots[idx2] || !*slots[idx2]) {
