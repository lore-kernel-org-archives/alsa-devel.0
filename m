From: linux@audioscience.com
Subject: [PATCH 17/28] Add snd_card_set_dev to init.
Date: Thu, 10 Feb 2011 17:26:10 +1300
Message-ID: <1297311981-30448-18-git-send-email-linux@audioscience.com>
References: <1297311981-30448-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <1297311981-30448-1-git-send-email-linux@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: tiwai@suse.de, Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eblennerhassett@audioscience.com>

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 pci/asihpi/asihpi.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/pci/asihpi/asihpi.c b/pci/asihpi/asihpi.c
index e456c2e..b2c0c8a 100644
--- a/pci/asihpi/asihpi.c
+++ b/pci/asihpi/asihpi.c
@@ -2847,9 +2847,11 @@ static int __devinit snd_asihpi_probe(struct pci_dev *pci_dev,
 			hpi_card->index, card->number);
 	}
 
+	snd_card_set_dev(card, &pci_dev->dev);
+
 	asihpi = (struct snd_card_asihpi *) card->private_data;
 	asihpi->card = card;
-	asihpi->pci = hpi_card->pci;
+	asihpi->pci = pci_dev;
 	asihpi->adapter_index = hpi_card->index;
 	hpi_handle_error(hpi_adapter_get_info(
 				 asihpi->adapter_index,
-- 
1.7.0.4
