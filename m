From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/7] ASoC: sti audio fixes and legacy
	cleaning
Date: Wed, 26 Oct 2016 11:40:24 +0100
Message-ID: <20161026104024.GB17252@sirena.org.uk>
References: <1477320177-30130-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0712525042518034297=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A351266875
 for <alsa-devel@alsa-project.org>; Wed, 26 Oct 2016 12:40:33 +0200 (CEST)
In-Reply-To: <1477320177-30130-1-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Moise Gergaud <moise.gergaud@st.com>, kernel@stlinux.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0712525042518034297==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1ozVqH6bFr/3sC51"
Content-Disposition: inline


--1ozVqH6bFr/3sC51
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 24, 2016 at 04:42:50PM +0200, Arnaud Pouliquen wrote:
> Audio fixes and cleaning of code associated to stih416 platform.

Please don't mix fixes and cleanups like this, bug fixes ought to get
sent to Linus so they get into the first release they can while cleanups
can wait for the next merge window so you should make sure that any
fixes come at the start of the series in order to ensure that there are
no dependencies on the cleanups.

--1ozVqH6bFr/3sC51
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYEIgWAAoJECTWi3JdVIfQ4RoH/0CKyGZOiU442vpdsNm/AS81
rbbCYPemxdGonzU0g/pwNZW0Q/bA7HM+IDyqCz5xlUb5jnw1xRLJPytOvzP7+/+E
vXBhs9vz5u9SPYNgkTt3ZQhNffdfS+mRW9nhW4nFBehtOYJJ7lRIhEuRxu/E7yOW
+V1DowQxp+0bwaIaihDZmYLCxt893tIli2ByVLIJiTLRVG3Hnieur1SrMnUH4E/I
DOmtYN0QCcwzFjGw5VdzIwDB7nS5bTK3q9MUcLtPj0AEUBauYMpBFMzuEu1CFXHu
lUIW8X41JgqSB5UEjaJV8WWq5/RdD/d6SbxLS0bWM0U3uvz0uq6PMD/Bz3KThDE=
=fMB6
-----END PGP SIGNATURE-----

--1ozVqH6bFr/3sC51--

--===============0712525042518034297==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0712525042518034297==--
