From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt286: set idle_bias_off to false
Date: Wed, 28 Jan 2015 20:09:51 +0000
Message-ID: <20150128200951.GS21293@sirena.org.uk>
References: <1422435597-19330-1-git-send-email-bardliao@realtek.com>
 <20150128113537.GU21293@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D70104CDC3@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2784750616644850644=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 42EF726150C
 for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2015 21:10:00 +0100 (CET)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D70104CDC3@RTITMBSV03.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============2784750616644850644==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eFc1cLy+KHTnhpog"
Content-Disposition: inline


--eFc1cLy+KHTnhpog
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 28, 2015 at 12:45:13PM +0000, Bard Liao wrote:

> > > -	.idle_bias_off = true,
> > > +	.idle_bias_off = false,

> > There is no need to set false explicitly, it's the default.  It also seems
> > better to keep the flag if it's true, even if we don't actively do anything at
> > the minute we may in future (either in the framework or in the driver) so
> > the information seems useful.

> Actually, we meet an issue. We use force enable in rt286_jack_detect. If

So, this is one of the reasons why people ask for good, clear
changelogs...

> a headset is inserted, the bias_level will not be OFF due to some widgets
> are ON. If idle_bias_off is true, rt286_suspend will not be invoked in
> suspend. And I "guess" rt286's power will be cut off in suspend. That's
> what we handle in rt286_suspend/resume functions. If rt286 's power is
> cut off and don't re-sync the cache, it will cause some unexpected issues.

> Is there any good way to fix such issues?

If jack detection should be disabled over suspend the machine driver
should do that (eg, by setting a NULL jack).  It's actually common for
systems to leave jack detection up over suspend as in systems like
phones the jack can be a wake source, the hook switch is commonly
expected to always be operational.

--eFc1cLy+KHTnhpog
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUyUIOAAoJECTWi3JdVIfQRxQH/3YzcrILR57O+N+Iq7mYaaQR
vn+yGQmMUZC1DzREnvvrtfsft62AmBWScJpNmtHfPGCkoMR/QgGWx6BWD4vASw2b
pD39WWl0U2jaI4xTv03KjcpA9R7Nv15+n35jMG4HuGADMr6BANdOhm8UJGBxn4Au
8V6KhacOXaXAKK4OUgBCavlC0XzzKsMKyKYevnkaWzDVvLe1O5UkRAijTGqA/3G6
+O6pYtXHKUG2xMPLD+mGCECvJ5H1CmkKpbV2/9jTSQqcZ5rg39yRqG5hkl6O6/2m
Mkkycxs4jaGSVFtQQ3FKiCc1vhw7Aq8nSpm5P4fgZ3qsl67PMqEoMnfvhFktxPA=
=M9fK
-----END PGP SIGNATURE-----

--eFc1cLy+KHTnhpog--

--===============2784750616644850644==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2784750616644850644==--
