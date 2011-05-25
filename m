From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 1/5] ALSA: usb-audio: move assignment of
	chip->ctrl_intf
Date: Wed, 25 May 2011 09:08:59 +0200
Message-ID: <1306307343-3247-2-git-send-email-zonque@gmail.com>
References: <1306307343-3247-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (unknown [212.112.241.193])
	by alsa0.perex.cz (Postfix) with ESMTP id 0BB90103820
	for <alsa-devel@alsa-project.org>;
	Wed, 25 May 2011 09:09:33 +0200 (CEST)
In-Reply-To: <1306307343-3247-1-git-send-email-zonque@gmail.com>
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
Cc: tiwai@suse.de, gdiffey@gmail.com, clemens@ladisch.de, linuxaudio@showlabor.de, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

This is needed for upcoming changes to the quirks mechanism.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/usb/card.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index a90662a..84a5ce7 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -492,14 +492,6 @@ static void *snd_usb_audio_probe(struct usb_device *dev,
 		}
 	}
 
-	chip->txfr_quirk = 0;
-	err = 1; /* continue */
-	if (quirk && quirk->ifnum != QUIRK_NO_INTERFACE) {
-		/* need some special handlings */
-		if ((err = snd_usb_create_quirk(chip, intf, &usb_audio_driver, quirk)) < 0)
-			goto __error;
-	}
-
 	/*
 	 * For devices with more than one control interface, we assume the
 	 * first contains the audio controls. We might need a more specific
@@ -508,6 +500,14 @@ static void *snd_usb_audio_probe(struct usb_device *dev,
 	if (!chip->ctrl_intf)
 		chip->ctrl_intf = alts;
 
+	chip->txfr_quirk = 0;
+	err = 1; /* continue */
+	if (quirk && quirk->ifnum != QUIRK_NO_INTERFACE) {
+		/* need some special handlings */
+		if ((err = snd_usb_create_quirk(chip, intf, &usb_audio_driver, quirk)) < 0)
+			goto __error;
+	}
+
 	if (err > 0) {
 		/* create normal USB audio interfaces */
 		if (snd_usb_create_streams(chip, ifnum) < 0 ||
-- 
1.7.5.1
