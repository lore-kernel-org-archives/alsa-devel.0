From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 6/8] ASoC: dapm: Implement and instantiate
 DAI widgets
Date: Wed, 22 Feb 2012 13:29:12 +0000
Message-ID: <20120222132912.GI7340@opensource.wolfsonmicro.com>
References: <1329458170-22119-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1329458170-22119-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1329468009.24656.15.camel@vkoul-udesk3>
	<1329914154.24656.95.camel@vkoul-udesk3>
	<20120222124301.GA7340@opensource.wolfsonmicro.com>
	<1329915673.24656.107.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7571345383767752953=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id ED5A6103FA4
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 14:29:13 +0100 (CET)
In-Reply-To: <1329915673.24656.107.camel@vkoul-udesk3>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============7571345383767752953==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r4QXMf6/kyF/FvJJ"
Content-Disposition: inline


--r4QXMf6/kyF/FvJJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 22, 2012 at 06:31:13PM +0530, Vinod Koul wrote:

> So from a codec driver, how does these two get linked, who fills the
> playback_widget pointer in dais?

> For a codec which has two DAIs and I register two AIFs how will you fill
> the respective dia widgets in the DAIs...

The core initialises everything when it creates the widgets...

--r4QXMf6/kyF/FvJJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPRO2dAAoJEBus8iNuMP3dGy8P/Akf3CbVMVUovaAcFE2R/qc2
5S3d/+LK1Xh6pplali4fxmj3T9RmaYERLRwz1fdbmbn1T2R5EZSnL1sbu58Vl6e9
taptXaNpdmDa8RIl7rsOlYeXCiuBAfCYV01Z7/h8p8VtFRjqlO498tDQACwtmkEK
il313M9XY8xclYVJqEykFmuw3PCnhPrEJ85mmi7oGlKeedjCw4QPxz/4aFOfMqFq
N8lhqDCo0uBVpb4PCtOL/AuNcAih69lrIPyBwwsi7Ii4Dd1eaSEXjS2P7wqDLHJ0
enBuzRvowdrZ0ybWCUWGGg96inzVuRXe5VDAh+ogNPE6umWK29HV4xipv2hB1ka/
iSwD7RBPuu/ewald2ur6xb+ATM3cUJei3lOcO8tjBv5WvSbnBEA3vSsC2FLaIExL
sm560e8OCqkwCrmL3Eq+A7jQGfQdq+eqzzKERUdybygeKxxovag/ybRZhDhPJARV
eUCyeKL0jDleEeXLvZEgBVWQxCaujpyrnfo/QjERQ97h0QwfPRYY4QnohOBZRDi8
mNIn2RXRuIUpleyBEucDvLFzxLORTiHxUTR59Dh94a6n5zCKpp70Jt4MnRuQEWsz
xz8WLRvkXQ5AzaO0710Uv4EiSjTPwcTfev4Cj1pNE0vOuNHojtJ4/8boOaYQxiFm
VysWu0k/yTGeVy7nTSR3
=Vaw3
-----END PGP SIGNATURE-----

--r4QXMf6/kyF/FvJJ--

--===============7571345383767752953==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7571345383767752953==--
