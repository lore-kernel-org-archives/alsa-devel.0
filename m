From: Nico Schottelius <nico-linux-alsa@schottelius.org>
Subject: Re: ALI M5451 (CMI 9739): PCM always muted?
Date: Mon, 19 Apr 2004 23:05:54 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040419210554.GH229@schottelius.org>
References: <200404171945.35824.bero@arklinux.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tT3UgwmDxwvOMqfu"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from scice.schottelius.org (pD9E351ED.dip.t-dialin.net [217.227.81.237])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id XAA15823
	for <alsa-devel@alsa-project.org>; Mon, 19 Apr 2004 23:04:16 +0200
Content-Disposition: inline
In-Reply-To: <200404171945.35824.bero@arklinux.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Bernhard Rosenkraenzer <bero@arklinux.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--tT3UgwmDxwvOMqfu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Bernhard,

Bernhard Rosenkraenzer [Sat, Apr 17, 2004 at 07:45:35PM +0200]:
> Hi,
> On an ALI M5451 (Using a CMI 9739 - PCI ID 10b9:5451 Sub-ID 1019:0f22),=
=20
> snd_ali5451 loads and can adjust mixer settings (except for PCM volume, b=
ut I=20
> think that's a limitation of the hardware),

I don't really think so, as the version I had in my old Acer TM 524TEV
allowed adjusting.

If no adjusting of pcm is available, howto adjust volume? Master doesn't
affect any setting.

> but doesn't make any noise -=20
> apparently PCM is always muted (volume fixed at 0?).

Just unmute it with alsamixer, but it will raise volume to highest level.

Nico

--=20
Keep it simple & stupid, use what's available.
pgp: 8D0E E27A          | Nico Schottelius
http://nerd-hosting.net | http://linux.schottelius.org

--tT3UgwmDxwvOMqfu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAhD8yzGnTqo0OJ6QRAghkAKCG+C9/2Lq4lQIFEkgemSRDZG+oigCfdohn
FVjNC4QJFMmT5v/3qhg9YYc=
=JJbC
-----END PGP SIGNATURE-----

--tT3UgwmDxwvOMqfu--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
