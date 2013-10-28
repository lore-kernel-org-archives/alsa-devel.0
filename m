From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/6] ALSA: 6fire: Fix probe of multiple cards
Date: Mon, 28 Oct 2013 14:14:05 +0100
Message-ID: <1382966050-12752-2-git-send-email-tiwai@suse.de>
References: <1382966050-12752-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4FB5F261603
 for <alsa-devel@alsa-project.org>; Mon, 28 Oct 2013 14:11:34 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id A58C3A5967
 for <alsa-devel@alsa-project.org>; Mon, 28 Oct 2013 14:11:31 +0100 (CET)
In-Reply-To: <1382966050-12752-1-git-send-email-tiwai@suse.de>
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

The probe code of snd-usb-6fire driver overrides the devices[] pointer
wrongly without checking whether it's already occupied or not.  This
would screw up the device disconnection later.

Spotted by coverity CID 141423.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/6fire/chip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/6fire/chip.c b/sound/usb/6fire/chip.c
index c39c779..66edc4a 100644
--- a/sound/usb/6fire/chip.c
+++ b/sound/usb/6fire/chip.c
@@ -101,7 +101,7 @@ static int usb6fire_chip_probe(struct usb_interface *intf,
 			usb_set_intfdata(intf, chips[i]);
 			mutex_unlock(&register_mutex);
 			return 0;
-		} else if (regidx < 0)
+		} else if (!devices[i] && regidx < 0)
 			regidx = i;
 	}
 	if (regidx < 0) {
-- 
1.8.4.1
