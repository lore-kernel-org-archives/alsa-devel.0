From: Alexander Samad <alex@samad.com.au>
Subject: Re: [PATCH] emu10k1 multichannel support
Date: Thu, 20 Jan 2005 09:16:39 +1100
Message-ID: <20050119221638.GC14030@samad.com.au>
References: <1106091073.24484.60.camel@krustophenia.net> <20050119195154.GR27550@samad.com.au> <1106169110.3050.9.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oTHb8nViIGeoXxdp"
Return-path: <alsa-user-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1106169110.3050.9.camel@krustophenia.net>
Sender: alsa-user-admin@lists.sourceforge.net
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--oTHb8nViIGeoXxdp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi

applied the patch and the config is slightly different now I can see
device=20
card 0: Audigy2Value [Sound Blaster Audigy2_Value], device 3: emu10k1
[EMU10K1 multichannel EFX]
  Subdevices: 1/1
  Subdevice #0: subdevice #0


but I can not play any sounds at all nor can I pass through ac3.  I have
a live  card in there that was working and then removed it and replaced
it with the audigy2 played with the mixer and then tried the ac3 pass
through and no luck.

the amp still shows it up as analog PCM !

Alex



On Wed, Jan 19, 2005 at 04:11:49PM -0500, Lee Revell wrote:
> On Thu, 2005-01-20 at 06:51 +1100, Alexander Samad wrote:
> > Hi
> >=20
> > Interested in this, been trying to get multi channel output from audigy2
> > card
> >=20
>=20
> What ALSA version do you have?  Are you sure you applied the patch
> correctly?
>=20
> Lee
>=20
>=20

--oTHb8nViIGeoXxdp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFB7txGkZz88chpJ2MRAl6WAKDR+Y5kCplrnYDot0Wy7hy08oEQdACfQEme
4utybikC9eM5KO8dyXbhJ1I=
=ZtRs
-----END PGP SIGNATURE-----

--oTHb8nViIGeoXxdp--


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
