From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ALSA: usb-audio: remove redundant check on err
Date: Mon,  4 Jun 2018 12:49:19 +0100
Message-ID: <20180604114919.2199-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id DAA472678B5
 for <alsa-devel@alsa-project.org>; Mon,  4 Jun 2018 13:49:24 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

The check on err is redundant as both the true and false paths
end up on a break statement. Remove the redundant check.

Detected by CoverityScan, CID#1268773 ("Identical code for different
branches")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/usb/mixer_quirks.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 4149543f613e..e82a72fea9a1 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -1849,8 +1849,6 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 	/* EMU0204 */
 	case USB_ID(0x041e, 0x3f19):
 		err = snd_emu0204_controls_create(mixer);
-		if (err < 0)
-			break;
 		break;
 
 	case USB_ID(0x0763, 0x2030): /* M-Audio Fast Track C400 */
-- 
2.17.0
