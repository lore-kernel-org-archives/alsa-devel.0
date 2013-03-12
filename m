From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2 v2] ASoC: fsi: use
 snd_soc_register_component() instead of snd_soc_register_dais()
Date: Tue, 12 Mar 2013 20:02:54 +0000
Message-ID: <20130312200253.GI19942@opensource.wolfsonmicro.com>
References: <87fw06ace9.wl%kuninori.morimoto.gx@renesas.com>
 <87k3pdtnlk.wl%kuninori.morimoto.gx@renesas.com>
 <87hakhtnjl.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3872864824543588629=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8373A265DA0
 for <alsa-devel@alsa-project.org>; Tue, 12 Mar 2013 21:02:56 +0100 (CET)
In-Reply-To: <87hakhtnjl.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@wwwdotorg.org>, Simon <horms@verge.net.au>, Liam Girdwood <liam.r.girdwood@intel.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3872864824543588629==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Hy6Wd/+xmQCqA1QQ"
Content-Disposition: inline


--Hy6Wd/+xmQCqA1QQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 11, 2013 at 06:27:46PM -0700, Kuninori Morimoto wrote:

> +static const struct snd_soc_component_driver fsi_soc_component = {
> +};
> +

It'd be good to at least have a name here.

--Hy6Wd/+xmQCqA1QQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRP4niAAoJELSic+t+oim9leAQAJsUYSBP0TqmzePqHVEoPzvp
R5ZQ64+UyJBy2uRzw8RatjIdSZgm2cpeGXaYbC1I2QBCR8m5S+v3nE3zsnw7//sR
EwiDDYdIxapGqn5+WcqMXnRZiJURx51hGk28gRv07vtqYOfZLsja7KLim459vHIn
SW6Xjv406RmJnMdD+QxMnQmhUSt3WfUw+zek8qbN2m19P1FWUeApFL77V31WREby
yYNXsv8eN/7T6lbptGUujY52yfwgzl8znB2dlhG+YtYUBssb/HftaKUGB1cIWdtE
d0+tmUw7gseqbCZw/Ugo8VEZp71KYVEIJ8512kVl4Ws6LPvy2UoILvzWL50er9qB
AzxfPsJSssQVI4D8E72Mmf9Et22svruSD9Pxc4WetN3JJjWwpr5hKSGwimODj661
na8CifpMe+72aAaU/+8kLkgoV5kbyzpoXL+T3tERn2MpwfUqe/dq/EjTjeW/Myb+
rEsR3sPSqLKh0dgphj+cmO2R7YP8ITmP65YOno4c1gAqo/HlBcl8t4Qslk/jdBLC
Gj8EbtarOeT0OsucaTp1rBOGtRSaQ306dQdXZMv6Y4g6sZ14coARUHSICmwNbADx
gT5JA4awO7jXvHS4blawOhIlfLp8KpFNiR96DJgqVugPPBjuv556NMlK5e/SmH2b
fRS7anYl4QSFj8HclZEK
=eisJ
-----END PGP SIGNATURE-----

--Hy6Wd/+xmQCqA1QQ--

--===============3872864824543588629==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3872864824543588629==--
