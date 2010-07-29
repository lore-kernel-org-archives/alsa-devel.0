From: "Mario 'BitKoenig' Holbe" <Mario.Holbe@TU-Ilmenau.DE>
Subject: Re: Regression 2.6.35-rc6: ALSA Intel HDA/Realtek:
 missing	Beep
Date: Thu, 29 Jul 2010 10:41:38 +0200
Message-ID: <20100729084138.GA15456@darkside.kls.lan>
References: <20100728144903.GA18170@darkside.kls.lan>
	<s5hzkxbtya9.wl%tiwai@suse.de> <s5htynjtwz2.wl%tiwai@suse.de>
	<20100728212745.GA15394@darkside.kls.lan>
	<s5hd3u6alkp.wl%tiwai@suse.de>
	<20100729080930.GA20619@darkside.kls.lan>
	<s5h7hkeae35.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7787235635684398054=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from piggy.rz.tu-ilmenau.de (piggy.rz.tu-ilmenau.de [141.24.4.8])
	by alsa0.perex.cz (Postfix) with ESMTP id 190F11037F1
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Jul 2010 10:41:43 +0200 (CEST)
In-Reply-To: <s5h7hkeae35.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============7787235635684398054==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 29, 2010 at 10:26:22AM +0200, Takashi Iwai wrote:
> FYI, you can change SSID by writing /sys/class/sound/hwC*D*/subsystem_id
> file.  Then reconfigure the codec via triggering
> /sys/class/sound/hwC*D*/reconfig.

Great, that's what I meant with "Or am I somehow able to tweak it? Is
there a module parameter to set this SSID bit?" :)

$ for i in /sys/class/sound/hwC*D*/subsystem_id; do echo "$i: $(cat $i)"; d=
one  =20
/sys/class/sound/hwC0D0/subsystem_id: 0x1043829f
/sys/class/sound/hwC0D1/subsystem_id: 0xffffffff

So, obviously the first check in
	if (ass !=3D codec->bus->pci->subsystem_device && (ass & 1))
is false. How can I tweak the subsystem_id least-invasive not to match
codec->bus->pci->subsystem_device (which should be 0x829f then) anymore?


Mario
--=20
Gib einem Hungrigen einen Fisch, und er ist fuer einen Tag satt.
Zeig ihm, wie man angelt, und er poebelt Dich an, dass er besseres
zu tun haette, als Schnuere ins Wasser haengen zu lassen.
                              -- David Kastrup in de.comp.text.tex

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEVAwUBTFE+whS+e2HeSPbpAQK8ywf/XN44CPUwpYF3pW2xkmjXqOAA4llZ7ab2
6nzMCHEzfWOXxv8OTHBob6t5BXFl9xIGIxsatfdcXuAsHQ9p+Fe8biJ1xHz3On5L
TFAQBE86bls7VZlqa2DOYr16qrrM3gfEKWD60T8R5bbVXFvIIzS7d1+Nl7d7OtoF
UuJnBlRw7slcMCGZU6EWzMtG+z2mU9ULUytWDBI4a78m4IpyjjKvtXlu/K1kz/fm
MqwYk7iFFEkDSdNYv5wWNyjY4m/XBUjXAF0THp9tq75sldVzogAlwmIQuMoJdmrR
dq8g1ry7hBa8eQrStprVWzNU30KNyom0swESXdQ0Hnusv7RKoHgAXg==
=6WOB
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--

--===============7787235635684398054==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============7787235635684398054==--
