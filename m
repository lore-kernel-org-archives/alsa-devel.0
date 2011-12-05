From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH] ALSA: snd-usb: added VOX ToneLab ST midi
	handling
Date: Mon,  5 Dec 2011 20:27:46 +0100
Message-ID: <1323113266-23322-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
	by alsa0.perex.cz (Postfix) with ESMTP id 8CA012417B
	for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2011 20:28:11 +0100 (CET)
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
Cc: sergiusz.urbaniak@googlemail.com, Sergiusz Urbaniak <sergiusz.urbaniak@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Sergiusz Urbaniak <sergiusz.urbaniak@gmail.com>

Signed-off-by: Sergiusz Urbaniak <sergiusz.urbaniak@googlemail.com>
---

Sergiusz writes:

Hi,

I posted the message below to the mailing list, but it still is in the
approval queue since I'm not a mailing list member.

In case this gets forgotten or stuck in a spam queue could you please
consider my patch for kernel inclusion? This works really great with
my Tonelab ST! I can even imagine to write a lib/CLI/GTK based app to
control the Tonelab now :-)

Thanks,
Sergiusz Urbaniak

 sound/usb/quirks-table.h |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index b61945f..57c9b94 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -2305,6 +2305,16 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	}
 },
 
+{
+	USB_DEVICE_VENDOR_SPEC(0x0944, 0x0201),
+	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+		.vendor_name = "KORG, Inc.",
+		/* .product_name = "ToneLab ST", */
+		.ifnum = 3,
+		.type = QUIRK_MIDI_STANDARD_INTERFACE,
+	}
+},
+
 /* AKAI devices */
 {
 	USB_DEVICE(0x09e8, 0x0062),
-- 
1.7.7.3
