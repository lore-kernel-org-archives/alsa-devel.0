From: Tim Blechmann <tim@klingt.org>
Subject: [PATCH v2] alsa: hdsp - allow proc reporting with
 disconnected io box
Date: Wed, 12 Aug 2009 18:12:43 +0200
Message-ID: <4A82E9FB.4090407@klingt.org>
References: <s5h63ctghh3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2415316280495409508=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from klingt.org (mail.klingt.org [86.59.21.178])
	by alsa0.perex.cz (Postfix) with ESMTP id AC2A22457B
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Aug 2009 18:12:47 +0200 (CEST)
In-Reply-To: <s5h63ctghh3.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============2415316280495409508==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig92CC1A971290A00F367B4A76"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig92CC1A971290A00F367B4A76
Content-Type: multipart/mixed;
 boundary="------------010601020703060900020005"

This is a multi-part message in MIME format.
--------------010601020703060900020005
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

here you go ...

--
the hdsp driver refuses to report any information via the proc
interface, if the io box is not connected. with this patch, the
content of the control and status registers is printed before the
iobox check.

v2: rebased against sound-2.6/master

Signed-off-by: Tim Blechmann <tim@klingt.org>
---
 sound/pci/rme9652/hdsp.c |   39 ++++++++++++++++++++++-----------------
 1 files changed, 22 insertions(+), 17 deletions(-)

--------------010601020703060900020005
Content-Type: text/x-patch;
 name="0001-alsa-hdsp-allow-proc-reporting-with-disconnected-io-.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename*0="0001-alsa-hdsp-allow-proc-reporting-with-disconnected-io-.pa";
 filename*1="tch"

diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index 3da5c02..7bb827c 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -3294,15 +3294,33 @@ snd_hdsp_proc_read(struct snd_info_entry *entry, =
struct snd_info_buffer *buffer)
 	char *clock_source;
 	int x;
=20
-	if (hdsp_check_for_iobox (hdsp)) {
-		snd_iprintf(buffer, "No I/O box connected.\nPlease connect one and upl=
oad firmware.\n");
+	status =3D hdsp_read(hdsp, HDSP_statusRegister);
+	status2 =3D hdsp_read(hdsp, HDSP_status2Register);
+
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
+
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
@@ -3319,18 +3337,6 @@ snd_hdsp_proc_read(struct snd_info_entry *entry, s=
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
@@ -3351,7 +3357,6 @@ snd_hdsp_proc_read(struct snd_info_entry *entry, st=
ruct snd_info_buffer *buffer)
=20
 	snd_iprintf(buffer, "\n");
=20
-
 	switch (hdsp_clock_source(hdsp)) {
 	case HDSP_CLOCK_SOURCE_AUTOSYNC:
 		clock_source =3D "AutoSync";


--------------010601020703060900020005--

--------------enig92CC1A971290A00F367B4A76
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkqC6f8ACgkQdL+4qsZfVsvJUwCfQ0SFxRwF3foUSEuvor7HxYdU
aWIAn24pmQV1kKpV1VjaK79hhJU0+tFP
=X8mb
-----END PGP SIGNATURE-----

--------------enig92CC1A971290A00F367B4A76--

--===============2415316280495409508==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2415316280495409508==--
