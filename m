From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: sgtl5000: prevent playback to be
 muted when terminating concurrent capture
Date: Thu, 1 Aug 2013 15:00:08 +0100
Message-ID: <20130801140008.GU9858@sirena.org.uk>
References: <1375281871-28128-1-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8322567643695893797=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 6243D26084D
 for <alsa-devel@alsa-project.org>; Thu,  1 Aug 2013 16:00:15 +0200 (CEST)
In-Reply-To: <1375281871-28128-1-git-send-email-LW@KARO-electronics.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8322567643695893797==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OphFy9MbTBDis8FT"
Content-Disposition: inline


--OphFy9MbTBDis8FT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2013 at 04:44:29PM +0200, Lothar Wa=DFmann wrote:
> When a sound capture/playback is terminated while a playback/capture
> is running, power_vag_event() will clear SGTL5000_CHIP_ANA_POWER in
> the SND_SOC_DAPM_PRE_PMD event, thus muting the respective other
> channel.

Applied, thanks.

--OphFy9MbTBDis8FT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR+mnlAAoJELSic+t+oim9wOoQAJCNRAxDrZY3tL4gczNnKb6W
E9qYOs6/eJdlNN0T6Gj4/xRUwqnhG0SLjLb4ovNMMPoTKjmo99KLREhurpPZCDWE
TDv/F2BKcV69fRroiP/sNimPxOB+recGG0iLS8Pu/kHr6+SFztJeTqmwh9WkMwyf
TZWWPH0E9UEkqU29596LyJPN6Bp4kRln+aD8tbatv8HclQ53ySbS8mMd4miq2nIQ
DE4k8Xt33uD777VjCzC8BxOA0cOUuZ40aviIgOZi0S5ga+rXjW5Tb/AaNRCCKTuc
Tdc2P4CyqSka32c7X2BF+j5IU59u0lkfz2F4wF7gmwahAPEI8F8sHLFJQ4wPBPYK
j9jld49UJhyxGHdqTYlgflmwj/cVmUA3tkQY2dRXv+MhRa44j2/cauqlXoo9tvfG
/1NS6YS5s4X+3KfK65cjXI1GKzgyL+LL5DV0yv3ri1rylVRumoWHhemISqa7S0O1
s9daTH4zCpCKEC2+5mfQSOYbry5ckBSLevUULCqx52tvKyUWTAygpmd5r0n/a9/X
Wu3FXCtGbl6GUFqZeo3je+c2kbDpCXBMh7fC+C+/ROet96YCkdWTb3BOTyLjyq+a
RMiN4oAhx68/YZV3s0PebYx+EATJsWlTrwCYF5+1qcptzOY2ufq5YCc6i4KARsEZ
bcDqV8hDbBAzuBgHNsIS
=zKYl
-----END PGP SIGNATURE-----

--OphFy9MbTBDis8FT--

--===============8322567643695893797==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8322567643695893797==--
