From: "David E. Storey" <dave@tamos.net>
Subject: Re: alsa and gtk
Date: 08 Jun 2003 17:02:56 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1055106176.875.1.camel@localhost>
References: <1055071787.418.9.camel@localhost>
	 <1055095801.17291.17.camel@lotte>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-0EB/f29RKgBrfVo1sDkH"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1055095801.17291.17.camel@lotte>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Justin Cormack <justin@street-vision.com>
Cc: alsa <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-0EB/f29RKgBrfVo1sDkH
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

curious... that did the trick. True about the inefficiency... but then
again, we are talking about GUI's. ;-) Thanks!

d!

On Sun, 2003-06-08 at 14:10, Justin Cormack wrote:
> I had a problem like this once, not with gtk. The controls  get
> corrupted. I had an extrmemely short deadline so I just allocated and
> freed a new control every time I wanted to use it, rather inefficient. I
> think it *must* be an alsa bug, but it is very strange. Hope you can
> find it.=20


--=-0EB/f29RKgBrfVo1sDkH
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+46SA+5sC2muyxOMRAhJpAJ9j5AgxiF12OFx+zjDWviuUciDs3gCfWA2t
w5zKA64c9Z1Fp4mieBL7l2M=
=ClWL
-----END PGP SIGNATURE-----

--=-0EB/f29RKgBrfVo1sDkH--



-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
