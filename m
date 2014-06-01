From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCHv2 3/4] ASoC: Intel: Use
	devm_snd_soc_register_card
Date: Sun, 1 Jun 2014 11:52:03 +0100
Message-ID: <20140601105203.GB5099@sirena.org.uk>
References: <1401112593-2852-3-git-send-email-jarkko.nikula@linux.intel.com>
 <1401269739-1373-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1750309573370026144=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E7A6726517A
 for <alsa-devel@alsa-project.org>; Sun,  1 Jun 2014 12:52:17 +0200 (CEST)
In-Reply-To: <1401269739-1373-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1750309573370026144==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mL5prfgbrp62Xbpc"
Content-Disposition: inline


--mL5prfgbrp62Xbpc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 28, 2014 at 12:35:39PM +0300, Jarkko Nikula wrote:
> Simplify byt-rt5640.c and haswell.c machine drivers by using
> devm_snd_soc_register_card(). Remove also needless dev_set_drvdata()
> from byt_rt5640_probe() since snd_soc_register_card() does it too.

Applied all, thanks.  Please don't do things like sending a new version
of a single patch in the middle of a series - it just makes it harder to
follow what the current version of things is, especially if there's also
some discussion going on.

--mL5prfgbrp62Xbpc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTiwXQAAoJELSic+t+oim9tyYP/32A6BtkDIVmQjEG/6QEEPb0
5oQ1MOGjvTRjMk9UCGdORdnJcLb73WOekZsDyTl6SeuyZaSC3Al2HKy3+5YAy1MY
hi5VRxvYp16ifMhHzgn9fdxAMt6jMz3xVOa7OiByOaZvIT5YtD5BMWG15rC7eRHH
Rk5ITTdOUfT41UucaE1HrhXUak20x0ur2EEy0bkjLxhNm4qnt5rSSr9jVrh+ViY4
gPWngrHW2GJMJ+BFTFJoLZyplr39HOwQn5BsU9rG+eNdRCUrVYWdPjP6vvoRMeWV
feNarXCHCrtRk+4Pl20CgBPbgvlVPBBMfktnOWKxtlpB8fyQfRuqemCgIHbITzsy
1SqH1kCt89t/Z+wJFGRtreUMy57KdlmZZ929j9cfIJ2hb4YManbAtya8Rj/MJSBy
90eJ+njkmCtov13+14Hb+hvIWAxi8iK6gacFN/sb02d/BLbvfAWAMRsM3Ge08fUF
oa3Fo4dYrE4XntzV8wMpahhQKONEkQ452R8Bqqs9RDbRr90D1GjGwN21ifYcGALy
vDd466V8DwFnuF3l6D7FQTCbVm9RIsSzM9y8k9G7Z1PNu/bhk1pki7fjS6+a0Tuq
tpllqdmdB7LuKsbp5Avuppr5NaLnPu0tfSw8JBws+c1b+LPi2P60PrPGQey5lToA
7ddrK1McvUk6of6abQoe
=Rz7K
-----END PGP SIGNATURE-----

--mL5prfgbrp62Xbpc--

--===============1750309573370026144==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1750309573370026144==--
