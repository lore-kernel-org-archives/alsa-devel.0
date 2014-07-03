From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 6/8] ASoC: compress: Add support for DAI
 multicodec
Date: Thu, 3 Jul 2014 13:18:46 +0100
Message-ID: <20140703121846.GB410@sirena.org.uk>
References: <1404200881-32253-7-git-send-email-bcousson@baylibre.com>
 <20140701164134.GH2296@intel.com> <53B400DE.3040205@baylibre.com>
 <20140703064147.GK2296@intel.com> <53B539E8.1000301@baylibre.com>
 <53B53C6B.8020707@metafoo.de> <53B540EE.30009@baylibre.com>
 <53B541F0.1040105@metafoo.de> <53B5428F.9050100@baylibre.com>
 <20140703120613.GP2296@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8460282838133386811=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 166CD2658AE
 for <alsa-devel@alsa-project.org>; Thu,  3 Jul 2014 14:19:04 +0200 (CEST)
In-Reply-To: <20140703120613.GP2296@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, misael.lopez@ti.com, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com, Benoit Cousson <bcousson@baylibre.com>
List-Id: alsa-devel@alsa-project.org


--===============8460282838133386811==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ri7MIv52hxsKkbzo"
Content-Disposition: inline


--ri7MIv52hxsKkbzo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 03, 2014 at 05:36:13PM +0530, Vinod Koul wrote:
> On Thu, Jul 03, 2014 at 01:46:23PM +0200, Benoit Cousson wrote:
> > On 03/07/2014 13:43, Lars-Peter Clausen wrote:
> > > On 07/03/2014 01:39 PM, Benoit Cousson wrote:
> > >> On 03/07/2014 13:20, Lars-Peter Clausen wrote:
> > >>> On 07/03/2014 01:09 PM, Benoit Cousson wrote:
> > >>>> On 03/07/2014 08:41, Vinod Koul wrote:
> > >>>>> On Wed, Jul 02, 2014 at 02:53:50PM +0200, Benoit Cousson wrote:

People, please delete irrelevant context from your e-mails - it makes it
easier to find the new content.

> BUT Now thinking over this again, does this make sense do do with multiple
> codecs??

> For folks haveing decoders in DSP inside SoC, the compressed device will be
> actually a FE. The BE will be PCM to which codec would be linked. The folks
> supporting decoders inside codec like WM wont ever need this.

> Mark, do you agree to this?

> So re-thinking again on why we need this??

The use case tends to be for applications that have one device per
physical output.  This isn't normally mobile, it's normally high
performance audio applications where people are doing things to try to
electrically isolate the analogue outputs or dealing with high power so
need to keep speaker outputs physically separate.  I can imagine set top
box type applications (which do use offloaded media decode) doing this.

--ri7MIv52hxsKkbzo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTtUojAAoJELSic+t+oim9vkEP/jZTEqPuicBTPjItNTcpjg/B
LWySJFiNSwrPfNzChjf+pc2A/baBBzljKvMlld9AAf3yQnvquG71QQ2nNiDlz2Ej
iZ2J7Y5wUQP+QT3/fRl6lmbJ9ilLWWHzydF1OA3RRmE9LAHf99+D0ZaHHP/h15EI
QMqeCFmybRhhVT5vsH3Jsmz5O1ew5LFyS1isdGlq2hwjBb5YhS+ou35G5RJCrXPo
ZbDahJG8EjP43YHgY5He+AxuBgO+6yHZXZywytumXmELhH1IblKnQk7YxOSPZNqb
/h3TCYr0UjhuVAfGT1to7nsRdlrgWC49bBps1lH5HVbWacovyXOTea+qRY7X83++
xG7QgQrn3P1LAjNWpJcPs7SQ5WjfnrnEsUAkD6BkUnj/T5m5YZOLg6SYGN0XCV5V
DCmYChHQZGeL3qMSjfdpdIgbNjEbeFFpdwMc9djHiq8qQ5n+NKv9oeNXbGv4JysC
O56oW03Yf2lNcB8Stl1oawM0S3WTQ3MJCQmKi5hV9zjEL4B3uFVWwnxLfOevG1b0
/4lY/05kDGHsrJc0be0plUv6WUORujX5lx3cwACwS9dZ376bPOveOApFCZiNUXr7
YjkVJECNKCgw2137doS2O/W7Ye9WCfk/q5sgBYn8crqLX6fvNgbBdMqfDqdS3RJW
at1DSl1JC6PdQFfwFD8y
=ogW7
-----END PGP SIGNATURE-----

--ri7MIv52hxsKkbzo--

--===============8460282838133386811==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8460282838133386811==--
