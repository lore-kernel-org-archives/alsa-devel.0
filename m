From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: tegra: Add platform driver for
	rt5677 audio codec
Date: Thu, 16 Oct 2014 09:38:46 +0200
Message-ID: <20141016073846.GA724@sirena.org.uk>
References: <1413407742-19112-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1455791318577526655=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E785726071F
 for <alsa-devel@alsa-project.org>; Thu, 16 Oct 2014 09:39:29 +0200 (CEST)
In-Reply-To: <1413407742-19112-1-git-send-email-anatol.pomozov@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anatol Pomozov <anatol.pomozov@gmail.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, swarren@nvidia.com, Anatol Pomozov <anatol@google.com>, bardliao@realtek.com, ldahan@nvidia.com, dgreid@google.com
List-Id: alsa-devel@alsa-project.org


--===============1455791318577526655==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 15, 2014 at 02:15:42PM -0700, Anatol Pomozov wrote:

> +Required properties:
> +- nvidia,speaker-codec: The phandle of the board specific speaker amplifier.
> +  This binding assumes that AIF2 on the audio CODEC is connected to this
> +  amplifier.

To repeat my comment on the previous version:

| This isn't as generic as all that, it relies on the specific speaker
| driver.  I'd suggest either just saying it's board specific or making
| the speaker CODEC optional.

Please don't ignore review comments.

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUP3YFAAoJECTWi3JdVIfQYxgIAIcOkbDBt1nnN0xiCHw+GlQb
Onm11RvK/Fie2+A4nuDS20bbsyV6UX0E/CuikLy6IXTOfzjN+6lw4JRBmxAyHeOj
m+afIy7H8O5I/aUWnZgRTnfNWXjqMFj8wf5sGrRKoUbFIsdatkocHS258GDlz0Jy
DQKZIL/3cfx5HOjfrEay4On6JTcbbC8B01F/mKYMypVBQGXl7P56U10qjwNPly8s
lCmHioXyZzLFlIp1lAH64nPaHT/LQK0OTOyRGg8PwAoIq3vxSplN6T2yXBK/Mp7C
xD29xd72GBX9YjJAMA5k3nz3LgI8nul5dGtQhaes41ZrpSfACsJHzVjFGfzZ9IQ=
=yo2g
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--

--===============1455791318577526655==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1455791318577526655==--
