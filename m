From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RESEND][PATCH] ASoC: Update omap/ams-delta for
 TTY API change
Date: Mon, 6 Jun 2011 12:58:42 +0300
Message-ID: <20110606095841.GM18731@legolas.emea.dhcp.ti.com>
References: <201105121929.50301.jkrzyszt@tis.icnet.pl>
	<20110513070040.GA18783@opensource.wolfsonmicro.com>
	<4DCCF90C.7030301@ti.com>
	<201106032337.53347.jkrzyszt@tis.icnet.pl>
	<4DECA3AD.2000100@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8501904610374282509=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog113.obsmtp.com (na3sys009aog113.obsmtp.com
	[74.125.149.209])
	by alsa0.perex.cz (Postfix) with ESMTP id D079A103804
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Jun 2011 11:58:49 +0200 (CEST)
Received: by fxm11 with SMTP id 11so3440238fxm.41
	for <alsa-devel@alsa-project.org>; Mon, 06 Jun 2011 02:58:46 -0700 (PDT)
In-Reply-To: <4DECA3AD.2000100@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Balbi,
	Felipe" <balbi@ti.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org


--===============8501904610374282509==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kc9HNjpzOXVc7FFU"
Content-Disposition: inline


--Kc9HNjpzOXVc7FFU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 06, 2011 at 10:53:49AM +0100, Liam Girdwood wrote:
> On 03/06/11 22:37, Janusz Krzysztofik wrote:
> > Dnia pi=C4=85tek 13 maj 2011 o 11:25:32 Liam Girdwood napisa=C5=82(a):
> >> On 13/05/11 08:00, Mark Brown wrote:
> >>> On Fri, May 13, 2011 at 12:36:07AM +0200, Janusz Krzysztofik wrote:
> >>>> Following the receive_buf() change to return the number of bytes
> >>>> received, the cx20442 CODEC driver was updated to report that we
> >>>> accepted all the data that was offered to us. Do the same with the
> >>>> corresponding Amstrad Delta sound card level wrapper function,
> >>>> which is actually registered as the tty line discipline callback
> >>>> instead of the the CODEC function, which it then calls.
> >>>>
> >>>> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> >>>
> >>> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> >>>
> >>> but as the TTY API change is in the TTY tree at the minute and not
> >>> ASoC you should send this to Greg K-H (ideally also with Liam's
> >>> ack) unless it's not been applied by the time the merge window
> >>> comes round.
> >>
> >> Fine by me too.
> >>
> >> Acked-by: Liam Girdwood <lrg@ti.com>
> >=20
> > Hi,
> > I failed to send this patch to Greg before the merge window, sorry. Now=
=20
> > that we are in the rc cycle, can it be applied to the sound tree, or=20
> > should I resend it?
> >=20
>=20
> Best to resend with Ack's.

I'm not sure, the commit was reverted anyway by Linus.

--=20
balbi

--Kc9HNjpzOXVc7FFU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJN7KTRAAoJEAv8Txj19kN1Fu8H/0v+bwop2xYRVSjGMAiKl5v+
d5XKnQYOUiNp4UpdpDVCyhayKH6NFwVChbl7+05lKvUQGHu37EqIoJs1JyHTyYQm
anwHP9tn/hC1YIIK0AZYwMgW5oTwdaRyC8Ipy3kGdUG3wCh6GB+X1EpAAcUX6zSr
6RDk6HZeWzLEXq6YVk9N9oTjS194lAjc8rzLfmPBKEed4kRUmV4rJ3KYZT3oXqH9
B9Jz8g2wkFU7UMuxMum428vsnuGQc8lpixiFs9sXCkqxtYuM3p2K9J5yDlZ/zxhb
jsRUo9HGfieJlMXVyqvSx9Hv1EX0oOnCQ5stqN5t4ijK8VMqYNVMxhUXli4P/24=
=NwNq
-----END PGP SIGNATURE-----

--Kc9HNjpzOXVc7FFU--

--===============8501904610374282509==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8501904610374282509==--
