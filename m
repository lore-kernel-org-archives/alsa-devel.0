From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: ALI M5451 (CMI 9739): PCM always muted?
Date: Sat, 17 Apr 2004 22:10:52 +0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040417181052.GC2469@sirius.home>
References: <200404171945.35824.bero@arklinux.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IpbVkmxF4tDyP/Kb"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from ns1.murom.ru ([213.177.124.6])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id VAA20620
	for <alsa-devel@alsa-project.org>; Sat, 17 Apr 2004 21:26:13 +0200
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--IpbVkmxF4tDyP/Kb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 17, 2004 at 07:45:35PM +0200, Bernhard Rosenkraenzer wrote:
> On an ALI M5451 (Using a CMI 9739 - PCI ID 10b9:5451 Sub-ID 1019:0f22),=
=20
> snd_ali5451 loads and can adjust mixer settings (except for PCM volume, b=
ut I=20
> think that's a limitation of the hardware), but doesn't make any noise -=
=20
> apparently PCM is always muted (volume fixed at 0?).
>=20
> Is this a known bug? Didn't have the time to check the code yet...

There was a report that on a similar codec/controller combination such
problem was caused by the "IEC958 Capture Monitor" switch turned on.
Turning this switch off in alsamixer fixed the problem.

--IpbVkmxF4tDyP/Kb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAgXMsW82GfkQfsqIRAk9IAJ9HeD0cItQ9Ch7n1scKAiLdxdd+5ACbBK99
U9PX9JjXkFAz2mVuioBU1so=
=61NZ
-----END PGP SIGNATURE-----

--IpbVkmxF4tDyP/Kb--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
