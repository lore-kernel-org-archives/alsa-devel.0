From: Nico Schottelius <nico-linux-alsa@schottelius.org>
Subject: Re: ALI M5451 (CMI 9739): PCM always muted?
Date: Sun, 2 May 2004 12:18:51 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040502101851.GB515@schottelius.org>
References: <200404171945.35824.bero@arklinux.org> <s5hd663q6fs.wl@alsa2.suse.de> <20040421120454.GC2295@schottelius.org> <s5h4qrdpkm2.wl@alsa2.suse.de> <20040421220031.GK2295@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pd0ReVV5GZGQvF3a"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from scice.schottelius.org (ns.schottelius.org [213.146.113.242])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id MAA21235
	for <alsa-devel@alsa-project.org>; Sun, 2 May 2004 12:17:07 +0200
Content-Disposition: inline
In-Reply-To: <20040421220031.GK2295@schottelius.org>
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


--Pd0ReVV5GZGQvF3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Just wanted to ask whether someone read my mail and if anyone knows
if there is the possibility to adjust sound volume or not.

Thanks for any answer/hint,

Nico

Nico Schottelius [Thu, Apr 22, 2004 at 12:00:31AM +0200]:
> Takashi Iwai [Wed, Apr 21, 2004 at 02:43:17PM +0200]:
> > > > there is no PCM volume on CM9739.  it has only PCM mute switch.
> > > > you can mute on/off via 'M' key of alsamixer.
> > >=20
> > > Does that mean I have _no_ possibility to adjust the volume?
> >=20
> > right.  it doesn't support the PCM volume but you can basically adjust
> > the master volume.
>=20
> This doesn't affect the sound volume, tested it again some seconds ago.
> Some weeks ago I even tried it with _every_ switch available.
> I just can switch it on or off, but no volume adjusting.
>=20
> And using master doesn't do anything at all.
>=20
> Do you have any hint for me? Perhaps I am doing something wrong?
>=20
> > > How do I find out if I got the CM9739? This is what lspci shows:
> >=20
> > you can see it in /proc/asound/card0/codec97#0/ac97#0-0.
>=20
> For you information, perhaps you need it:
>=20
> 0-0/0: C-Media Electronics CMI9739
>=20
> Capabilities     :
> DAC resolution   : 16-bit
> ADC resolution   : 16-bit
> 3D enhancement   : No 3D Stereo Enhancement
>=20
> Current setup
> Mic gain         : +0dB [+0dB]
> POP path         : pre 3D
> Sim. stereo      : off
> 3D enhancement   : off
> Loudness         : off
> Mono output      : MIX
> Mic select       : Mic1
> ADC/DAC loopback : off
> Extended ID      : codec=3D0 rev=3D1 LDAC SDAC CDAC DSA=3D0 SPDIF DRA
> Extended status  : SPCV LDAC SDAC CDAC SPDIF=3D3/4 SPDIF
> SPDIF Control    : Consumer PCM Category=3D0x2 Generation=3D1 Rate=3D48kHz
>=20
> Have a nice day,
>=20
> Nico
>=20
> --=20
> Keep it simple & stupid, use what's available.
> pgp: 8D0E E27A          | Nico Schottelius
> http://nerd-hosting.net | http://linux.schottelius.org



--=20
Keep it simple & stupid, use what's available.
pgp: 8D0E E27A          | Nico Schottelius
http://nerd-hosting.net | http://linux.schottelius.org

--Pd0ReVV5GZGQvF3a
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAlMsLzGnTqo0OJ6QRAvdSAJ9ff9dbwK6GHu+OdEHv9o83oFtf6gCfarHz
nrBqfFn0GlBK20/5LmmnOK0=
=XidC
-----END PGP SIGNATURE-----

--Pd0ReVV5GZGQvF3a--


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
