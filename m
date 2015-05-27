From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/3] ASoC: topology: Add topology core
Date: Wed, 27 May 2015 20:48:27 +0100
Message-ID: <20150527194827.GP21577@sirena.org.uk>
References: <1432574570-7436-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <1432574570-7436-2-git-send-email-liam.r.girdwood@linux.intel.com>
 <20150527190021.GO21577@sirena.org.uk>
 <55661997.2050800@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7252383454624583163=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C3E4260412
 for <alsa-devel@alsa-project.org>; Wed, 27 May 2015 21:48:37 +0200 (CEST)
In-Reply-To: <55661997.2050800@metafoo.de>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7252383454624583163==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="R5F1ZJCXXYWhzKr1"
Content-Disposition: inline


--R5F1ZJCXXYWhzKr1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 27, 2015 at 09:23:03PM +0200, Lars-Peter Clausen wrote:

> Ideally we'd turn the dependency chain the other way around and have a
> snd_soc_dobj_widget struct which inherits snd_soc_dapm_widget and
> snd_soc_dobj. In the dobj callbacks you can then still use container_of to
> get it. This comes at the expense that we have to add a free() callback to
> snd_soc_dapm_widget. But it opens up the possibility to have other
> specialized widgets sub-classes. snd_soc_dapm_widget is already rather large
> given how many instance we have of it and quite a few of the fields are only
> used by a particular type of widget. Another good candidate for example
> would be the DAI link widget with all its params fields.

Yeah, I was thinking something along those lines might be good long term
but it's definitely a separate thing to getting the topology stuff in
and I started worrying about things like multiple inheritance.

--R5F1ZJCXXYWhzKr1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVZh+LAAoJECTWi3JdVIfQSMwH+wbVN8Te8SqlHoq5yCCzksN1
ecH4tY3HO6h9eOVmaTdWvCyHl+gvBK6zpXzV7CrKXpwhp+cNyUBW6zVthZuEBrQJ
IpM9mHfyJKpxf84zYpVYMJ6ljnsfxopg+BH6BTQrCOzg2x1e/zrYdS75IXxi054b
lunu0ZhMfd4tu8zONlk5UCwa8P2U1FfoTCZqd28gkteAdUnzA4lQIOXC+euOjTMS
/ZABI2oFBIMjkt9T9IF1Xl83bXBwJuqbeBljF+qJ2QfgXC8GR382tukprL8KHdkg
9d3Aw0h6r9WEMqo+NAmhAPOI3lEXHpWnA2rWyMv9rrkRoPe+uh9sVpf/n5NU3wo=
=/r37
-----END PGP SIGNATURE-----

--R5F1ZJCXXYWhzKr1--

--===============7252383454624583163==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7252383454624583163==--
