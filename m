From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 00/10] ASoC: support adding PCM
 dynamically from topology
Date: Mon, 10 Aug 2015 12:50:15 +0100
Message-ID: <20150810115015.GA10748@sirena.org.uk>
References: <1439186973-913-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9137760789281865939=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B5AAF260836
 for <alsa-devel@alsa-project.org>; Mon, 10 Aug 2015 13:50:30 +0200 (CEST)
In-Reply-To: <1439186973-913-1-git-send-email-mengdong.lin@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mengdong.lin@intel.com
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============9137760789281865939==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 10, 2015 at 02:09:33PM +0800, mengdong.lin@intel.com wrote:

> Mengdong Lin (10):
>   ASoC: change the PCM runtime array to a list
>   ASoC: Define soc_init_dai_link() to wrap link intialization.
>   ASoC: soc_bind_dai_link() change 2nd argument to DAI link pointer
>   ASoC: implement DAI links in a list.
>   ASoC: Add support for dummy DAI links and PCM runtimes
>   ASoC: bind new DAI links after probing components.
>   ASoC: support adding a DAI dynamically
>   ASoC: topology: change pass number of DAI smaller than graph
>   ASoC: Topology: change stream formats to bitwise flag
>   ASOC: topology: Add PCM DAIs dynamically when loading them

Please when submitting patch serieses use something like git send-email
to make them appear as a thread in reply to the cover letter.  Please
also make sure that PATCH is the first thing in the [] to make it easier
to spot messages and try to keep your subject lines consistant with the
style of the subsystem (and at least internally consistent within your
series).

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVyI/3AAoJECTWi3JdVIfQ7zgIAIU6oZqIvquRwI7Y8BGIDdoV
IQlSJbYWwUv3yLJVGZottx4jMz+ERqbLVxtKgdDQW4PllFjbJT2L8ZjibTBqv/W7
Q4NU9Mf6FTH/pEfJNsuYSfLw8ITTsYNxMdQL1hbvHmfmYKAEzF+Mh4f5D6gykpx3
uBE78S9l5pdJo74fhJwbcEYVb7AWqvE1jcXGzBGTHh8/J17tA9xtgpD6+Ez40b/v
WaYaiu6VCfJGZEiwz01g9ulZFMbFgiUxqWPQknFa/CBTEym6xp2f5F2jIuvrtxu0
D0VkWSpfjH2DzeR4OrurOI1tu07u7GRvFvKPb4thHivbnFYAJP39L9tCvaM/90Q=
=tIjJ
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--

--===============9137760789281865939==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9137760789281865939==--
