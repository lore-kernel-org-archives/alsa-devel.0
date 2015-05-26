From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: atmel: compile pcm driver in
 snd-soc-atmel_ssc_dai
Date: Tue, 26 May 2015 10:53:33 +0100
Message-ID: <20150526095333.GK21577@sirena.org.uk>
References: <1432591459-22613-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1432591459-22613-2-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3119059537552758506=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E9E0526262D
 for <alsa-devel@alsa-project.org>; Tue, 26 May 2015 11:53:40 +0200 (CEST)
In-Reply-To: <1432591459-22613-2-git-send-email-alexandre.belloni@free-electrons.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: alsa-devel@alsa-project.org, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============3119059537552758506==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fS/HbthCZKMwXfkc"
Content-Disposition: inline


--fS/HbthCZKMwXfkc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 26, 2015 at 12:04:19AM +0200, Alexandre Belloni wrote:
> It is currently possible to have CONFIG_SND_ATMEL_SOC_SSC=y with either
> CONFIG_SND_ATMEL_SOC_PDC=m or CONFIG_SND_ATMEL_SOC_DMA=m. This results in a
> driver that compiles but does not link with this kind of error:

Applied, thanks.

--fS/HbthCZKMwXfkc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVZEKcAAoJECTWi3JdVIfQOE8H/3jy6rwXomydprvZrJNREpdU
jVCT3zSf2WdN2ghLJW+8TwxnayzplummN4mLi33JJMC2ceQ5eBfzvs5Rvcvhjekc
3ABszNicq3HsR4RvVR+mTq2ARQkRgQyJb9W17hqiAZ1b1+fa6/iWJoDihaoNXOQY
W3+uXBUIglEWGIHc7Msdv3B4nnO5g9SMraaFY93FfG/VjWh/ucDGSZCaIyPG8hoT
WELX+vh+WY+trBDn0aOLjRbm0Z1m2fZQoTbKK5cI24I0n9NNqhvkFXSDc2Dv2Ihw
FlGw92kc3XaSOcUiUoqOKWseLrV6insz3MqB/jTuxpdxAgQIyUib8ADMWqD1a7E=
=JHfB
-----END PGP SIGNATURE-----

--fS/HbthCZKMwXfkc--

--===============3119059537552758506==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3119059537552758506==--
