From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 11/21] ALSA: asihpi: Remove always NULL
	parameter
Date: Fri,  2 Jan 2015 12:24:45 +0100
Message-ID: <1420197895-17696-12-git-send-email-lars@metafoo.de>
References: <1420197895-17696-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-227.synserver.de (smtp-out-232.synserver.de
 [212.40.185.232])
 by alsa0.perex.cz (Postfix) with ESMTP id 29E1A26053D
 for <alsa-devel@alsa-project.org>; Fri,  2 Jan 2015 12:25:15 +0100 (CET)
In-Reply-To: <1420197895-17696-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org, Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
List-Id: alsa-devel@alsa-project.org

snd_asihpi_hpi_new() takes a pointer to a pointer of a hwdep where if this
parameter is provided the newly allocated hwdep is stored. All callers pass
NULL though, so remove the parameter. This makes the code a bit cleaner and
shorter.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/pci/asihpi/asihpi.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/sound/pci/asihpi/asihpi.c b/sound/pci/asihpi/asihpi.c
index e9273fb..7a55fef 100644
--- a/sound/pci/asihpi/asihpi.c
+++ b/sound/pci/asihpi/asihpi.c
@@ -2832,14 +2832,11 @@ static int snd_asihpi_hpi_ioctl(struct snd_hwdep *hw, struct file *file,
 /* results in /dev/snd/hwC#D0 file for each card with index #
    also /proc/asound/hwdep will contain '#-00: asihpi (HPI) for each card'
 */
-static int snd_asihpi_hpi_new(struct snd_card_asihpi *asihpi,
-			      int device, struct snd_hwdep **rhwdep)
+static int snd_asihpi_hpi_new(struct snd_card_asihpi *asihpi, int device)
 {
 	struct snd_hwdep *hw;
 	int err;
 
-	if (rhwdep)
-		*rhwdep = NULL;
 	err = snd_hwdep_new(asihpi->card, "HPI", device, &hw);
 	if (err < 0)
 		return err;
@@ -2849,8 +2846,6 @@ static int snd_asihpi_hpi_new(struct snd_card_asihpi *asihpi,
 	hw->ops.ioctl = snd_asihpi_hpi_ioctl;
 	hw->ops.release = snd_asihpi_hpi_release;
 	hw->private_data = asihpi;
-	if (rhwdep)
-		*rhwdep = hw;
 	return 0;
 }
 
@@ -2993,7 +2988,7 @@ static int snd_asihpi_probe(struct pci_dev *pci_dev,
 
 	/* always create, can be enabled or disabled dynamically
 	    by enable_hwdep  module param*/
-	snd_asihpi_hpi_new(asihpi, 0, NULL);
+	snd_asihpi_hpi_new(asihpi, 0);
 
 	strcpy(card->driver, "ASIHPI");
 
-- 
1.8.0
