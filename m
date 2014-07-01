From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 6/8] ASoC: compress: Add support for DAI
 multicodec
Date: Tue, 1 Jul 2014 18:41:17 +0100
Message-ID: <20140701174117.GD15028@sirena.org.uk>
References: <1404200881-32253-1-git-send-email-bcousson@baylibre.com>
 <1404200881-32253-7-git-send-email-bcousson@baylibre.com>
 <20140701164134.GH2296@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8938821885700509771=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C472026513B
 for <alsa-devel@alsa-project.org>; Tue,  1 Jul 2014 19:41:32 +0200 (CEST)
In-Reply-To: <20140701164134.GH2296@intel.com>
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
Cc: alsa-devel@alsa-project.org, misael.lopez@ti.com, lars@metafoo.de, lgirdwood@gmail.com, Benoit Cousson <bcousson@baylibre.com>
List-Id: alsa-devel@alsa-project.org


--===============8938821885700509771==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bajzpZikUji1w+G9"
Content-Disposition: inline


--bajzpZikUji1w+G9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 01, 2014 at 10:11:34PM +0530, Vinod Koul wrote:
> On Tue, Jul 01, 2014 at 09:47:59AM +0200, Benoit Cousson wrote:

> > +	for (i = 0; i < rtd->num_codecs; i++) {
> > +		struct snd_soc_dai *codec_dai = rtd->codec_dais[i];
> > +
> > +		switch (cmd) {
> > +		case SNDRV_PCM_TRIGGER_START:
> > +			snd_soc_dai_digital_mute(codec_dai, 0,
> > +						 cstream->direction);
> > +			break;
> > +		case SNDRV_PCM_TRIGGER_STOP:
> > +			snd_soc_dai_digital_mute(codec_dai, 1,
> > +						 cstream->direction);

> Wouldnt it make sense to fix snd_soc_dai_digital_mute() for multi-codecs. Did
> you do same thing for pcm?

Yes, the other callers also iterate through all the CODECs.  It might be
sensible to have a wrapper which does the iteration but I do think it's
reasonable for _dai_digital_mute() to just operate on one DAI.

--bajzpZikUji1w+G9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTsvK6AAoJELSic+t+oim9uEcP/0OgsFCx1jthdd7nQXcSxLJi
o5q0OInzibFJvzkcGQXkp8gseCQw+932RqNk7C7RKzc+6zeF7cRIDR3RUbz4EO7J
opGZL1U325ikUY+IBQQ/9D7QQ5qDXIGccFbAU9O5c0kPwMjxwv808DcirZjpTbhX
1eVWCAsTAXlYRrzp+wXv0E0eEkboEfbY6/TO3LmkoKNBQplOb94wBbeXoECCOfEN
SgLWgGXjLYQ6aAOR2vBFouXd5D1HZhteizKY/kOcvklh6WGohQdrr5ghBdWR/NIL
ado4n65hYS+VcJ5Zmk3yNty1r7yKLB7PdWeD4xIU9+6FCBua7fTErYKvEZtME1Q6
g/BuihUhMnHxS4a160n1l/cEhYvyTEPhIymfzJRmJN39VgWewsJ3WaetTLt8oLpn
YhgTRfBtRC7B2FILjI/rgn7K6XRoICsxvoOeLOhGWjFdmLPQqE6szubGkqtpOycG
v9ri0zRm+ivYqZrZLHycT2uYcLJrO/1A8DTDAjclCz4QRacexwS17p31qzlHknvl
qnXvBtYfiaLXahu9jHPfXfmW8vnsSsfMMgaWV7NHR1QtxJX76QitqKv+bgmnZfum
AA3IBnry9MYDmpEgVs5o+DK3LoqHsx/6XNhB56dMipatZRm01DQ3S5ntldhrBbkF
hJvThL+y6D+AESQzEQpi
=I9fk
-----END PGP SIGNATURE-----

--bajzpZikUji1w+G9--

--===============8938821885700509771==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8938821885700509771==--
