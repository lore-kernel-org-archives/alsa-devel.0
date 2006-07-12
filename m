From: Pierre Ossman <ossman@cendio.se>
Subject: Re: How to send patch with moves?
Date: Wed, 12 Jul 2006 16:36:32 +0200
Message-ID: <44B508F0.5060803@cendio.se>
References: <44B4A3E8.8060509@cendio.se>	<s5hac7f5fcu.wl%tiwai@suse.de>	<44B4C8CC.8080400@cendio.se>
	<s5hac7f6klk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0468128909=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mail.cendio.se (mail.cendio.se [193.12.253.69])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A034C157
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Jul 2006 16:36:37 +0200 (MEST)
In-Reply-To: <s5hac7f6klk.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============0468128909==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig417FAB6D92C4E284ECA63DAE"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig417FAB6D92C4E284ECA63DAE
Content-Type: multipart/mixed; boundary="------------000905060007010807010206"

This is a multi-part message in MIME format.
--------------000905060007010807010206
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Takashi Iwai wrote:
> At Wed, 12 Jul 2006 12:02:52 +0200,
> Pierre Ossman wrote:
>> Takashi Iwai wrote:
>>> Please provide new files, and I'll do hg mv manually.
>>> If any particular changes except for renaming, please let me know,
>>> too.
>>>
>> Tarball with files included. They're changed a bit, but only by doing
>> s/polyp/pulse/ and variations thereof.
>=20
> Any change for doc/* ?
>=20

*doh*

Here is a fixed README and Makefile.am for the doc directory.

--=20
Pierre Ossman                Telephone: +46-13-21 46 00
Cendio AB                    Web: http://www.cendio.com

--------------000905060007010807010206
Content-Type: text/plain;
 name="Makefile.am"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="Makefile.am"

EXTRA_DIST =3D README-pcm-oss README-jack README-pulse \
	upmix.txt vdownmix.txt samplerate.txt a52.txt

--------------000905060007010807010206
Content-Type: text/plain;
 name="README-pulse"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="README-pulse"

PulseAudio <--> ALSA plugins
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

This plugin allows any program that uses the ALSA API to access a PulseAu=
dio
sound daemon. In other words, native ALSA applications can play and recor=
d
sound across a network.

There are two plugins in the suite, one for PCM and one for mixer control=
=2E A
typical configuration will look like:

    pcm.pulse {
        type pulse
    }

    ctl.pulse {
        type pulse
    }

Put the above in ~/.asoundrc, or /etc/asound.conf, and use "pulse" as dev=
ice
in your ALSA applications. For example:

    % aplay -Dpulse foo.wav
    % amixer -Dpulse

PulseAudio will accept more or less any format you throw at it. So a plug=

wrapper is unnecessary. Mixing is also handled so dmix will only cause a
performance hit without any gain.

The plugins will respect your PulseAudio environment variables (like
PULSE_SERVER), but you can override these in ALSA's configuration files.

Both plugins accept the "server" parameter, specifying which PulseAudio s=
erver
to contact. Both also accept the "device" parameter, which indicate which=

source and sink to use.

The mixer control plugin also accepts the parameters "source" and "sink" =
for
when you need to specify a sink/source combination with different names. =
If
you need to do this with PCM:s then specify two PCM:s with different "dev=
ice".

If you do not specify any source and/or sink, then the server's defaults =
will
be used.

--------------000905060007010807010206--

--------------enig417FAB6D92C4E284ECA63DAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEtQjz7b8eESbyJLgRArjeAJ97545nv3DM0upcFXC+uBftdqbgTQCeJLWK
20rC1T+1SYkrGGqkmMzWv54=
=LVUm
-----END PGP SIGNATURE-----

--------------enig417FAB6D92C4E284ECA63DAE--


--===============0468128909==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

--===============0468128909==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0468128909==--
