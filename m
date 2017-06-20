From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: add bindings for ZTE zx-aud96p22
	audio codec
Date: Tue, 20 Jun 2017 15:33:52 +0100
Message-ID: <20170620143352.rjitvgkzh554pviq@sirena.org.uk>
References: <1497708574-22380-1-git-send-email-shawnguo@kernel.org>
 <1497708574-22380-2-git-send-email-shawnguo@kernel.org>
 <20170619161606.g6nabi2w5mmmjbcw@sirena.org.uk>
 <20170620031131.GB4818@x250>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7201656197072770159=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1BE1C26680F
 for <alsa-devel@alsa-project.org>; Tue, 20 Jun 2017 16:34:04 +0200 (CEST)
In-Reply-To: <20170620031131.GB4818@x250>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawnguo@kernel.org>
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, Baoyou Xie <xie.baoyou@sanechips.com.cn>, Xin Zhou <zhou.xin8@sanechips.com.cn>, Jun Nie <jun.nie@linaro.org>, Baoyou Xie <baoyou.xie@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============7201656197072770159==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aqxogg4zeqysad2y"
Content-Disposition: inline


--aqxogg4zeqysad2y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 20, 2017 at 11:11:32AM +0800, Shawn Guo wrote:
> On Mon, Jun 19, 2017 at 05:16:06PM +0100, Mark Brown wrote:

> > If there's an external power amplifier this is a separate chip to this
> > CODEC and should therefore be separately controlled and integrated as
> > part of the machine integration.

> Yes, that should be the best.  But we do not have a particular machine
> driver for our platform, and we are using simple-audio-card driver

You should be switching to the of-graph card now.

> instead.  I'm not sure if it's generic enough to patch simple-audio-card
> driver support this pa-gpios, so chose to fold this quick change in the
> codec driver.

Having a separate amplifier is a completely normal thing, and no matter
how unusual something is it's obviously not OK to hack one driver to
support a completely different device.

> Should I patch simple-audio-card driver to support pa-gpios property
> and create a DAPM widget with event for it?  I'm currently using
> SND_SOC_DAPM_OUT_DRV_E.  Is it the correct one?

Should be fine.

--aqxogg4zeqysad2y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllJMk8ACgkQJNaLcl1U
h9CJpQf+KCDltzzG9GlJNBhvNFRPXqRG3VLBnj4kYTB7Lby7ZEojhzU+dHoEXTU/
KUi7WkXO9o8sfOE2+OCiCIbxCgZegMPeHcNmPK+7k+6o91YIAZFvAoTeglzNL3eq
WEhYXsvLu0Mhefaz90yOwKzLTzhGb9+p5Z7/a2iszzP4M7DzPcfmWBZ1Mc6DfnaH
37eIzOTTcce/h6gqE8w8nnPQWRXlbRfHMOwseaAP2yQwDV4AtluDPxiv6UsYHZKt
DVBbn6ddut7DK32kE/GA+U2WdaBWV476as/TAUZIUBklLOYF8MqCLd1auzyQbjDv
IS+mC3qu73qkehs0vRAbFMQuP7Tqlw==
=bHfy
-----END PGP SIGNATURE-----

--aqxogg4zeqysad2y--

--===============7201656197072770159==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7201656197072770159==--
