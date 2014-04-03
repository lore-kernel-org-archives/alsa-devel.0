From: Ondrej Zary <linux@rainbow-software.org>
Subject: [PATCH 2/2] snd-ice1712: Save/restore routing and rate
	registers
Date: Thu,  3 Apr 2014 23:09:38 +0200
Message-ID: <1396559378-23980-2-git-send-email-linux@rainbow-software.org>
References: <1396559378-23980-1-git-send-email-linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-1.atlantis.sk (mail-1.atlantis.sk [80.94.52.57])
 by alsa0.perex.cz (Postfix) with ESMTP id A8FCA2656F1
 for <alsa-devel@alsa-project.org>; Thu,  3 Apr 2014 23:09:53 +0200 (CEST)
In-Reply-To: <1396559378-23980-1-git-send-email-linux@rainbow-software.org>
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
List-Id: alsa-devel@alsa-project.org

Save/restore routing and rate registers during suspend/resume.
This fixes S/PDIF input being disabled after resume.
Tested with Audiophile 24/96.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
---
 sound/pci/ice1712/ice1712.c |   32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/sound/pci/ice1712/ice1712.c b/sound/pci/ice1712/ice1712.c
index dbb0f96..fcd46d9 100644
--- a/sound/pci/ice1712/ice1712.c
+++ b/sound/pci/ice1712/ice1712.c
@@ -1047,6 +1047,8 @@ __out:
 	old = inb(ICEMT(ice, RATE));
 	if (!force && old == val)
 		goto __out;
+
+	ice->cur_rate = rate;
 	outb(val, ICEMT(ice, RATE));
 	spin_unlock_irqrestore(&ice->reg_lock, flags);
 
@@ -2826,6 +2828,12 @@ static int snd_ice1712_suspend(struct device *dev)
 	snd_pcm_suspend_all(ice->pcm_ds);
 	snd_ac97_suspend(ice->ac97);
 
+	spin_lock_irq(&ice->reg_lock);
+	ice->pm_saved_is_spdif_master = is_spdif_master(ice);
+	ice->pm_saved_spdif_ctrl = inw(ICEMT(ice, ROUTE_SPDOUT));
+	ice->pm_saved_route = inw(ICEMT(ice, ROUTE_PSDOUT03));
+	spin_unlock_irq(&ice->reg_lock);
+
 	if (ice->pm_suspend)
 		ice->pm_suspend(ice);
 
@@ -2840,6 +2848,7 @@ static int snd_ice1712_resume(struct device *dev)
 	struct pci_dev *pci = to_pci_dev(dev);
 	struct snd_card *card = dev_get_drvdata(dev);
 	struct snd_ice1712 *ice = card->private_data;
+	int rate;
 
 	if (!ice->pm_suspend_enabled)
 		return 0;
@@ -2854,14 +2863,37 @@ static int snd_ice1712_resume(struct device *dev)
 
 	pci_set_master(pci);
 
+	if (ice->cur_rate)
+		rate = ice->cur_rate;
+	else
+		rate = PRO_RATE_DEFAULT;
+
 	if (snd_ice1712_chip_init(ice) < 0) {
 		snd_card_disconnect(card);
 		return -EIO;
 	}
 
+	ice->cur_rate = rate;
+
 	if (ice->pm_resume)
 		ice->pm_resume(ice);
 
+	if (ice->pm_saved_is_spdif_master) {
+		/* switching to external clock via SPDIF */
+		spin_lock_irq(&ice->reg_lock);
+		outb(inb(ICEMT(ice, RATE)) | ICE1712_SPDIF_MASTER,
+			ICEMT(ice, RATE));
+		spin_unlock_irq(&ice->reg_lock);
+		snd_ice1712_set_input_clock_source(ice, 1);
+	} else {
+		/* internal on-card clock */
+		snd_ice1712_set_pro_rate(ice, rate, 1);
+		snd_ice1712_set_input_clock_source(ice, 0);
+	}
+
+	outw(ice->pm_saved_spdif_ctrl, ICEMT(ice, ROUTE_SPDOUT));
+	outw(ice->pm_saved_route, ICEMT(ice, ROUTE_PSDOUT03));
+
 	if (ice->ac97)
 		snd_ac97_resume(ice->ac97);
 
-- 
Ondrej Zary
