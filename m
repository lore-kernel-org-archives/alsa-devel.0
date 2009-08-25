From: Jiri Slaby <jirislaby@gmail.com>
Subject: [PATCH 1/4] SOUND: atiixp, use uninitialized_var(chip)
Date: Tue, 25 Aug 2009 22:59:34 +0200
Message-ID: <1251233977-5819-1-git-send-email-jirislaby@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server1.wserver.cz (server1.wserver.cz [82.113.45.157])
	by alsa0.perex.cz (Postfix) with ESMTP id 519FC24443
	for <alsa-devel@alsa-project.org>;
	Tue, 25 Aug 2009 22:59:39 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: Jiri Slaby <jirislaby@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

To avoid wrong compiler warnings, use unitialized_var(chip) in
snd_atiixp_probe's from atiixp and atiixp_modem drivers.

'chip' is unused when unset due to retval being nonzero.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>
---
 sound/pci/atiixp.c       |    2 +-
 sound/pci/atiixp_modem.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/atiixp.c b/sound/pci/atiixp.c
index d6752df..436ffea 100644
--- a/sound/pci/atiixp.c
+++ b/sound/pci/atiixp.c
@@ -1648,7 +1648,7 @@ static int __devinit snd_atiixp_probe(struct pci_dev *pci,
 				     const struct pci_device_id *pci_id)
 {
 	struct snd_card *card;
-	struct atiixp *chip;
+	struct atiixp *uninitialized_var(chip);
 	int err;
 
 	err = snd_card_create(index, id, THIS_MODULE, 0, &card);
diff --git a/sound/pci/atiixp_modem.c b/sound/pci/atiixp_modem.c
index e7e147b..b6191f2 100644
--- a/sound/pci/atiixp_modem.c
+++ b/sound/pci/atiixp_modem.c
@@ -1285,7 +1285,7 @@ static int __devinit snd_atiixp_probe(struct pci_dev *pci,
 				      const struct pci_device_id *pci_id)
 {
 	struct snd_card *card;
-	struct atiixp_modem *chip;
+	struct atiixp_modem *uninitialized_var(chip);
 	int err;
 
 	err = snd_card_create(index, id, THIS_MODULE, 0, &card);
-- 
1.6.3.3
