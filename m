From: "David E. Storey" <dave@tamos.net>
Subject: Re: 24bit hdsp
Date: 28 May 2003 21:03:06 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1054170186.424.71.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-3yHRUY7XGq+e/401qcbv"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-3yHRUY7XGq+e/401qcbv
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I was reading

http://petertodd.ca/hdsp.php

and the only place it mentioned 24 bit was down toward the bottom,
implying that it wasn't supported. But now that I know it is and looking
through the source for jack, it would appear that by default, it will
open the device in 24bit mode, that's good. It would appear that as
opposed to most other drivers, I shouldn't be using dithering on this
device as I'll loose my dynamic range, yes? (I noticed your name all
over the code, so I'm betting your probably the best to ask this
question...)

d!


On Wed, 2003-05-28 at 17:12, Paul Davis wrote:
> >what would it take to support 24bit audio in the hdsp driver? Would it
> >take away from the number of available channels? I'd like to use an
> >Alesis AI-3 (mostly due to cost) with my multiface, but I'd like to be
> >able to utilize all 18 channels the multiface provides. Is there any way
> >I can help?
>=20
> the driver already supports 24 bit audio. if you use the hw layer, it
> must match the hw's definition of 24 bit: 24 bits packed in the upper
> bits of a 32 bit word. if you use the plughw layer, you can probably
> get "true" 24 bit audio (i doubt if this code path has been explored
> much).=20


--=-3yHRUY7XGq+e/401qcbv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+1VxK+5sC2muyxOMRAhT4AJ9TnIR7aNzR4oL7Upl5nLlPWucxlACfbNIG
ME7SR5naho/ES2sUbAq25pU=
=JQmb
-----END PGP SIGNATURE-----

--=-3yHRUY7XGq+e/401qcbv--



-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
