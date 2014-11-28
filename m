From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: Intel: Move capture PCM pin to
 PCM0 for Broadwell/Haswell
Date: Fri, 28 Nov 2014 15:35:19 +0000
Message-ID: <20141128153519.GV7712@sirena.org.uk>
References: <1417182731-26576-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2398608166769664722=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A1E26260489
 for <alsa-devel@alsa-project.org>; Fri, 28 Nov 2014 16:35:36 +0100 (CET)
In-Reply-To: <1417182731-26576-1-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jie Yang <yang.jie@intel.com>
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============2398608166769664722==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WgMw66UcpYoL/xvb"
Content-Disposition: inline


--WgMw66UcpYoL/xvb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 28, 2014 at 09:52:11PM +0800, Jie Yang wrote:
> Move capture PCM pin from PCM4 to PCM0 for Broadwell/Haswell.
> This will allow us to integrate with pulseaudio better for
> usually default device is set to 0.

Applied, thanks.

--WgMw66UcpYoL/xvb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUeJY2AAoJECTWi3JdVIfQ1FQH/1hDCE6KdXFEuXevPzDsyJTz
NbjQPCNuijwIEYesg0dKIfrHei7/i+mNCIkc49Xs+cYDSCh7JUBpmoUttX/ST/xX
waz4qjEJ8draoPa7RJi9IbljSYBQml7x0ExtxOoszaQFLNlS4G07MRzryxKRjFf1
b/Yvuh8YpFdKRHIhWL9k0WJhht8J7dp5+3W0KgQviUv1isFCkQwbdmEahi3Mppvs
GXJ0w2nSbZJ4v8Lrg711SAQ5Jc8p81g1jYYy0ROztu/SILiKqZsxtgvjPeCXIUNB
UUpcW3RuFlW7ZFbbQukIVJxZTSvowrPijvObz7xQWTeEVYgNWRItPolhA+VZtiA=
=5chn
-----END PGP SIGNATURE-----

--WgMw66UcpYoL/xvb--

--===============2398608166769664722==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2398608166769664722==--
