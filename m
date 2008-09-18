From: David Woodhouse <dwmw2@infradead.org>
Subject: ALSA: hda - Add PCI subsystem ID for MacBookPro4,1
Date: Thu, 18 Sep 2008 13:37:13 -0700
Message-ID: <1221770233.3573.76.camel@macbook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	by alsa0.perex.cz (Postfix) with ESMTP id E28CE24499
	for <alsa-devel@alsa-project.org>;
	Thu, 18 Sep 2008 22:37:16 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This seems to work if I tell it that it's a mbp3. Not sure if there are
actually any differences.

Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 6602516..e9b2cbd 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6557,6 +6557,7 @@ static int patch_alc882(struct hda_codec *codec)
 			board_config = ALC885_IMAC24;
 			break;
 		case 0x106b00a1: /* Macbook (might be wrong - PCI SSID?) */
+		case 0x106b00a4: /* MacbookPro4,1 */
 		case 0x106b2c00: /* Macbook Pro rev3 */
 		case 0x106b3600: /* Macbook 3.1 */
 			board_config = ALC885_MBP3;

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation
