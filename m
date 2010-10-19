From: Vasily khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH 00/25] ASoC: Overhaul Samsung drivers
Date: Tue, 19 Oct 2010 11:00:15 +0300
Message-ID: <20101019110015.49dcb79b@anarsoul-laptop>
References: <1287471805-17952-1-git-send-email-jassisinghbrar@gmail.com>
	<053901cb6f5f$76b9dea0$642d9be0$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8985732698481089133=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 2C765103923
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Oct 2010 10:00:34 +0200 (CEST)
Received: by ewy9 with SMTP id 9so1359691ewy.38
	for <alsa-devel@alsa-project.org>; Tue, 19 Oct 2010 01:00:34 -0700 (PDT)
In-Reply-To: <053901cb6f5f$76b9dea0$642d9be0$%kim@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, 'Jassi Brar' <jassi.brar@samsung.com>, 'Jassi Brar' <jassisinghbrar@gmail.com>, ben-linux@fluff.org, june.bae@samsung.com, sw.youn@samsung.com, linux-arm-kernel@lists.infradead.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

--===============8985732698481089133==
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/I45k624GltXszyhqhZ8h38L"; protocol="application/pgp-signature"

--Sig_/I45k624GltXszyhqhZ8h38L
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 19 Oct 2010 16:30:09 +0900
Kukjin Kim <kgene.kim@samsung.com> wrote:

> Jassi Brar wrote:
> >=20
> > From: Jassi Brar <jassi.brar@samsung.com>
> >=20
> > Hi,
>=20
> Hi :-)
> >=20
> > Here come patches overhauling the Samsung ASoC support.
> >=20
> > The AC97, PCM, SPDIF and ASoC-DMA related code has merely undergone
> > cosmetic changes - symbol, device & driver renaming and file moving.
> >=20
> > A new I2S controller driver has been added to manage Samsung SoCs since
> > S3C64XX. Older driver has been changed only as is necessary.
> > Regarding I2S, I have left the s3c24xx series untouched because the
> > controllers are too different to run by a common driver. S3C2412's I2S
> > does have some similarities, but not important enough to warrant impact
> > on new driver design.
> > The new I2S driver has been designed around the notion of features/quir=
ks.
> > The newer SoCs have revised version of I2S_0(usually) than previous one=
s.
> > So, I2S block is 'specified' in the platform code and the driver works =
on
> > that configuration.
> > For now, Secondary I2S DAI works only with System-DMAC. I2S-Internal DMA
> > and SRAM will be enabled later.
> >=20
> > Testing:-
> >   Simple testing of 5.1 channel and hardware mixing seems to work (thou=
gh
> > there seems to be some issue with symmetric_rates in soc-core.c which
> > would be tried to fix later as saperate issue).
> >  I would appreciate any test-results for GONI and SMARTQ.
> >=20
> > I suggest the patches 13,14,16 & 17 go via Kgene's Tree, and the rest v=
ia
> > ASoC
> > tree due to tight dependencies.
>=20
> Hmm...in my opinion, it would be better to me if could send arch/arm/ stu=
ff
> to upstream via my tree even though there are dependencies.
> Mark, how do you think?

As for me, that's not a good idea. We'll get massive breakage during
2.6.37 merge window then. Here's example: my sound-related changes to
machine files are merged through Ben's tree, but these changes aren't
in asoc tree, so Jassi is no aware of them, but now these changes are
outdated a bit due to device renaming. And this introduce compile
breakage.

And if I understood correctly, merging these arch/arm changes through
your tree will result in temporary compile breakage for both trees -
your and asoc.

Keep changes consistent :)

Regards
Vasily

--Sig_/I45k624GltXszyhqhZ8h38L
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAky9UA8ACgkQRM6pQpltKE4UCQCgpPaU98HkXyNOJG0G72A5wEyN
MZ0AnjAEczZ8vh35NP+Bcdqqq7rV6li4
=tVIF
-----END PGP SIGNATURE-----

--Sig_/I45k624GltXszyhqhZ8h38L--

--===============8985732698481089133==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8985732698481089133==--
