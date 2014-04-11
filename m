From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: jack: export gpio detect
Date: Fri, 11 Apr 2014 11:12:45 +0100
Message-ID: <20140411101245.GO6518@sirena.org.uk>
References: <CF69AC38.3C92E%cfreeman@nvidia.com>
 <CF6C7514.3DC69%cfreeman@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9041234856108078909=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CC9C7264F8D
 for <alsa-devel@alsa-project.org>; Fri, 11 Apr 2014 12:12:56 +0200 (CEST)
In-Reply-To: <CF6C7514.3DC69%cfreeman@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Christopher Freeman <cfreeman@nvidia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============9041234856108078909==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p5BJhDJf0owydRUK"
Content-Disposition: inline


--p5BJhDJf0owydRUK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2014 at 04:24:58PM -0700, Christopher Freeman wrote:
> On 4/8/14 1:40 PM, "Christopher Freeman" <cfreeman@nvidia.com> wrote:

> >Mark, do you have a suggestion on how to plumb this up?  The way I see i=
t,
> >the machine drivers own the context for the gpios and soc-jack acts as a
> >helper library.  I don't see a way to do this from the core.

> Any thoughts?  One idea would be to change things such that jacks are
> registered with the core and the core is then allowed access to the gpio
> detect function=C5=A0  This would make things common, but we're still ope=
ning
> up a function in the jack code.  I don't see another way.  (using the
> existing interface, we could free and add gpios on suspend/resume=C5=A0 :=
-P)

Please allow a reasonable time for replies, especially during the merge
window.

--p5BJhDJf0owydRUK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTR8AZAAoJELSic+t+oim9IUMP/jIjYl/QiLXiGITtngd5vGCH
05zKJ8GSueY+bhHkucenJ7g947GkL9azKfJmMCl4aFO+wx00tEWvhFxlD/OVxTXi
YzbfU6PifjdvvVQLzJmveGLC6YAKnht7MJLmSwqdrERJVrbOBGiOrIcyfr93UPcT
6sBDOPkXS1eaF3xH6vkDAObUyGTN8jRsO6SUW7j2FA+DWSPVV1gmzald7U7zxdWe
kwLZt9wLMIG00+1CagjVMdc7mDB4417Uedh8QRfZXo1WlzfMtBwGJ3/JmF94w2qH
oKbHS2iKN1j9o29ok3Pb7AMtJdAQU18vSKB5EnXEZItH2/9CuK1RbGmeLq2Orhws
Qqw/bxfT6NZLfTOF8oS0soy8q0epU+Tm33C1ujih43KcaydfErKwF/v5mmlIHARQ
J1lPTqGcB2l6FtmcQ/VraALGRJ4/wTU5kDVD2BjfJEmSU01zjuq4gV9vkgLpqQWL
rZCphVlIoFgKKhOkSGYUr5mNzRlU7Ydy5sfb8Tc+NTuGK6kwmpIceVrzN5EI11FB
zsS+fBXqy+bsHP85OOZaiVxERgiUReD4n16spI7u4Ib0rBcbpxLfV7kowZUKYHbd
UyCu43vPHrbB1Oz/gxHuGcsnFIrpwJyntVgaCrNjgl+PYX4f8mzckoeLVkOVKbC8
UiF2wwGdzCtV6pFGyWNc
=vs4X
-----END PGP SIGNATURE-----

--p5BJhDJf0owydRUK--

--===============9041234856108078909==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9041234856108078909==--
