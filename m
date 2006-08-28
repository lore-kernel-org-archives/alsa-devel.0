From: Pierre Ossman <ossman@cendio.se>
Subject: [PATCH] Remove stray Polypaudio strings
Date: Mon, 28 Aug 2006 08:28:27 +0200
Message-ID: <44F28D0B.7060609@cendio.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2083959373=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mail.cendio.se (mail.cendio.se [193.12.253.69])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5149A271
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Aug 2006 08:28:29 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============2083959373==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC23D360D3BD187B00B6E5F49"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC23D360D3BD187B00B6E5F49
Content-Type: multipart/mixed; boundary="------------070108070708040109010906"

This is a multi-part message in MIME format.
--------------070108070708040109010906
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Some stray mentions of the old Polypaudio name was still present in the
PulseAudio plug-in.

Signed-off-by: Pierre Ossman <ossman@cendio.se>


--------------070108070708040109010906
Content-Type: text/x-patch;
 name="polyp.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="polyp.patch"

diff -r fa66f27a1d63 pulse/ctl_pulse.c
--- a/pulse/ctl_pulse.c	Tue Aug 22 14:40:44 2006 +0200
+++ b/pulse/ctl_pulse.c	Sun Aug 27 23:25:03 2006 +0200
@@ -689,10 +689,10 @@ SND_CTL_PLUGIN_DEFINE_FUNC(pulse)
     ctl->ext.version =3D SND_CTL_EXT_VERSION;
     ctl->ext.card_idx =3D 0;
     strncpy(ctl->ext.id, "pulse", sizeof(ctl->ext.id) - 1);
-    strncpy(ctl->ext.driver, "Polypaudio plugin", sizeof(ctl->ext.driver=
) - 1);
-    strncpy(ctl->ext.name, "Polypaudio", sizeof(ctl->ext.name) - 1);
-    strncpy(ctl->ext.longname, "Polypaudio", sizeof(ctl->ext.longname) -=
 1);
-    strncpy(ctl->ext.mixername, "Polypaudio", sizeof(ctl->ext.mixername)=
 - 1);
+    strncpy(ctl->ext.driver, "PulseAudio plugin", sizeof(ctl->ext.driver=
) - 1);
+    strncpy(ctl->ext.name, "PulseAudio", sizeof(ctl->ext.name) - 1);
+    strncpy(ctl->ext.longname, "PulseAudio", sizeof(ctl->ext.longname) -=
 1);
+    strncpy(ctl->ext.mixername, "PulseAudio", sizeof(ctl->ext.mixername)=
 - 1);
     ctl->ext.poll_fd =3D -1;
     ctl->ext.callback =3D &pulse_ext_callback;
     ctl->ext.private_data =3D ctl;
diff -r fa66f27a1d63 pulse/pcm_pulse.c
--- a/pulse/pcm_pulse.c	Tue Aug 22 14:40:44 2006 +0200
+++ b/pulse/pcm_pulse.c	Sun Aug 27 23:25:23 2006 +0200
@@ -471,7 +471,7 @@ static int pulse_prepare(snd_pcm_ioplug_
=20
     err =3D pulse_wait_stream_state(pcm->p, pcm->stream, PA_STREAM_READY=
);
     if (err < 0) {
-        fprintf(stderr, "*** POLYPAUDIO: Unable to create stream.\n");
+        fprintf(stderr, "*** PULSEAUDIO: Unable to create stream.\n");
         pa_stream_unref(pcm->stream);
         pcm->stream =3D NULL;
         goto finish;
@@ -524,7 +524,7 @@ static int pulse_hw_params(snd_pcm_ioplu
         pcm->ss.format =3D PA_SAMPLE_FLOAT32BE;
         break;
     default:
-        fprintf(stderr, "*** POLYPAUDIO: unsupported format %s\n",
+        fprintf(stderr, "*** PULSEAUDIO: unsupported format %s\n",
             snd_pcm_format_name(io->format));
         err =3D -EINVAL;
         goto finish;
@@ -715,7 +715,7 @@ SND_PCM_PLUGIN_DEFINE_FUNC(pulse)
         goto error;
=20
 	pcm->io.version =3D SND_PCM_IOPLUG_VERSION;
-	pcm->io.name =3D "ALSA <-> Polypaudio PCM I/O Plugin";
+	pcm->io.name =3D "ALSA <-> PulseAudio PCM I/O Plugin";
 	pcm->io.poll_fd =3D -1;
 	pcm->io.poll_events =3D 0;
 	pcm->io.mmap_rw =3D 0;

--------------070108070708040109010906--

--------------enigC23D360D3BD187B00B6E5F49
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFE8o0L7b8eESbyJLgRArSNAJ4pDs18sxZyPOUIRhgddcQC3bnHWACfbmFH
/rR0pOxeGV2H78kxlqOfEyo=
=lAW4
-----END PGP SIGNATURE-----

--------------enigC23D360D3BD187B00B6E5F49--


--===============2083959373==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============2083959373==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============2083959373==--
