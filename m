From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/3] ASoC: codecs: adau1701: allow
 configuration of PLL mode pins
Date: Fri, 21 Jun 2013 16:00:19 +0100
Message-ID: <20130621150019.GZ27646@sirena.org.uk>
References: <1371801284-31603-1-git-send-email-zonque@gmail.com>
 <1371801284-31603-2-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0208420929902254148=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id D7E692615F2
 for <alsa-devel@alsa-project.org>; Fri, 21 Jun 2013 17:00:21 +0200 (CEST)
In-Reply-To: <1371801284-31603-2-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de
List-Id: alsa-devel@alsa-project.org


--===============0208420929902254148==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="abYdCjSRCBwcb+dP"
Content-Disposition: inline


--abYdCjSRCBwcb+dP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 21, 2013 at 09:54:42AM +0200, Daniel Mack wrote:

> To avoid excessive reset cycles and firmware downloads, the default
> clock divider can be specified in DT as well. Whenever a ratio change is
> detected in the hw_params callback, the PLL mode lines are updates and a
> full reset cycle is issued.

Why isn't it enough to just use the first setting we see - I'd expect
the device to normally be powered off before audio starts including when
hw_params() is called?

--abYdCjSRCBwcb+dP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRxGqAAAoJELSic+t+oim9Z94P/3GD4Qq1rFAz6EB+zmC7ilTw
vC0RU8ifY2vyqzsUzFMa/94LPb7r42vnjGN9hJEZswCyAGfhIxeOwt0AcOd5Ruav
u5vqoW7IuC43o12Ds1hhDdAIDpccjMiYG1cEuUP9BSuOvEfrxTHtGjisy7hSbJ79
wwK1ogs0rk6Lnwdbu9F+cJrHfJsekvfyblp30mgKaoDhCkHvCmgViL9UV3tITb2r
CBUiqN+y/1e37q6plNrHLyy9pM8wT4VKNEyT+XollgpIfK8por8GOxjD+JjQQPCW
PVZFQ/f1Sq+UoNhmI3i42eF7mAH5YQSSPUC8W3o3DgE53Phu6ULmAcc9Tym9Qm7L
ftltFwQWS8leBsfnbySGvlSVjtKFMZei0sAAESbkKLPSkdvtsZ2PNNB73e7IXC4q
56m9XKVxynKo3OuTYmArYh+hnkpiOP2+inGsATbZgFmSLYz0tuPOWhHpBaC1kZmi
rNo92NMMbXVv7weoZoObTUX3QbCWPJeFxCHVrUlqWDgcnZhDnPpRBd6Yl5Sp6H58
eL7O50JdyDFzsJyvUrQTZGWfPutSE9S0g8gtCW56CjhqB3IpDBwVEAN2fElLmtb2
OM6LxuBHxLjpu4S8HPh+gGIFMY4Z60GUfDzaNZye8Mmikj4pHTabAcK+OjRO1QNN
vp1BFkXQ5Re0d9KVJ3KL
=Expf
-----END PGP SIGNATURE-----

--abYdCjSRCBwcb+dP--

--===============0208420929902254148==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0208420929902254148==--
