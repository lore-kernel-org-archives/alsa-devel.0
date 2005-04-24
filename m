From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH] snd-ac97-codec: add support for Front Mic input on ALC850
Date: Sun, 24 Apr 2005 16:28:28 +0400
Message-ID: <20050424122828.GB14587@procyon.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yNb1oOkm5a9FJOVX"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--yNb1oOkm5a9FJOVX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add the "Mic Front Input Switch" control to the mixer for ALC850.
Enabling this input is required for using the front panel microphone
connector with ASUS A8V motherboard.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>

--- alsa-driver/alsa-kernel/pci/ac97/ac97_patch.c.alc850-front-mic	2005-04-=
23 19:35:45 +0400
+++ alsa-driver/alsa-kernel/pci/ac97/ac97_patch.c	2005-04-24 16:12:11 +0400
@@ -1928,6 +1928,7 @@ static void alc850_update_jacks(ac97_t *
=20
 static const snd_kcontrol_new_t snd_ac97_controls_alc850[] =3D {
 	AC97_PAGE_SINGLE("Duplicate Front", AC97_ALC650_MULTICH, 0, 1, 0, 0),
+	AC97_SINGLE("Mic Front Input Switch", AC97_ALC850_JACK_SELECT, 15, 1, 1),
 	AC97_SURROUND_JACK_MODE_CTL,
 	AC97_CHANNEL_MODE_CTL,
 };

--yNb1oOkm5a9FJOVX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCa5DsW82GfkQfsqIRAlnfAJ43DB1RQY5SCfo7pn9J8HbpkOff5gCffVL8
tBVgVvpTkNoP4hTJ4tIuBvE=
=G3QI
-----END PGP SIGNATURE-----

--yNb1oOkm5a9FJOVX--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
