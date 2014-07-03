From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 6/8] ASoC: compress: Add support for DAI
 multicodec
Date: Thu, 3 Jul 2014 19:38:04 +0100
Message-ID: <20140703183804.GO410@sirena.org.uk>
References: <53B400DE.3040205@baylibre.com> <20140703064147.GK2296@intel.com>
 <53B539E8.1000301@baylibre.com> <53B53C6B.8020707@metafoo.de>
 <53B540EE.30009@baylibre.com> <53B541F0.1040105@metafoo.de>
 <53B5428F.9050100@baylibre.com> <20140703120613.GP2296@intel.com>
 <20140703121846.GB410@sirena.org.uk>
 <20140703161517.GQ2296@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6175761138384711932=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 93281261A74
 for <alsa-devel@alsa-project.org>; Thu,  3 Jul 2014 20:38:21 +0200 (CEST)
In-Reply-To: <20140703161517.GQ2296@intel.com>
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


--===============6175761138384711932==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9hGs/gFH0GqcBdeq"
Content-Disposition: inline


--9hGs/gFH0GqcBdeq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 03, 2014 at 09:45:17PM +0530, Vinod Koul wrote:
> On Thu, Jul 03, 2014 at 01:18:46PM +0100, Mark Brown wrote:

> > The use case tends to be for applications that have one device per
> > physical output.  This isn't normally mobile, it's normally high
> > performance audio applications where people are doing things to try to
> > electrically isolate the analogue outputs or dealing with high power so
> > need to keep speaker outputs physically separate.  I can imagine set top
> > box type applications (which do use offloaded media decode) doing this.

> Not sure if I follow you, I have no idea of how these systems work.

They're having the SoC play stereo (or whatever) data and then having
multiple CODECs on the bus, each parsing some subset of the channels
(typically one channel per CODEC).

> So how can we have a situation where we have compressed device linked to
> multiple codecs?

If it's intended to be DPCM only (which it iss now I think about it) it
sounds like you can't have it linked to *any* real CODECS, at least not
directly!

--9hGs/gFH0GqcBdeq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTtaMJAAoJELSic+t+oim9r0kP/2jWPCkFc5Q9WX4+OtmUgS9k
R4YzIECaj3/ZsY3cfq4e8Tc/BF9rYcXu06ykhtG2vZS12uNmfnqCdg9T5BQJMqlY
GisSDhiBME2p0fF++RTHDedM39uAzbpNxC9jcCHLGkXE/rtDIq2+mwRSlikM0yZA
6+waQa/rp0zNzZRKIDCk8sHftj08CcA/dvPm+2gl16206mUeeJ+I13n7A+XP46SR
cdzK4F9c3j1nZm+9Ls12hnICJWbs8zCNji5k8VxXSWjr44/QM6ZA1KSNjIU2B7Z2
+46a0ZznlMiekzssI+VAAmElatcgQPMuGTO0sUGDjoQw6PJ1YXcH/BDaQq1OwURE
Un6+xpmgaSqch0IYFRjB82NswbJAnoNNjGtNxqBOxFqR7ZnLuLxe1VMXqBgNxPRM
KlwIUdyuLFws/z93+LD+A0dOKSjN03XaGBJvW1bpDkPFLL44P7Pr9H61PgoP7MGi
Sxzyh3dnRIqzbqmJm/LZdayIy3CsdXl54v65dzln/KkXEpWh5y7L8bfJHvli9hzO
UUcxiBewh3aSlA6HsExsfidv4LDmYrNsyJgHyEWXYGFG6zAakgSonjIv2esD7dbJ
C/fxwVUq/6tDigit04f3FVDeoLhFLVeyf0Cpo5MEubBPPAL4cz4ydwezCU5drp5m
dbCn5ul5eww7X2vxpnJF
=pmt9
-----END PGP SIGNATURE-----

--9hGs/gFH0GqcBdeq--

--===============6175761138384711932==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6175761138384711932==--
