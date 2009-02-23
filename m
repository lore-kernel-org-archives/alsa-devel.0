From: Luke Yelavich <themuso@ubuntu.com>
Subject: [PATCH] ALSA: hda - add another MacBook Pro 3,1 SSID
Date: Mon, 23 Feb 2009 13:00:33 +1100
Message-ID: <1235354433-26943-1-git-send-email-themuso@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ipmail01.adl6.internode.on.net (ipmail01.adl6.internode.on.net
	[203.16.214.146])
	by alsa0.perex.cz (Postfix) with ESMTP id E7C911037F2
	for <alsa-devel@alsa-project.org>; Mon, 23 Feb 2009 03:00:41 +0100 (CET)
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
Cc: Luke Yelavich <themuso@ubuntu.com>
List-Id: alsa-devel@alsa-project.org

Reference: Ubuntu bug #33245
    https://bugs.launchpad.net/bugs/332456

Signed-off-by: Luke Yelavich <themuso@ubuntu.com>
---
 sound/pci/hda/patch_realtek.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 169b383..02ef827 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7094,6 +7094,7 @@ static int patch_alc882(struct hda_codec *codec)
 		case 0x106b3e00: /* iMac 24 Aluminium */
 			board_config = ALC885_IMAC24;
 			break;
+		case 0x106b00a0: /* MacBookPro3,1 - Another revision */
 		case 0x106b00a1: /* Macbook (might be wrong - PCI SSID?) */
 		case 0x106b00a4: /* MacbookPro4,1 */
 		case 0x106b2c00: /* Macbook Pro rev3 */
-- 
1.6.0.4
