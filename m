From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt286: set idle_bias_off to false
Date: Thu, 29 Jan 2015 10:51:43 +0000
Message-ID: <20150129105143.GT21293@sirena.org.uk>
References: <1422435597-19330-1-git-send-email-bardliao@realtek.com>
 <20150128113537.GU21293@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D70104CDC3@RTITMBSV03.realtek.com.tw>
 <20150128200951.GS21293@sirena.org.uk>
 <E7B1D079BA13FB44A978CC8F69C7D6A901BA81DE@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1812767394343463387=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A3C49260309
 for <alsa-devel@alsa-project.org>; Thu, 29 Jan 2015 11:51:54 +0100 (CET)
In-Reply-To: <E7B1D079BA13FB44A978CC8F69C7D6A901BA81DE@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Jie, Yang" <yang.jie@intel.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============1812767394343463387==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RwegFtB+Og0gu+KK"
Content-Disposition: inline


--RwegFtB+Og0gu+KK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2015 at 09:07:08AM +0000, Jie, Yang wrote:

Please fix your mailer to word wrap within paragraphs, your mails are
very hard to read.

> > If jack detection should be disabled over suspend the machine driver sh=
ould do
> > that (eg, by setting a NULL jack).  It's actually common for systems to=
 leave
> > jack detection up over suspend as in systems like phones the jack can b=
e a wake

> [Keyon] as my understanding, setting idle_bias_off to false won't disable=
 jack detection
> over suspend, only the action that poweroff the codec will disable it, Ba=
rd, is it correct?

Right, you've got it the wrong way round - the goal is turn off the
widgets that are holding the device on.

> setting idle_bias_off to false is the easiest solution for us, it is also=
 reasonable here,
> because rt286 don't need soc core to set BIAS OFF specially when in idle =
status, (BIAS_OFF=20
> and BIAS_STANDBY are same for it), and seems no side effect here.

Currently.  And to be honest I would have expected that the behaviour
would be the same with widgets on regardless of the bias level so we
probably want to fix that which would cause the same problem resurface
even if it were bodged around for now.

--RwegFtB+Og0gu+KK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUyhC+AAoJECTWi3JdVIfQSwkH/A232fuhb90VcspkEyqMihtX
I/bThxVlqQswMFeekxBbaBF1FDRaS6gW3MbePsk+2g2Z00l32Y5/NnDPT7raAgjh
GTO2C2lC2L1cu+h1qilxPDiejYjtVgf6q9nIFs4JN9IU7kUHpAyJJDgnR5IKWlHF
sucO6RYnl1w+vSKWbwXE51AFMiJOB5Olt24sin+LIhwPG/8AuQTYB05BtMQbwEDk
0vBR4XQaj1eauuHxSWgFo7J2hjLkByC/yrh7JHpcDaX6FZ10/vKGwAVzq3Dzsa6a
zp3e1piLhhXL3VLxEuiYGYme6l7NOFE1SkP1ClwQK7lNIEROnrCMVLEiG3c4qRs=
=U5PC
-----END PGP SIGNATURE-----

--RwegFtB+Og0gu+KK--

--===============1812767394343463387==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1812767394343463387==--
