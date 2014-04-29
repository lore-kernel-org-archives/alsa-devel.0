From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dapm: Factor out duplicated code in
 soc_dapm_stream_event()
Date: Tue, 29 Apr 2014 09:41:59 -0700
Message-ID: <20140429164159.GC16981@sirena.org.uk>
References: <1398775882-2321-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7962968014845542253=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C28D265055
 for <alsa-devel@alsa-project.org>; Tue, 29 Apr 2014 18:43:47 +0200 (CEST)
In-Reply-To: <1398775882-2321-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Benoit Cousson <bcousson@baylibre.com>
List-Id: alsa-devel@alsa-project.org


--===============7962968014845542253==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jousvV0MzM2p6OtC"
Content-Disposition: inline


--jousvV0MzM2p6OtC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 29, 2014 at 02:51:22PM +0200, Lars-Peter Clausen wrote:
> In soc_dapm_stream_event() we have the same code twice, once for the codec_dai
> and once for the cpu_dai.  This patch factors the duplicated code out into a
> separate function. This will make it easier to modify the implementation (since
> there is only one place that needs to be updated) and also easier to add support
> for more than two DAIs per DAI link.

Applied, thanks.

--jousvV0MzM2p6OtC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTX9ZTAAoJELSic+t+oim948YQAI0pR0kxItRhDXoAD/OMmvyK
66cabt8QyE4uAbFnOWCRaI8SHfCK2W85DhfrvU2QTXoZj9c8vPo0Z1DBkw5jDnSZ
8kueFSxhIsNscJTQBug403mGa8FfX3KOfYO2+RdubFDcVkh5SleJ0lAacDbrsVYN
i9XamZ5OT6w5pSu637RCzMVykMkmxIDOYguXgINwieYJ4CKjYLJMN+FQek6H7Hpf
ELeHca/4I4OazkhxbasCBXpHMe9ZeDml7RBZKBAGPh/iFMkova726tes/pTqoEOk
ADyKLmMzVQ8uO+fEY6I/4VwHhbwSSOjOTC8woNIZuiCkAsJ8aaMr1qCxa0w64WZZ
C0X+mp8+51BKSTQYIMeuwXNBKOqiXcvrnf5nNka0JzzVaKEaEM4ggXqbQjU8NZoT
IQCpXRl9Cm+KjcBsBYd1uyQoRGS6VJBgZIiRwk/4YGYbO0VV/ldf1U9DzErIqLl0
7GC5GqcOY7Sj67sgf0nljDzzFhEIZ0qRwbyL7Me6AI40IEDDbbvzHTir+j5YgAhy
T13qM/KVo0sQNxnykp+dXPAlQLWRJ36DJUQoviAQma1HYSusRZpJ8scxIjTJ2R4l
N3Wg7ijl3Mfah9Q8WqkU+m/WhLCAT3i1+lGCIG14YX7gw2qmpToczAgt94mcDjWU
aHnpbd8LwiJOD0RVDEKP
=Cn8G
-----END PGP SIGNATURE-----

--jousvV0MzM2p6OtC--

--===============7962968014845542253==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7962968014845542253==--
