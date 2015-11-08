From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: codecs: Add da7218 codec driver
Date: Sun, 8 Nov 2015 10:34:29 +0000
Message-ID: <20151108103429.GC6746@sirena.org.uk>
References: <cover.1446718490.git.Adam.Thomson.Opensource@diasemi.com>
 <01a9b6e96b66327cf9a27781c13aa50545380acb.1446718490.git.Adam.Thomson.Opensource@diasemi.com>
 <20151105152736.GO18409@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A0337D460CA0C@SW-EX-MBX01.diasemi.com>
 <20151106112141.GE18409@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A0337D460CA3D@SW-EX-MBX01.diasemi.com>
 <20151106115451.GG18409@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A0337D460CAAD@SW-EX-MBX01.diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8977449709614741361=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CC42926057D
 for <alsa-devel@alsa-project.org>; Sun,  8 Nov 2015 11:34:52 +0100 (CET)
In-Reply-To: <2E89032DDAA8B9408CB92943514A0337D460CAAD@SW-EX-MBX01.diasemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Support Opensource <Support.Opensource@diasemi.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>
List-Id: alsa-devel@alsa-project.org


--===============8977449709614741361==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uh9ZiVrAOUUm9fzH"
Content-Disposition: inline


--uh9ZiVrAOUUm9fzH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 06, 2015 at 01:17:28PM +0000, Opensource [Adam Thomson] wrote:
> On November 6, 2015 11:55, Mark Brown wrote:

> > Hang on, is this just recording a DC value with the ADC and then looking
> > at that?

> The RMS of the Mic signal is taken and compared to the trigger level set. If
> it's above that level then an IRQ is raised.

What I'm trying to figure out here is if this depends on the audio
routing at runtime or if it's got dedicated configuration?

--uh9ZiVrAOUUm9fzH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWPyUwAAoJECTWi3JdVIfQb9kH/ipPW2j++eQyrNPfpnHOAi02
6/zcATTcTnz0/VSobABkMVoTfRQi2h8kyaBzwmkUpLBWfziKhO7kBgQohtWKwFf9
MFLRodtTdEV6mJ8b3ESxli92/IgB5dN7qvwrfYM53R75aADrtgd/EHBEgUV1HwhD
q1ke3WH+ZQLF+f58KuGuJQl+odbbW3e/F2iJsBh1in0CZ1fypbBHwG1cOBc9aouq
SndanIRfCEk3ZeRih53E+cecbSaJocpwc99kuqtHR8vPZeEId+21mQqIfRfX9YKX
kNR0wnBOonow7WF+E5f7MuV9nPre3gWqBG3/mnIXtAowpYsr0K+DphC7RX0oH2M=
=aeQJ
-----END PGP SIGNATURE-----

--uh9ZiVrAOUUm9fzH--

--===============8977449709614741361==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8977449709614741361==--
