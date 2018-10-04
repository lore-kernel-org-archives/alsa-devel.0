From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/5] ALSA: caiaq: Add fall-through annotation
Date: Thu,  4 Oct 2018 20:12:31 +0200
Message-ID: <20181004181234.21152-3-tiwai@suse.de>
References: <20181004181234.21152-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 84FCC267737
 for <alsa-devel@alsa-project.org>; Thu,  4 Oct 2018 20:12:36 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 05D2DB041
 for <alsa-devel@alsa-project.org>; Thu,  4 Oct 2018 18:12:36 +0000 (UTC)
In-Reply-To: <20181004181234.21152-1-tiwai@suse.de>
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

As a preparatory patch for the upcoming -Wimplicit-fallthrough
compiler checks, add the "fall through" annotation in caiaq driver.
Note that this seems necessary to be put exactly before the next
label, so it's outside the ifdef block.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/caiaq/device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/caiaq/device.c b/sound/usb/caiaq/device.c
index d55ca48de3ea..f4a72e39ffa9 100644
--- a/sound/usb/caiaq/device.c
+++ b/sound/usb/caiaq/device.c
@@ -200,6 +200,7 @@ static void usb_ep1_command_reply_dispatch (struct urb* urb)
 			break;
 		}
 #ifdef CONFIG_SND_USB_CAIAQ_INPUT
+		/* fall through */
 	case EP1_CMD_READ_ERP:
 	case EP1_CMD_READ_ANALOG:
 		snd_usb_caiaq_input_dispatch(cdev, buf, urb->actual_length);
-- 
2.18.0
