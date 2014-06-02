From: Mark Brown <broonie@kernel.org>
Subject: Re: Failed to set cache compression type
Date: Mon, 2 Jun 2014 16:09:57 +0100
Message-ID: <20140602150957.GK31751@sirena.org.uk>
References: <CAOMZO5Cj=qrrH_nWhCM4-63GPqfgpL1k=Q53z8cDDk3_TpUzBA@mail.gmail.com>
 <538C840A.2000307@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0205380525243226101=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 09E982651B7
 for <alsa-devel@alsa-project.org>; Mon,  2 Jun 2014 18:18:30 +0200 (CEST)
In-Reply-To: <538C840A.2000307@linux.intel.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0205380525243226101==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDymnuGqqhW10CwH"
Content-Disposition: inline


--qDymnuGqqhW10CwH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 02, 2014 at 05:02:50PM +0300, Jarkko Nikula wrote:

> I was looking at this too and it was introduced by the commit b59dce53ef61
> ("ASoC: cache: Fix possible ZERO_SIZE_PTR pointer dereferencing error.").

I've just fixed that now, the error checking isn't right - it should be
returning 0 not -EINVAL.

> If I understood commit 657254714ad2 ("ASoC: io: Remove support for ASoC
> cache in conjunction with regmap") right should we remove remaining
> soc-cache use? All codec drivers seems to include regmap.h although some of
> them are still calling soc_cache_sync().

There's still the AC'97 stuff at least, plus the ab8500 though if that
ends up blocking anything I'm just inclined to reapply the conversion
patch and let someone fix it if they care.

--qDymnuGqqhW10CwH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTjJPBAAoJELSic+t+oim9/noP/3vFEr0nHLOtIttXBlItQJJB
wUebn9MbM+h5xv6gnkaTIdvYNYaUGzSFCRalYCQFT21eHRxK3uGbJm9xmuddfhzC
tMqz6ltlNVuikuOeo8uHq6ROkBFatRHIpKAootmyYABGSr363L8j6T938VFxdzT3
QpPrF6+5KHnPAQL2E5r+hf4w54a0Gj4SzOvI5qImwrND7nKQLsHUeUZUn5rltaar
0j8V5Fzw9PZZf/KGe9UGym7RpYAX6ogUnPcxbLlJcZH01cU37qs+he4bNV/iCq4T
1EaG0ISumVWlKecK4kCSqp+Rht/5zuUCbibr6zTKW+iF4KqyrxIeTM0RPtv828X9
5WC+5SjmahmS2lzVqUsmxFdYB49yXIHVUyn67UyJufJVMPsAFKWJB+QI85zbIzYW
tmOifHPgfjplhPvzRTkx9KLIXT7KlftujG7TvVWXEfiowk62YyJa7iKVzFCtxj2j
97bXJ5b2gAD6fa7eRdOAs+RDPNd2sdkns+0MxH32FCyjHDrRNIo14f+Xfz8NZpvu
Bl0D5pKkd1IV6y+gnV0ZuvQElZ+GN3F2Qj2+6PGlFHKlsAqoqyakvlw74zP/X67U
7fVgrn2xy5Zhya1+MGrjq6930c8oG93QkdKexQFgOnloPEWkikkVQle/HWEh6Msz
NBHd6eQ3AQ5EGTzr6AMO
=Kh1I
-----END PGP SIGNATURE-----

--qDymnuGqqhW10CwH--

--===============0205380525243226101==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0205380525243226101==--
