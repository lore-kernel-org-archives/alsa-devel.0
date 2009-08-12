From: Tim Blechmann <tim@klingt.org>
Subject: [PATCH] alsa: hdsp - allow proc reporting with
	disconnected io box
Date: Wed, 12 Aug 2009 13:00:13 +0200
Message-ID: <4A82A0BD.9060700@klingt.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3652562198187085032=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from klingt.org (mail.klingt.org [86.59.21.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 8508C24150
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Aug 2009 13:00:21 +0200 (CEST)
Received: from [192.168.178.3] (localhost [127.0.0.1]) (authenticated bits=0)
	by klingt.org (8.14.3/8.14.3/Debian-9) with ESMTP id n7CB0Hpg010772
	for <alsa-devel@alsa-project.org>; Wed, 12 Aug 2009 13:00:19 +0200
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
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============3652562198187085032==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig247C1F1870B6D84FE0F0F416"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig247C1F1870B6D84FE0F0F416
Content-Type: multipart/mixed;
 boundary="------------060501040203040607080504"

This is a multi-part message in MIME format.
--------------060501040203040607080504
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


the hdsp driver refuses to report any information via the proc
interface, if the io box is not connected. with this patch, the
content of the control and status registers is printed before the
iobox check.

Signed-off-by: Tim Blechmann <tim@klingt.org>
---
 sound/pci/rme9652/hdsp.c |   37 ++++++++++++++++++++-----------------
 1 files changed, 20 insertions(+), 17 deletions(-)

--------------060501040203040607080504
Content-Type: text/x-patch;
 name="0001-alsa-hdsp-allow-proc-reporting-with-disconnected-io-.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename*0="0001-alsa-hdsp-allow-proc-reporting-with-disconnected-io-.pa";
 filename*1="tch"

diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index 3362065..e5b77b8 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -3357,17 +3357,33 @@ snd_hdsp_proc_read(struct snd_info_entry *entry, =
struct snd_info_buffer *buffer)
 	char *clock_source;
 	int x;
=20
+	status =3D hdsp_read(hdsp, HDSP_statusRegister);
+	status2 =3D hdsp_read(hdsp, HDSP_status2Register);
=20
+	snd_iprintf(buffer, "%s (Card #%d)\n", hdsp->card_name,
+		    hdsp->card->number + 1);
+	snd_iprintf(buffer, "Buffers: capture %p playback %p\n",
+		    hdsp->capture_buffer, hdsp->playback_buffer);
+	snd_iprintf(buffer, "IRQ: %d Registers bus: 0x%lx VM: 0x%lx\n",
+		    hdsp->irq, hdsp->port, (unsigned long)hdsp->iobase);
+	snd_iprintf(buffer, "Control register: 0x%x\n", hdsp->control_register)=
;
+	snd_iprintf(buffer, "Control2 register: 0x%x\n",
+		    hdsp->control2_register);
+	snd_iprintf(buffer, "Status register: 0x%x\n", status);
+	snd_iprintf(buffer, "Status2 register: 0x%x\n", status2);
=20
-	if (hdsp_check_for_iobox (hdsp)) {
-		snd_iprintf(buffer, "No I/O box connected.\nPlease connect one and upl=
oad firmware.\n");
+	if (hdsp_check_for_iobox(hdsp)) {
+		snd_iprintf(buffer, "No I/O box connected.\n"
+			    "Please connect one and upload firmware.\n");
 		return;
-        }
+	}
=20
 	if (hdsp_check_for_firmware(hdsp, 0)) {
 		if (hdsp->state & HDSP_FirmwareCached) {
 			if (snd_hdsp_load_firmware_from_cache(hdsp) !=3D 0) {
-				snd_iprintf(buffer, "Firmware loading from cache failed, please uplo=
ad manually.\n");
+				snd_iprintf(buffer, "Firmware loading from "
+					    "cache failed, "
+					    "please upload manually.\n");
 				return;
 			}
 		} else {
@@ -3384,18 +3400,6 @@ snd_hdsp_proc_read(struct snd_info_entry *entry, s=
truct snd_info_buffer *buffer)
 		}
 	}
=20
-	status =3D hdsp_read(hdsp, HDSP_statusRegister);
-	status2 =3D hdsp_read(hdsp, HDSP_status2Register);
-
-	snd_iprintf(buffer, "%s (Card #%d)\n", hdsp->card_name, hdsp->card->num=
ber + 1);
-	snd_iprintf(buffer, "Buffers: capture %p playback %p\n",
-		    hdsp->capture_buffer, hdsp->playback_buffer);
-	snd_iprintf(buffer, "IRQ: %d Registers bus: 0x%lx VM: 0x%lx\n",
-		    hdsp->irq, hdsp->port, (unsigned long)hdsp->iobase);
-	snd_iprintf(buffer, "Control register: 0x%x\n", hdsp->control_register)=
;
-	snd_iprintf(buffer, "Control2 register: 0x%x\n", hdsp->control2_registe=
r);
-	snd_iprintf(buffer, "Status register: 0x%x\n", status);
-	snd_iprintf(buffer, "Status2 register: 0x%x\n", status2);
 	snd_iprintf(buffer, "FIFO status: %d\n", hdsp_read(hdsp, HDSP_fifoStatu=
s) & 0xff);
 	snd_iprintf(buffer, "MIDI1 Output status: 0x%x\n", hdsp_read(hdsp, HDSP=
_midiStatusOut0));
 	snd_iprintf(buffer, "MIDI1 Input status: 0x%x\n", hdsp_read(hdsp, HDSP_=
midiStatusIn0));
@@ -3416,7 +3420,6 @@ snd_hdsp_proc_read(struct snd_info_entry *entry, st=
ruct snd_info_buffer *buffer)
=20
 	snd_iprintf(buffer, "\n");
=20
-
 	switch (hdsp_clock_source(hdsp)) {
 	case HDSP_CLOCK_SOURCE_AUTOSYNC:
 		clock_source =3D "AutoSync";


--------------060501040203040607080504--

--------------enig247C1F1870B6D84FE0F0F416
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkqCoL0ACgkQdL+4qsZfVsuLxACfb0F/rolmVuDSfCqjkQpZNBBx
oi8An3vlgIUG1QnyyxT/YribDDsOA7HS
=oKLn
-----END PGP SIGNATURE-----

--------------enig247C1F1870B6D84FE0F0F416--

--===============3652562198187085032==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3652562198187085032==--
