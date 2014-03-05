From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ALSA: lola: NULL deref on allocation error
Date: Wed, 5 Mar 2014 13:55:09 +0300
Message-ID: <20140305105225.GA3599@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

"chip" is NULL here.  We don't need a printk here because kmalloc() has
it built in.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/pci/lola/lola.c b/sound/pci/lola/lola.c
index d63434d8c3fb..68824cdd137d 100644
--- a/sound/pci/lola/lola.c
+++ b/sound/pci/lola/lola.c
@@ -586,7 +586,6 @@ static int lola_create(struct snd_card *card, struct pci_dev *pci,
 
 	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 	if (!chip) {
-		dev_err(chip->card->dev, "cannot allocate chip\n");
 		pci_disable_device(pci);
 		return -ENOMEM;
 	}
