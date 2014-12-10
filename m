From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ALSA: lola: NULL dereference on probe failure
Date: Wed, 10 Dec 2014 16:06:46 +0300
Message-ID: <20141210130646.GA18593@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by alsa0.perex.cz (Postfix) with ESMTP id DFDC9260519
 for <alsa-devel@alsa-project.org>; Wed, 10 Dec 2014 14:07:06 +0100 (CET)
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
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Benoit Taine <benoit.taine@lip6.fr>, Bjorn Helgaas <bhelgaas@google.com>
List-Id: alsa-devel@alsa-project.org

"card" is NULL if snd_card_new() fails.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/pci/lola/lola.c b/sound/pci/lola/lola.c
index a75c8dc..4cf4be5 100644
--- a/sound/pci/lola/lola.c
+++ b/sound/pci/lola/lola.c
@@ -719,7 +719,7 @@ static int lola_probe(struct pci_dev *pci,
 	err = snd_card_new(&pci->dev, index[dev], id[dev], THIS_MODULE,
 			   0, &card);
 	if (err < 0) {
-		dev_err(card->dev, "Error creating card!\n");
+		dev_err(&pci->dev, "Error creating card!\n");
 		return err;
 	}
 
