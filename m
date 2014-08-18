From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V1 2/3] ASoC: fsl-asoc-card: Fix build warning for
 maybe-uninitialized
Date: Mon, 18 Aug 2014 09:53:25 -0500
Message-ID: <20140818145325.GC14537@sirena.org.uk>
References: <cover.1408350626.git.shengjiu.wang@freescale.com>
 <b1711ff2c73f3b6acd6af000bc8294d930bbf16b.1408350626.git.shengjiu.wang@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5778138552977589427=="
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <b1711ff2c73f3b6acd6af000bc8294d930bbf16b.1408350626.git.shengjiu.wang@freescale.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Shengjiu Wang <shengjiu.wang@freescale.com>
Cc: fabio.estevam@freescale.com, sfr@canb.auug.org.au, alsa-devel@alsa-project.org, timur@tabi.org, arnd@arndb.de, shc_work@mail.ru, tiwai@suse.de, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, perex@perex.cz, nicoleotsuka@gmail.com, Li.Xiubo@freescale.com, xobs@kosagi.com, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org


--===============5778138552977589427==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="j6zkAHxOZJkiczrA"
Content-Disposition: inline


--j6zkAHxOZJkiczrA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 18, 2014 at 04:38:39PM +0800, Shengjiu Wang wrote:
> When build fsl-asoc-card as module, there is following error:

Applied, thanks.

--j6zkAHxOZJkiczrA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT8hNiAAoJELSic+t+oim9vtEP/066v1JvRkbibj+F5sRs0ldE
p/hv3zajZVFM24ZRpA3ougXhZ+BC+L9a8X/dt0joWHuEwwEL187RxuHGdEDaUddC
mMpu8SmfaIJ77GimPIKs0Xl2NQsMgm4ZblzN/jgNSTJt9Z1ZWy/b3YysujpDHPHR
jgemxvDRwE55C5WkKLDgZMqjGWB24xgy5v8n4wOqK9eJ1uxjjEjBwMlun5I/5bqS
RoM2XQXxY2N+SjAh83hVyd+EUg+T6TwvNAzKtp4YigRD0wgZmuuIyw8xN2cc7NDO
/M2QIye95ewb2OaNrItkf8FCP+CNVbXLxoXeNBVuxSREmRt6SNPCWySBOm8cjwRZ
1lpHYWUp3EnbA15xjRXBB4jVi7wzdrJO5WLzFa/s0INbUsKVeuF9slC5AjFG0rjs
Kz+c2i0iPxxDWJ1Cc2mEfuFKsAY2R9RoQe/FRqkvZqvvWJ9vGh2wEE/fo78+pO+p
lyK3T9DixQB1Tv2R8wYf74oF/sG/s1fcrbhaRFqap3UdMVLHtsyUeA/2mP6XgSYv
dIgXpIRXBYfXZbkzHewhT8avRadehuZpDQxHoOE7GYI/LOCzORjNeLmw4DY/pHIR
AQTfNxKbNAHq+kbe7HBs5KggpCIxtwneuD3ndIVEq4TxXwdUFktLG2ij/JFDGQ7b
vU4LUyGW+7dpC8ZUTGmE
=VtEb
-----END PGP SIGNATURE-----

--j6zkAHxOZJkiczrA--

--===============5778138552977589427==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXhwcGMt
ZGV2IG1haWxpbmcgbGlzdApMaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZwpodHRwczovL2xp
c3RzLm96bGFicy5vcmcvbGlzdGluZm8vbGludXhwcGMtZGV2

--===============5778138552977589427==--
