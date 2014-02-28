From: Dylan Reid <dgreid@chromium.org>
Subject: [RFC 14/19] ALSA: hda - Add jackpoll_ms to struct azx
Date: Thu, 27 Feb 2014 22:35:57 -0800
Message-ID: <1393569362-27285-15-git-send-email-dgreid@chromium.org>
References: <1393569362-27285-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f74.google.com (mail-qa0-f74.google.com
 [209.85.216.74])
 by alsa0.perex.cz (Postfix) with ESMTP id 792F826509A
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 07:37:13 +0100 (CET)
Received: by mail-qa0-f74.google.com with SMTP id cm18so34193qab.3
 for <alsa-devel@alsa-project.org>; Thu, 27 Feb 2014 22:37:12 -0800 (PST)
In-Reply-To: <1393569362-27285-1-git-send-email-dgreid@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Dylan Reid <dgreid@chromium.org>, swarren@wwwdotorg.org
List-Id: alsa-devel@alsa-project.org

Keeping a pointer to the jackpoll_ms array in the chip will allow
azx_codec_create to be shared between hda_intel and hda_platform
drivers.  Also modify get_jackpoll_ms to make the jackpoll_ms member
optional, this way a platform driver can leave it out if it's not
needed.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/pci/hda/hda_intel.c | 8 +++++++-
 sound/pci/hda/hda_priv.h  | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index da5c7d2..4fa4da1 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -435,8 +435,13 @@ static void azx_bus_reset(struct hda_bus *bus)
 
 static int get_jackpoll_interval(struct azx *chip)
 {
-	int i = jackpoll_ms[chip->dev_index];
+	int i;
 	unsigned int j;
+
+	if (!chip->jackpoll_ms)
+		return 0;
+
+	i = chip->jackpoll_ms[chip->dev_index];
 	if (i == 0)
 		return 0;
 	if (i < 50 || i > 60000)
@@ -1305,6 +1310,7 @@ static int azx_create(struct snd_card *card, struct pci_dev *pci,
 	check_msi(chip);
 	chip->dev_index = dev;
 	chip->disable_msi_reset_irq = disable_msi_reset_irq;
+	chip->jackpoll_ms = jackpoll_ms;
 	INIT_WORK(&chip->irq_pending_work, azx_irq_pending_work);
 	INIT_LIST_HEAD(&chip->pcm_list);
 	INIT_LIST_HEAD(&chip->list);
diff --git a/sound/pci/hda/hda_priv.h b/sound/pci/hda/hda_priv.h
index f1fa6f4..6d32367 100644
--- a/sound/pci/hda/hda_priv.h
+++ b/sound/pci/hda/hda_priv.h
@@ -316,6 +316,7 @@ struct azx {
 	int capture_streams;
 	int capture_index_offset;
 	int num_streams;
+	const int *jackpoll_ms; /* per-card jack poll interval */
 
 	/* Register interaction. */
 	const struct azx_reg_ops *reg_ops;
-- 
1.8.1.3.605.g02339dd
