From: Tarek Soliman <tarek@bashasoliman.com>
Subject: [PATCH] ALSA: usb-audio: define another USB ID for a
 buggy USB MIDI cable
Date: Mon, 4 Apr 2011 09:23:53 -0500
Message-ID: <20110404142353.GA3821@zeus.olympus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.123]) by alsa0.perex.cz (Postfix) with ESMTP id D2E8210380E
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Apr 2011 16:23:55 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

There are many USB MIDI cables out there that have buggy
firmware that reports it can do more than 4 bytes in a
packet when they can only properly handle 4

This patch adds the ID of yet another one of those cables

Signed-off-by: Tarek Soliman <tarek@bashasoliman.com>
---
 sound/usb/midi.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index b4b39c0..f928910 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -1301,6 +1301,7 @@ static int snd_usbmidi_out_endpoint_create(struct snd_usb_midi* umidi,
 	case USB_ID(0x15ca, 0x0101): /* Textech USB Midi Cable */
 	case USB_ID(0x15ca, 0x1806): /* Textech USB Midi Cable */
 	case USB_ID(0x1a86, 0x752d): /* QinHeng CH345 "USB2.0-MIDI" */
+	case USB_ID(0xfc08, 0x0101): /* Unknown vendor Cable */
 		ep->max_transfer = 4;
 		break;
 		/*
-- 
1.7.4.1

As instructed, I updated the insertion point of the new entry such
that the entries are sorted.
-- 
Tarek
