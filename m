From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 24/48] ALSA: via82xx_modem: Use standard printk
	helpers
Date: Wed, 26 Feb 2014 16:53:26 +0100
Message-ID: <1393430030-26704-25-git-send-email-tiwai@suse.de>
References: <1393430030-26704-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F8292657C4
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 16:53:54 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id C7D1375037
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 15:53:53 +0000 (UTC)
In-Reply-To: <1393430030-26704-1-git-send-email-tiwai@suse.de>
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

Convert with dev_err() and co from snd_printk(), etc.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/via82xx_modem.c | 45 +++++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/sound/pci/via82xx_modem.c b/sound/pci/via82xx_modem.c
index 519740154824..46a0526b1d79 100644
--- a/sound/pci/via82xx_modem.c
+++ b/sound/pci/via82xx_modem.c
@@ -312,7 +312,7 @@ static int build_via_table(struct viadev *dev, struct snd_pcm_substream *substre
 			unsigned int addr;
 
 			if (idx >= VIA_TABLE_SIZE) {
-				snd_printk(KERN_ERR "via82xx: too much table size!\n");
+				dev_err(&pci->dev, "too much table size!\n");
 				return -EINVAL;
 			}
 			addr = snd_pcm_sgbuf_get_addr(substream, ofs);
@@ -329,8 +329,9 @@ static int build_via_table(struct viadev *dev, struct snd_pcm_substream *substre
 			} else
 				flag = 0; /* period continues to the next */
 			/*
-			printk(KERN_DEBUG "via: tbl %d: at %d  size %d "
-			       "(rest %d)\n", idx, ofs, r, rest);
+			dev_dbg(&pci->dev,
+				"tbl %d: at %d  size %d (rest %d)\n",
+				idx, ofs, r, rest);
 			*/
 			((u32 *)dev->table.area)[(idx<<1) + 1] = cpu_to_le32(r | flag);
 			dev->idx_table[idx].offset = ofs;
@@ -382,7 +383,7 @@ static int snd_via82xx_codec_ready(struct via82xx_modem *chip, int secondary)
 		if (!((val = snd_via82xx_codec_xread(chip)) & VIA_REG_AC97_BUSY))
 			return val & 0xffff;
 	}
-	snd_printk(KERN_ERR "codec_ready: codec %i is not ready [0x%x]\n",
+	dev_err(chip->card->dev, "codec_ready: codec %i is not ready [0x%x]\n",
 		   secondary, snd_via82xx_codec_xread(chip));
 	return -EIO;
 }
