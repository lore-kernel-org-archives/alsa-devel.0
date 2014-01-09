From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: fsl_ssi: Set default slot number
 for common cases
Date: Thu, 9 Jan 2014 17:34:34 +0000
Message-ID: <20140109173434.GG12858@sirena.org.uk>
References: <1389264168-13379-1-git-send-email-Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5430971727492495688=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D12B92652C5
 for <alsa-devel@alsa-project.org>; Thu,  9 Jan 2014 18:34:43 +0100 (CET)
In-Reply-To: <1389264168-13379-1-git-send-email-Guangyu.Chen@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.de, festevam@gmail.com, timur@tabi.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org


--===============5430971727492495688==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="S5HS5MvDw4DmbRmb"
Content-Disposition: inline


--S5HS5MvDw4DmbRmb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 09, 2014 at 06:42:48PM +0800, Nicolin Chen wrote:
> For those platforms using DAI master mode like I2S, it's better to pre-set
> a default slot number so that there's no need for these common cases to set
> the slot number from its machine driver any more.

Applied, thanks - but note that this will mean anything that does want
non-default TDM will need to set it every single time it runs rather
than being able to do it once on init.  This might need revisiting if
there are users doing that.

--S5HS5MvDw4DmbRmb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzt2nAAoJELSic+t+oim9NU0P/3XfGECI6s/aDNI1DLXM17CY
sR3EIh88G2eOlthFPcWg3e6KP2eTE8Dp1BflkAFmPjuw/njOQEyDRA//37dQk5NT
oO731gFGisUjZJs+XyzsYqD1o/Uxtc/FPB0j22CWP50ljhbEo3whv+vK+OGW9V9P
yYkY1/w+Gwc4SUV0pdILPgHP0iTJcrOunesxsQpl7XtWqezqmWZ+HzqV4G367ysx
gp5bjl+oR+FjCClI3xN2Ig1wyz5sVntJzO8LWx8MoHQgbF9gPIN2XuGikAVc1I2g
7pkjcNYUxDxDqeXcyaw65IGbD2F2WIyu0odqXV9zjetPEtWcxoXhYJEivTFBgMwc
/S3b1JlLvQSjWsbtQfVFWweTEV17Oic12+VCHx/E4K81/0PTTxRVz6mCQjDUUa4C
6ZWP7uPtuXax2IOhwhDpCgnUfU5BmJdItLldsgvkVpNTeqa1p1s7tClX1ovKyAXk
kmuMWfvDiMgHv77nYTBy26sdocUTyu+5QeInBVQKh5NNygWo0emQk6V6T+fkdh0k
qXaLdpnaWEaHTLGN/38F3vjagGmtF9KDSqQPzFbw0giCV1HHxkodWBhQ4KNMdNpm
4+nMopqM95lKTGAmMB1OLMTSwRSxS+9OQ4N6h3X0nzFT+Nl1CUG+Do7a3EC/h5MF
7ejmCnsIoOT7gWTt/DT+
=N3wP
-----END PGP SIGNATURE-----

--S5HS5MvDw4DmbRmb--

--===============5430971727492495688==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5430971727492495688==--
