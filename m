From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH 4/5] sound: fix uninitialized variable warning
Date: Tue,  3 Aug 2010 15:20:25 -0400
Message-ID: <1280863226-6824-4-git-send-email-wfp5p@virginia.edu>
References: <1280863226-6824-1-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from viridian.itc.virginia.edu (viridian.itc.Virginia.EDU
	[128.143.12.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 277F6243EB
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Aug 2010 21:20:28 +0200 (CEST)
In-Reply-To: <1280863226-6824-1-git-send-email-wfp5p@virginia.edu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: trivial@kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

quiet the warning:
sound/pci/via82xx.c:2498: warning: 'chip' may be used uninitialized in
this function

chip is set by snd_via82xx_create()

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
---
 sound/pci/via82xx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/pci/via82xx.c b/sound/pci/via82xx.c
index 8c5f8b5..f7d02fc 100644
--- a/sound/pci/via82xx.c
+++ b/sound/pci/via82xx.c
@@ -2500,7 +2500,7 @@ static int __devinit snd_via82xx_probe(struct pci_dev *pci,
 				       const struct pci_device_id *pci_id)
 {
 	struct snd_card *card;
-	struct via82xx *chip;
+	struct via82xx *uninitialized_var(chip);
 	int chip_type = 0, card_type;
 	unsigned int i;
 	int err;
-- 
1.7.2
