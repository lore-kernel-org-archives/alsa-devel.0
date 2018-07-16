From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ALSA: es1688: remove redundant pointer chip
Date: Mon, 16 Jul 2018 09:43:08 +0100
Message-ID: <20180716084308.15571-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

Pointer chip is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'chip' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/isa/es1688/es1688.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/isa/es1688/es1688.c b/sound/isa/es1688/es1688.c
index a826c138e7f5..3dfe7e592c25 100644
--- a/sound/isa/es1688/es1688.c
+++ b/sound/isa/es1688/es1688.c
@@ -260,7 +260,6 @@ static int snd_es968_pnp_detect(struct pnp_card_link *pcard,
 	struct snd_card *card;
 	static unsigned int dev;
 	int error;
-	struct snd_es1688 *chip;
 
 	if (snd_es968_pnp_is_probed)
 		return -EBUSY;
@@ -276,7 +275,6 @@ static int snd_es968_pnp_detect(struct pnp_card_link *pcard,
 			     sizeof(struct snd_es1688), &card);
 	if (error < 0)
 		return error;
-	chip = card->private_data;
 
 	error = snd_card_es968_pnp(card, dev, pcard, pid);
 	if (error < 0) {
-- 
2.17.1
