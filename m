From: Kazuki Oikawa <k@oikw.org>
Subject: [PATCH] ALSA: usb-audio: Fix quirks code is not called
Date: Mon, 18 Jul 2016 01:16:15 +0900
Message-ID: <20160717161615.2399-1-k@oikw.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from andante.oikw.org (oikw.org [49.212.164.31])
 by alsa0.perex.cz (Postfix) with ESMTP id A4EF126533F
 for <alsa-devel@alsa-project.org>; Sun, 17 Jul 2016 18:16:30 +0200 (CEST)
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
Cc: Kazuki Oikawa <k@oikw.org>
List-Id: alsa-devel@alsa-project.org

snd_usb_{set_interface,ctl_msg}_quirk checks chip->usb_id to need
calling a quirks code. But existed code path that not calling
dev_set_drvdata in usb_audio_probe.

Signed-off-by: Kazuki Oikawa <k@oikw.org>
Fixes: 79289e24194a ("ALSA: usb-audio: Refer to chip->usb_id for quirks and MIDI creation")
---
 sound/usb/card.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 3fc63583a537..2d493501b7f6 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -552,7 +552,6 @@ static int usb_audio_probe(struct usb_interface *intf,
 				goto __error;
 			}
 			chip = usb_chip[i];
-			dev_set_drvdata(&dev->dev, chip);
 			atomic_inc(&chip->active); /* avoid autopm */
 			break;
 		}
@@ -578,6 +577,7 @@ static int usb_audio_probe(struct usb_interface *intf,
 			goto __error;
 		}
 	}
+	dev_set_drvdata(&dev->dev, chip);
 
 	/*
 	 * For devices with more than one control interface, we assume the
-- 
2.9.2
