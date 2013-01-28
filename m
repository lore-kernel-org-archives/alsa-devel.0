From: Antonio Ospite <ospite@studenti.unina.it>
Subject: [PATCH 5/6] sound/usb/card.c: cosmetics,
	remove a leading space
Date: Mon, 28 Jan 2013 23:42:31 +0100
Message-ID: <1359412952-1680-6-git-send-email-ospite@studenti.unina.it>
References: <1359412952-1680-1-git-send-email-ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp207.alice.it (smtp207.alice.it [82.57.200.103])
 by alsa0.perex.cz (Postfix) with ESMTP id 2BDE5265B97
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2013 23:44:06 +0100 (CET)
In-Reply-To: <1359412952-1680-1-git-send-email-ospite@studenti.unina.it>
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
Cc: Takashi Iwai <tiwai@suse.de>, Michael Trimarchi <michael@amarulasolutions.com>, Antonio Ospite <ao2@amarulasolutions.com>
List-Id: alsa-devel@alsa-project.org

From: Antonio Ospite <ao2@amarulasolutions.com>

Signed-off-by: Antonio Ospite <ao2@amarulasolutions.com>
---
 sound/usb/card.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index ccf95cf..803953a 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -646,7 +646,7 @@ static int usb_audio_suspend(struct usb_interface *intf, pm_message_t message)
 				as->substream[0].need_setup_ep =
 					as->substream[1].need_setup_ep = true;
 			}
- 		}
+		}
 	} else {
 		/*
 		 * otherwise we keep the rest of the system in the dark
-- 
1.7.10.4
