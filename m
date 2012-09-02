From: Marko Friedemann <mfr@bmx-chemnitz.de>
Subject: [PATCH] USB: Support for (original) Xbox Communicator
Date: Sun, 2 Sep 2012 14:59:27 +0200
Message-ID: <20120902125927.GF31713@bmx-chemnitz.de>
References: <20120901144541.GE31713@bmx-chemnitz.de>
 <s5hehmk4ud1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bmx-chemnitz.de (bmx-chemnitz.de [77.37.21.155])
 by alsa0.perex.cz (Postfix) with ESMTP id D2DF4264EF7
 for <alsa-devel@alsa-project.org>; Sun,  2 Sep 2012 14:59:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hehmk4ud1.wl%tiwai@suse.de>
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

From: Marko Friedemann <mfr@bmx-chemnitz.de>

Added support for Xbox Communicator to USB quirks.

Signed-off-by: Marko Friedemann <mfr@bmx-chemnitz.de>

---
As requested, resubmit according to documentation.

Regards,
Marko


--- alsa-driver-1.0.25/alsa-kernel/usb/quirks-table.h	2012-01-25 08:56:49.0=
00000000 +0100
+++ alsa-driver/alsa-kernel/usb/quirks-table.h	2012-09-01 16:30:09.00000000=
0 +0200
@@ -2758,4 +2758,59 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	}
 },
 =

+{
+	/*
+	 * Microsoft XboxLive Headset/Xbox Communicator
+	 */
+	USB_DEVICE(0x045e, 0x0283),
+	.bInterfaceClass =3D USB_CLASS_PER_INTERFACE,
+	.driver_info =3D (unsigned long) &(const struct snd_usb_audio_quirk) {
+		.vendor_name =3D "Microsoft",
+		.product_name =3D "XboxLive Headset/Xbox Communicator",
+		.ifnum =3D QUIRK_ANY_INTERFACE,
+		.type =3D QUIRK_COMPOSITE,
+		.data =3D &(const struct snd_usb_audio_quirk[]) {
+			{
+				/* playback */
+				.ifnum =3D 0,
+				.type =3D QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data =3D &(const struct audioformat) {
+					.formats =3D SNDRV_PCM_FMTBIT_S16_LE,
+					.channels =3D 1,
+					.iface =3D 0,
+					.altsetting =3D 0,
+					.altset_idx =3D 0,
+					.attributes =3D 0,
+					.endpoint =3D 0x04,
+					.ep_attr =3D 0x05,
+					.rates =3D SNDRV_PCM_RATE_CONTINUOUS,
+					.rate_min =3D 22050,
+					.rate_max =3D 22050
+				}
+			},
+			{
+				/* capture */
+				.ifnum =3D 1,
+				.type =3D QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data =3D &(const struct audioformat) {
+					.formats =3D SNDRV_PCM_FMTBIT_S16_LE,
+					.channels =3D 1,
+					.iface =3D 1,
+					.altsetting =3D 0,
+					.altset_idx =3D 0,
+					.attributes =3D 0,
+					.endpoint =3D 0x85,
+					.ep_attr =3D 0x05,
+					.rates =3D SNDRV_PCM_RATE_CONTINUOUS,
+					.rate_min =3D 16000,
+					.rate_max =3D 16000
+				}
+			},
+			{
+				.ifnum =3D -1
+			}
+		}
+	}
+},
+
 #undef USB_DEVICE_VENDOR_SPEC

-- =

"Somit werden Zitate zu z=E4hlbaren Einheiten wissenschaftlicher
 Reputation."        -- NeMa-News - Trends in der Wissenschaft
