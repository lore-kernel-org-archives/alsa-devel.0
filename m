From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: rt286: fix headphone click/crack
 noise on Dell XPS 9343 I2S mode
Date: Fri, 17 Mar 2017 13:04:44 +0000
Message-ID: <20170317130444.jw5ahc2hmgdoacpk@sirena.org.uk>
References: <20170316083951.11247-1-kai.heng.feng@canonical.com>
 <20170316140946.kikw2rjinafu6qo5@sirena.org.uk>
 <CAAd53p6rqb9EFfFMC8EgYXdr86NLTD7BYRbwMM_xvUgUQFwKSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9190776379854033989=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 85F502666C5
 for <alsa-devel@alsa-project.org>; Fri, 17 Mar 2017 14:04:55 +0100 (CET)
In-Reply-To: <CAAd53p6rqb9EFfFMC8EgYXdr86NLTD7BYRbwMM_xvUgUQFwKSg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: oder_chiou@realtek.com, bardliao@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============9190776379854033989==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rpn6753kn5gvww2j"
Content-Disposition: inline


--rpn6753kn5gvww2j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 17, 2017 at 02:41:04AM +0000, Kai-Heng Feng wrote:
> On Thu, Mar 16, 2017 at 10:09 PM Mark Brown <broonie@kernel.org> wrote:

> > > +     rt286->is_dell_dino = dmi_check_system(dmi_dell_dino) ? true :
> > false;

> > Just directly assign the boolean value, the ternery operator is just
> > making thins harder to read here.

> Should I make the int implicitly convert to bool or use '!!' operator?

Use implicit conversion like you're already doing - the above already
evaluates the function as a boolean in order to use it in the ternery
operator.

--rpn6753kn5gvww2j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljL3usACgkQJNaLcl1U
h9BFUAf/bcvG96CxplzNEcgDRa9irh/1Jat70yasQeYEWZ/oPWd7voviVNtWjCB0
oA9Lgd4tVhbk6UgJS6Ge/DH2sEIceT4b1/bacFWHaAARoaM1iF2V2NEtZ9fHhFSA
bHnwKzuW0LPPK1vqu2OdIccnzy09gBpUPFMDSXQvsmBHnRY9Ad+Q23NrZTWeu4s7
uhZAliTqk/BETorPMe41ijhtIVu5lsntn7wG8tO7Dp0tmlK/l2n+EMA5uKq6FHP2
wXvYWk8jVWwsS2tnrLgxXjltXU/DnwftSLmSdWpUQU6h2Nal8q8PS8Z6zjvVte9V
lE4WyakwBHbLjDFBydHSPLOj0ttZ9g==
=pvI2
-----END PGP SIGNATURE-----

--rpn6753kn5gvww2j--

--===============9190776379854033989==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9190776379854033989==--
