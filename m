From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: [PATCH] hda: appletv support
Date: Sat, 27 Sep 2008 09:13:45 +0200
Message-ID: <1222499625-7411-1-git-send-email-jacmet@sunsite.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.175])
	by alsa0.perex.cz (Postfix) with ESMTP id 0D99124521
	for <alsa-devel@alsa-project.org>;
	Sat, 27 Sep 2008 09:13:46 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id 30so51212ugs.24
	for <alsa-devel@alsa-project.org>; Sat, 27 Sep 2008 00:13:45 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Peter Korsgaard <jacmet@sunsite.dk>
List-Id: alsa-devel@alsa-project.org

The AppleTV needs the same handling as the 24" iMac.

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
---
 sound/pci/hda/patch_realtek.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index c2ff85d..b0b665e 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6656,6 +6656,7 @@ static int patch_alc882(struct hda_codec *codec)
 			board_config = ALC885_MACPRO;
 			break;
 		case 0x106b1000: /* iMac 24 */
+		case 0x106b2800: /* AppleTV */
 			board_config = ALC885_IMAC24;
 			break;
 		case 0x106b00a1: /* Macbook (might be wrong - PCI SSID?) */
-- 
1.5.6.5
