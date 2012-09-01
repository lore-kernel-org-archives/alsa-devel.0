From: Marko Friedemann <mfr@bmx-chemnitz.de>
Subject: [Patch] Support for (original) Xbox Communicator
Date: Sat, 1 Sep 2012 16:45:41 +0200
Message-ID: <20120901144541.GE31713@bmx-chemnitz.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Q68bSM7Ycu6FN28Q"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bmx-chemnitz.de (bmx-chemnitz.de [77.37.21.155])
 by alsa0.perex.cz (Postfix) with ESMTP id 599542602AE
 for <alsa-devel@alsa-project.org>; Sat,  1 Sep 2012 16:45:41 +0200 (CEST)
Content-Disposition: inline
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


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey guys,

attached is a patch for the USB quirks to support the original Xbox
Communicator (aka XboxLive Headset).
I had actually submitted this some time ago against an earlier version
but wasn't subscribed to the list and it was lost in moderation.

I present it again now, against alsa 1.0.25.

Tested and working under ubuntu 12.04.1 with kernel 3.2.0-29-generic.

Regards,
Marko
--=20
"Somit werden Zitate zu z=E4hlbaren Einheiten wissenschaftlicher
 Reputation."        -- NeMa-News - Trends in der Wissenschaft

--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="xboxlive-headset.patch"

--- quirks-table.h.orig	2012-01-25 08:56:49.000000000 +0100
+++ quirks-table.h	2012-09-01 16:30:09.000000000 +0200
@@ -2758,4 +2758,59 @@
 	}
 },
 
+{
+	/*
+	 * Microsoft XboxLive Headset/Xbox Communicator
+	 */
+	USB_DEVICE(0x045e, 0x0283),
+	.bInterfaceClass = USB_CLASS_PER_INTERFACE,
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+		.vendor_name = "Microsoft",
+		.product_name = "XboxLive Headset/Xbox Communicator",
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_COMPOSITE,
+		.data = &(const struct snd_usb_audio_quirk[]) {
+			{
+				/* playback */
+				.ifnum = 0,
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = &(const struct audioformat) {
+					.formats = SNDRV_PCM_FMTBIT_S16_LE,
+					.channels = 1,
+					.iface = 0,
+					.altsetting = 0,
+					.altset_idx = 0,
+					.attributes = 0,
+					.endpoint = 0x04,
+					.ep_attr = 0x05,
+					.rates = SNDRV_PCM_RATE_CONTINUOUS,
+					.rate_min = 22050,
+					.rate_max = 22050
+				}
+			},
+			{
+				/* capture */
+				.ifnum = 1,
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = &(const struct audioformat) {
+					.formats = SNDRV_PCM_FMTBIT_S16_LE,
+					.channels = 1,
+					.iface = 1,
+					.altsetting = 0,
+					.altset_idx = 0,
+					.attributes = 0,
+					.endpoint = 0x85,
+					.ep_attr = 0x05,
+					.rates = SNDRV_PCM_RATE_CONTINUOUS,
+					.rate_min = 16000,
+					.rate_max = 16000
+				}
+			},
+			{
+				.ifnum = -1
+			}
+		}
+	}
+},
+
 #undef USB_DEVICE_VENDOR_SPEC

--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--Q68bSM7Ycu6FN28Q--
