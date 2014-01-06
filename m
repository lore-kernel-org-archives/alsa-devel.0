From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/5] ASoC: mc13783: Drop fixed ADC & DAC
	ports usage
Date: Mon, 6 Jan 2014 15:38:38 +0000
Message-ID: <20140106153838.GC31886@sirena.org.uk>
References: <1388907515-18975-1-git-send-email-shc_work@mail.ru>
 <1388907515-18975-3-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7247707501640995280=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 865FA2610B7
 for <alsa-devel@alsa-project.org>; Mon,  6 Jan 2014 16:38:43 +0100 (CET)
In-Reply-To: <1388907515-18975-3-git-send-email-shc_work@mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7247707501640995280==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XpuVCDtr9qESfzcl"
Content-Disposition: inline


--XpuVCDtr9qESfzcl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 05, 2014 at 11:38:33AM +0400, Alexander Shiyan wrote:
> There are no users of this driver without pdata, so stop using
> constant assignment of ADC and DAC ports.

Applied, thanks.

--XpuVCDtr9qESfzcl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSys37AAoJELSic+t+oim9gagP/1BE8G5nc24MPKZx4eX54oWR
hIzhcMH/c2qS8Yj7c4GblQnbgG7SSsitqmY/oj3CJ9pA610E8b3DmpsNd2SVDN1t
ZtnEt3fYVpynip9IhObfRdR9Eu4dXR88dAvbGnzg7Da8f18giSlrakwoFRqpNvyE
CS6Lm+mtc4z2V+ZZ/vIB+d6bV9tzwg62bhuKkZ0K3uym/BNHVKAfd44tudVchCuR
y6GpgPWf56sOZuREOTa7vKRMq2jRvXDaGJPhFIzK7iJti5moL+KoAk25J5sMnZcb
MLoBLGVeq3OugnVVqO94iNr3xzHPpfczzkV+1OTNCx/M4pKkaJw8aPO6TIPTzpE0
JlIJHktESZpDXBoC+T6SxEEguOoxua7YbsDDfj+OGBDVS61wn056SWU9Vg2xVJq+
sb12skTAecZgSUN2uFLPUSb1uQj91hnXwUIuHvkM9eofMM6Vzyd28fNBpVzGiNY+
rVM33abh26sbbeG3/f6LMAZat9tegwTS1bWGUGcRfWyNfIv4eFBlTxd/mbkjrTRK
ahSBrY66UCe9ob/cs+zGHYS6gl7XgBRoxfAc7sxX2Byzh4Z/whPhrv8lfUw3k7iz
5AhZ/EOIOGeLOgBrRzPOH1/b+oV1dQONT4DGdzJyvMY6FXGRvsIqa15mzwxEXl4i
lR51xoGZDj1piuY1fTOF
=FPsy
-----END PGP SIGNATURE-----

--XpuVCDtr9qESfzcl--

--===============7247707501640995280==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7247707501640995280==--
