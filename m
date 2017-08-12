From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/3] ALSA: rme9652: Delete an error message for a failed
 memory allocation in snd_hdspm_create()
Date: Sat, 12 Aug 2017 17:33:30 +0200
Message-ID: <7f0e9d18-4402-61d3-b5d4-3ea0b581ccd8@users.sourceforge.net>
References: <a3223028-5b12-0efd-ffe0-aa7300334081@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a3223028-5b12-0efd-ffe0-aa7300334081@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Colin Ian King <colin.king@canonical.com>, Jaroslav Kysela <perex@perex.cz>, Julia Lawall <Julia.Lawall@lip6.fr>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 12 Aug 2017 16:10:32 +0200

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/rme9652/hdspm.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 2a3a916e5d15..d448cf474c1b 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -6641,9 +6641,5 @@ static int snd_hdspm_create(struct snd_card *card,
-	if (!hdspm->mixer) {
-		dev_err(card->dev,
-			"unable to kmalloc Mixer memory of %d Bytes\n",
-				(int)sizeof(struct hdspm_mixer));
+	if (!hdspm->mixer)
 		return -ENOMEM;
-	}
 
 	hdspm->port_names_in = NULL;
 	hdspm->port_names_out = NULL;
-- 
2.14.0