@@ -443,7 +444,8 @@ static unsigned short snd_via82xx_codec_read(struct snd_ac97 *ac97, unsigned sho
 	xval |= (reg & 0x7f) << VIA_REG_AC97_CMD_SHIFT;
       	while (1) {
       		if (again++ > 3) {
-			snd_printk(KERN_ERR "codec_read: codec %i is not valid [0x%x]\n",
+			dev_err(chip->card->dev,
+				"codec_read: codec %i is not valid [0x%x]\n",
 				   ac97->num, snd_via82xx_codec_xread(chip));
 		      	return 0xffff;
 		}
@@ -560,7 +562,9 @@ static int snd_via82xx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	((pos) < viadev->lastpos && ((pos) >= viadev->bufsize2 ||\
 				     viadev->lastpos < viadev->bufsize2))
 
-static inline unsigned int calc_linear_pos(struct viadev *viadev, unsigned int idx,
+static inline unsigned int calc_linear_pos(struct via82xx_modem *chip,
+					   struct viadev *viadev,
+					   unsigned int idx,
 					   unsigned int count)
 {
 	unsigned int size, res;
@@ -570,20 +574,21 @@ static inline unsigned int calc_linear_pos(struct viadev *viadev, unsigned int i
 
 	/* check the validity of the calculated position */
 	if (size < count) {
-		snd_printd(KERN_ERR "invalid via82xx_cur_ptr (size = %d, count = %d)\n",
+		dev_err(chip->card->dev,
+			"invalid via82xx_cur_ptr (size = %d, count = %d)\n",
 			   (int)size, (int)count);
 		res = viadev->lastpos;
 	} else if (check_invalid_pos(viadev, res)) {
 #ifdef POINTER_DEBUG
-		printk(KERN_DEBUG "fail: idx = %i/%i, lastpos = 0x%x, "
-		       "bufsize2 = 0x%x, offsize = 0x%x, size = 0x%x, "
-		       "count = 0x%x\n", idx, viadev->tbl_entries, viadev->lastpos,
+		dev_dbg(chip->card->dev,
+			"fail: idx = %i/%i, lastpos = 0x%x, bufsize2 = 0x%x, offsize = 0x%x, size = 0x%x, count = 0x%x\n",
+			idx, viadev->tbl_entries, viadev->lastpos,
 		       viadev->bufsize2, viadev->idx_table[idx].offset,
 		       viadev->idx_table[idx].size, count);
 #endif
 		if (count && size < count) {
-			snd_printd(KERN_ERR "invalid via82xx_cur_ptr, "
-				   "using last valid pointer\n");
+			dev_dbg(chip->card->dev,
+				"invalid via82xx_cur_ptr, using last valid pointer\n");
 			res = viadev->lastpos;
 		} else {
 			if (! count)
@@ -595,8 +600,8 @@ static inline unsigned int calc_linear_pos(struct viadev *viadev, unsigned int i
 				 */
 				res = viadev->idx_table[idx].offset + size;
 			if (check_invalid_pos(viadev, res)) {
-				snd_printd(KERN_ERR "invalid via82xx_cur_ptr (2), "
-					   "using last valid pointer\n");
+				dev_dbg(chip->card->dev,
+					"invalid via82xx_cur_ptr (2), using last valid pointer\n");
 				res = viadev->lastpos;
 			}
 		}
@@ -632,7 +637,7 @@ static snd_pcm_uframes_t snd_via686_pcm_pointer(struct snd_pcm_substream *substr
 	else /* CURR_PTR holds the address + 8 */
 		idx = ((ptr - (unsigned int)viadev->table.addr) / 8 - 1) %
 			viadev->tbl_entries;
-	res = calc_linear_pos(viadev, idx, count);
+	res = calc_linear_pos(chip, viadev, idx, count);
 	spin_unlock(&chip->reg_lock);
 
 	return bytes_to_frames(substream->runtime, res);
@@ -991,7 +996,8 @@ static int snd_via82xx_chip_init(struct via82xx_modem *chip)
 	} while (time_before(jiffies, end_time));
 
 	if ((val = snd_via82xx_codec_xread(chip)) & VIA_REG_AC97_BUSY)
-		snd_printk(KERN_ERR "AC'97 codec is not ready [0x%x]\n", val);
+		dev_err(chip->card->dev,
+			"AC'97 codec is not ready [0x%x]\n", val);
 
 	snd_via82xx_codec_xwrite(chip, VIA_REG_AC97_READ |
 				 VIA_REG_AC97_SECONDARY_VALID |
@@ -1054,8 +1060,7 @@ static int snd_via82xx_resume(struct device *dev)
 	pci_set_power_state(pci, PCI_D0);
 	pci_restore_state(pci);
 	if (pci_enable_device(pci) < 0) {
-		printk(KERN_ERR "via82xx-modem: pci_enable_device failed, "
-		       "disabling device\n");
+		dev_err(dev, "pci_enable_device failed, disabling device\n");
 		snd_card_disconnect(card);
 		return -EIO;
 	}
@@ -1137,7 +1142,7 @@ static int snd_via82xx_create(struct snd_card *card,
 	chip->port = pci_resource_start(pci, 0);
 	if (request_irq(pci->irq, snd_via82xx_interrupt, IRQF_SHARED,
 			KBUILD_MODNAME, chip)) {
-		snd_printk(KERN_ERR "unable to grab IRQ %d\n", pci->irq);
+		dev_err(card->dev, "unable to grab IRQ %d\n", pci->irq);
 		snd_via82xx_free(chip);
 		return -EBUSY;
 	}
@@ -1186,7 +1191,7 @@ static int snd_via82xx_probe(struct pci_dev *pci,
 		sprintf(card->shortname, "VIA 82XX modem");
 		break;
 	default:
-		snd_printk(KERN_ERR "invalid card type %d\n", card_type);
+		dev_err(card->dev, "invalid card type %d\n", card_type);
 		err = -EINVAL;
 		goto __error;
 	}
-- 
1.9.0
