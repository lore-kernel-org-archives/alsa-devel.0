From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: cs42l52: Fix mask bits for
	SOC_VALUE_ENUM_SINGLE
Date: Tue, 18 Mar 2014 19:45:01 +0000
Message-ID: <20140318194501.GP11706@sirena.org.uk>
References: <1395169307-2048-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1234987608512285604=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AB2B5261685
 for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2014 20:45:07 +0100 (CET)
In-Reply-To: <1395169307-2048-1-git-send-email-brian.austin@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com, paul.handrigan@cirrus.com
List-Id: alsa-devel@alsa-project.org


--===============1234987608512285604==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lak8Uquzb3CMtnm+"
Content-Disposition: inline


--lak8Uquzb3CMtnm+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 18, 2014 at 02:01:47PM -0500, Brian Austin wrote:
> The mask bits values were wrong for the SOC_VALUE_ENUM_SINGLE for the PCM/ADC Swap controls

Applied, thanks.

--lak8Uquzb3CMtnm+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTKKI6AAoJELSic+t+oim9XIYP/RvpY2q6MXxC6wBlA4BPryLF
l6bMHoREKGf8y3OarbUJaSaBr44liAPdQRgq4s+f8pDGHHxNUVwmSmF2a7mB1uNJ
1cgToq0/pjotqOZ0PZX1H+A4dFEXgfCNcgALuvGCiDD7S3N5YeLnxQ+kkXyXNraZ
zBzaPk2Ml9Ue0eY+IiPCJ5/Y8Rjh87bN06ZyAcZcEKTriQKGuuy/qpEqgokFaOu6
AYGLw3QHZuNJiBHeoAERb8+95fa29y5bqUuatxpfsDSJxoMmhFbJ4vhajAf/s+3C
uK0rZGJqepUUJcfW63WPBKN2GSxgHWhdx1jD+kfSjRHgdAdKcBO7l29fm95LUSc0
VlSsVS/+YxrdRUIYVloFoUtKRgywtzRkpsgCEo9ygg8n+sYPt4SMmWPhC9ZGTWUd
VXtroMTeeLQjw2f81NHpYgXAAd5TbCel5Azg3j1/BzUUbxFQ58pQ8lVQ1KPxEJYK
RBYVQo5UOyc9i30BDSIpFGaJISLHp9E6kBAC3yHu9WAJEphuD5UcThujq/jVLZ98
THPo5JshbFtw97VphaqoVS6bpGjdhNDXMxiKsQ9rG1mTxpMMsuv+T8A6HGPho6xX
seElbTupISdT66TSLX+Jt57qNLTZN+0zQGiby1ooBImf8zmdFjW7HMpGN0qsDhA2
k7gNSDY0xATppQ9Zkmem
=v48/
-----END PGP SIGNATURE-----

--lak8Uquzb3CMtnm+--

--===============1234987608512285604==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1234987608512285604==--
