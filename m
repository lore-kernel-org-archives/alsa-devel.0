From: Nico Schottelius <nico-linux-alsa@schottelius.org>
Subject: Re: ALI M5451 (CMI 9739): PCM always muted?
Date: Thu, 22 Apr 2004 00:00:31 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040421220031.GK2295@schottelius.org>
References: <200404171945.35824.bero@arklinux.org> <s5hd663q6fs.wl@alsa2.suse.de> <20040421120454.GC2295@schottelius.org> <s5h4qrdpkm2.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9/GiYV45wF7IL3Iq"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from scice.schottelius.org (ns.schottelius.org [213.146.113.242])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id XAA12294
	for <alsa-devel@alsa-project.org>; Wed, 21 Apr 2004 23:59:09 +0200
Content-Disposition: inline
In-Reply-To: <s5h4qrdpkm2.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Bernhard Rosenkraenzer <bero@arklinux.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--9/GiYV45wF7IL3Iq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Takashi Iwai [Wed, Apr 21, 2004 at 02:43:17PM +0200]:
> > > there is no PCM volume on CM9739.  it has only PCM mute switch.
> > > you can mute on/off via 'M' key of alsamixer.
> >=20
> > Does that mean I have _no_ possibility to adjust the volume?
>=20
> right.  it doesn't support the PCM volume but you can basically adjust
> the master volume.

This doesn't affect the sound volume, tested it again some seconds ago.
Some weeks ago I even tried it with _every_ switch available.
I just can switch it on or off, but no volume adjusting.

And using master doesn't do anything at all.

Do you have any hint for me? Perhaps I am doing something wrong?

> > How do I find out if I got the CM9739? This is what lspci shows:
>=20
> you can see it in /proc/asound/card0/codec97#0/ac97#0-0.

For you information, perhaps you need it:

0-0/0: C-Media Electronics CMI9739

Capabilities     :
DAC resolution   : 16-bit
ADC resolution   : 16-bit
3D enhancement   : No 3D Stereo Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=3D0 rev=3D1 LDAC SDAC CDAC DSA=3D0 SPDIF DRA
Extended status  : SPCV LDAC SDAC CDAC SPDIF=3D3/4 SPDIF
SPDIF Control    : Consumer PCM Category=3D0x2 Generation=3D1 Rate=3D48kHz

Have a nice day,

Nico

--=20
Keep it simple & stupid, use what's available.
pgp: 8D0E E27A          | Nico Schottelius
http://nerd-hosting.net | http://linux.schottelius.org

--9/GiYV45wF7IL3Iq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAhu7+zGnTqo0OJ6QRAgGwAKCYsrcJ70Wz9N8YkOykE9FVkfvMhACbB34W
J+y1Z936Rsu1N8ucyw9h98Y=
=Wy+K
-----END PGP SIGNATURE-----

--9/GiYV45wF7IL3Iq--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
