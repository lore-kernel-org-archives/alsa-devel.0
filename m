From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [PATCH] snd-via82xx: Support all sample rate conversion capabilities of DXS channels
Date: Mon, 11 Apr 2005 18:40:09 +0400
Message-ID: <20050411144009.GA4841@master.mivlgu.local>
References: <20050410155320.GA2101@procyon.home> <s5hzmw5o1bl.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hzmw5o1bl.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 11, 2005 at 04:06:06PM +0200, Takashi Iwai wrote:
> At Sun, 10 Apr 2005 19:53:20 +0400,
> Sergey Vlasov wrote:
> > Add support for full sample rate conversion capabilities of DXS
> > channels present in VIA VT8233/5/7 controllers:
> >=20
> > - any sample rate in the 8000 ... 48000 Hz range is supported even if
> >   the AC'97 codec supports only 48000 Hz output;
> >=20
> > - different DXS channels can use different sample rates at the same
> >   time (the controller performs required sample rate conversion and
> >   mixing in hardware).
>=20
> Thanks.  I applied it to CVS.
>=20
> If I understand correctly, this feature should be available on all
> machines with dxs_support=3D4, but you added a new dxs_support entry
> just to be sure not to break, right?

Yes, it should work, but this driver was broken too many times in the
past (and some Linux distributions still select via82cxxx_audio instead of
snd-via82xx by default because of this).  On the other hand, this means
that many existing entries with VIA_DXS_NO_VRA will just stay that way,
because the driver will not give any messages to try dxs_support=3D5.

In fact, I wonder how dxs_support=3D1 could work at all, if the controller
resamples everything to 48000, but the codec is configured to use some
other rate.  Some hardware must be broken to make this work :)

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFCWoxJW82GfkQfsqIRAv/6AJsFcxFSOlLABCw0/NeCafzg17OPrACeIGqx
BCHP1H8qz6iDBH+9msdowvY=
=eOwD
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
