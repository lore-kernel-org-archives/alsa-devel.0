From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: Build adau1701 when
 SND_SOC_ALL_CODECS is selected
Date: Tue, 23 Jul 2013 18:46:01 +0100
Message-ID: <20130723174601.GN9858@sirena.org.uk>
References: <1374511793-32187-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1818824090796635746=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 86C17265143
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2013 19:46:04 +0200 (CEST)
In-Reply-To: <1374511793-32187-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1818824090796635746==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ABASXTTJEiBwKrZs"
Content-Disposition: inline


--ABASXTTJEiBwKrZs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 22, 2013 at 06:49:52PM +0200, Lars-Peter Clausen wrote:
> The adau1701 driver was removed from SND_SOC_ALL_CODECS in commit commit ee8c7e9
> ("ASoC: Remove adau1701 from SND_SOC_ALL_CODECS due to Sigma dependency") due
> to the dependency on the SigmaDSP firmware loader which was only available on a
> limited set of platforms. This was fixed quite some time ago in commit 40216ce7

Applied both, thanks.

--ABASXTTJEiBwKrZs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR7sFWAAoJELSic+t+oim9qqIP/iX3mKkRQ4unt/rvQZ3hQMf5
cMp6WQOb/nTanemOR8OjSvJSvvGJz82PsEN0SHLi+BisAOPn3DXlHvkn/Lv4VP+9
JHjpR1q7X7wQWn8//uE2Fy9XgKZVwDSdNjt7/CNIYyJEMbv1UMO0WM4EAYGvZjd5
5ANzMf4MBehc2UmPcpelFsXFnTHZMVbbGasbd3EfNXGwlOXYAyralAjmxcmjOxH+
mgvUSoJq8wmNS5fMOOFN/9cY2WuTXYvzcjOahc68B0C4jHpIrowG6SJ4iqidIuVA
mC93uSbHZo1YI1Ow17P7SolpDk+JM9G8sY4IcDVykdmNHTIld8jChFwNERoKBOzE
le0SFHrvExGHKoBYm1S5m964dSgsBTnuELLr5ziMx4zudachrYaERzphxY0VbaO7
XZv/51AroNR81gfmo4+UbiolCzaIFwoWO4uZAaGezfDgY+BGIxmEv+uHx4+bdAIQ
WizYxxG21G88uQ+2lI7Gk9a+KGbJOCw2X5wWVYtZfdRwN+5S/ZnX0ycsKROLMX/c
cAcf6qZpQGjqvum9Qm14So80rQTs5SjZl18lJG7atka7lt420fOaVcOoF88pbT7q
g8Z4Yla6VWyWdOxBhcTRzI598vqA4/nskxPNnJIwXCPtkXoWEDHhDHXE/enlYd0B
xY3CcSCNo1J2Sup/R8he
=GZXv
-----END PGP SIGNATURE-----

--ABASXTTJEiBwKrZs--

--===============1818824090796635746==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1818824090796635746==--
