From: Mark Brown <broonie@kernel.org>
Subject: Re: ASoC: codec: SPDIF only works with Tx/Rx seperate
	codec drivers?
Date: Fri, 12 Jul 2013 15:29:50 +0100
Message-ID: <20130712142950.GI24508@sirena.org.uk>
References: <20130712083030.GA28555@MrMyself>
 <20130712113353.GC24508@sirena.org.uk>
 <20130712115712.GG28915@MrMyself>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0743735640039748256=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 9448A265A16
 for <alsa-devel@alsa-project.org>; Fri, 12 Jul 2013 16:29:53 +0200 (CEST)
In-Reply-To: <20130712115712.GG28915@MrMyself>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0743735640039748256==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3iqGNvuhWAyawlAA"
Content-Disposition: inline


--3iqGNvuhWAyawlAA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 12, 2013 at 07:57:13PM +0800, Nicolin Chen wrote:
> On Fri, Jul 12, 2013 at 12:33:53PM +0100, Mark Brown wrote:
> > We could just merge them into a single driver easily enough.

> Merge spdif_receiver.c and spdif_transmitter.c?
> But each of them is being individually used by several drivers:
> davinci/davinci-evm.c
> samsung/smdk_spdif.c
> spear/spdif_in.c
> spear/spdif_out.c

> If we merge these two files, it would break their functions.
> Especially for spear's platform, seems they are using SPDIF
> IN and OUT separately.

Why would it break them?  You can always instantiate two copies.

--3iqGNvuhWAyawlAA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR4BLbAAoJELSic+t+oim9HmIP/iifCNY6dnFiGiiEqMAtaa20
hYLPIVxXLo2okwwHaSQsW95KBBRKVHa9qjo5YFR3/iNXjibOl34RvjKdtDE6vo3M
TsanT1/M0rIPNrbxj27yvhp508rm86lI2K0MQZKwPZDtjgzN28LkC7DzcTByprt5
L4EsIZ7/LHOyvO5Gac/0bQcgs2mnMCFyIZ8VhC6kQcCWFf3DhDVma1UmXIij4101
TY1G7NZkGfm8p5+hMpPo6iXaHdAv5x/Fn0aCBcDJ59sxPVuqXu+P4hd1BKM1IAzH
r1tIiuRhxNt2TkpVqnzu5wgfhfMwErNXii0lTrvF1ZdzdCUin0aLQ+nNMSpS49rc
rL+RJg4ep4A0+6hYpgNh0YfWv+oISe5LrpsXyui3AF0nrtIrfzxEd6bBhDO5XbSQ
PqVV0JybJC5bpJE+v5uBoD2sqk8sEee6w+3hjTz3oz4juVgGyJBgzTGD4zfSOTtj
Z/hvDSeBBTQOGacPo67uHTIkSYB8XVoN93gUl5q22ShHh6Ei5ArXvGY3J3gmaZDj
XrH0BFtMHYyyaabznIfSsRzSIMHkWxIa5PjGnku+Xt/k6pgtIFG9/GcZwrdRBMVG
9tO8tekJ+NIgBSvkebJv2DNLeiyc2emPSCNO1X2SzzUpj/wrtaS0BkO6nKHH1GjW
MZGzfIZDb8nJ3lACBWm5
=+BEc
-----END PGP SIGNATURE-----

--3iqGNvuhWAyawlAA--

--===============0743735640039748256==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0743735640039748256==--
