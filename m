From: Luke Yelavich <themuso@ubuntu.com>
Subject: [PATCH] ALSA: hda - add another MacBook Pro 4,
	1 subsystem ID
Date: Wed, 28 Jan 2009 15:58:38 +1100
Message-ID: <1233118718-19082-1-git-send-email-themuso@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ipmail01.adl6.internode.on.net (ipmail01.adl6.internode.on.net
	[203.16.214.146])
	by alsa0.perex.cz (Postfix) with ESMTP id E85301037F8
	for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2009 05:59:04 +0100 (CET)
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

Add another MacBook Pro 4,1 SSID (106b:3800). It seems that latter revisions,
(at least mine), have different IDs to earlier revisions.

Signed-off-by: Luke Yelavich <themuso@ubuntu.com>
---
 sound/pci/hda/patch_realtek.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 863ab95..aef543a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7036,6 +7036,7 @@ static int patch_alc882(struct hda_codec *codec)
 		case 0x106b00a4: /* MacbookPro4,1 */
 		case 0x106b2c00: /* Macbook Pro rev3 */
 		case 0x106b3600: /* Macbook 3.1 */
+		case 0x106b3800: /* MacbookPro4,1 - latter revision */
 			board_config = ALC885_MBP3;
 			break;
 		default:
-- 
1.5.6.3
