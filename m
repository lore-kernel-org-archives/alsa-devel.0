From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2][RFC] ASoC: simple-card: add Device
 Tree support
Date: Thu, 12 Sep 2013 12:55:16 +0100
Message-ID: <20130912115516.GN29403@sirena.org.uk>
References: <87eh97sqw7.wl%kuninori.morimoto.gx@renesas.com>
 <87eh94xab2.wl%kuninori.morimoto.gx@renesas.com>
 <87d2ooxa9o.wl%kuninori.morimoto.gx@renesas.com>
 <87ob80i45a.wl%kuninori.morimoto.gx@renesas.com>
 <87li34i41w.wl%kuninori.morimoto.gx@renesas.com>
 <5231A607.5080701@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8952590770565155102=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 1CC0B261675
 for <alsa-devel@alsa-project.org>; Thu, 12 Sep 2013 13:55:22 +0200 (CEST)
In-Reply-To: <5231A607.5080701@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8952590770565155102==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f1V9hGvJIYI6R1Zo"
Content-Disposition: inline


--f1V9hGvJIYI6R1Zo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 12, 2013 at 01:31:19PM +0200, Sebastian Hesselbarth wrote:
> On 09/11/13 02:40, Kuninori Morimoto wrote:

> >+- sound-dai				: phandle and port for CPU/CODEC
> >+- #sound-dai-cells			: sound-dai phandle's node

> IMHO, "sound-dai" is too ASoC specific for this property name.
> To make it more generic, what about e.g. "sound-link" and
> "#sound-link-cells" instead?

DAI is an acronym for digital audio interface which is a fairly widely
used term for these things.

> >+- system-clock-frequency		: system clock rate for each CPU/CODEC

> Instead of "system-clock-frequency" use standard property name
> "clock-frequency". In the driver, you can check for this property
> and use it, if no common clocks are available on the arch running.

We've been round this loop several times, audio devices tend to have
multiple clocks so it's important to say which one is being set.

--f1V9hGvJIYI6R1Zo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSMauhAAoJELSic+t+oim93PgP/ispg4mC7dGgb6GGPD0om3H1
+cDMCmRHcpYcWflVNmM3hrIJamNeNEv3GtAvDVBgHhxlF9ra2yfKVaLW4/Zr6UM4
sH+E4MYOnv4QMiNaUcKpp9OX2PM+MdXK1gHAU+c7MMmj1hVj+B2YwUIQIFbPTv3W
inewS1512CEkzI4Kwwwfc68ZgdtJfJ+fnZUqrqt2xQctJAsZLrcJmdWy1YYQTEed
hBaQnWbf+QCS9Iu5nDSZZ1TdGrxLHUs/9WDlY+3TIAmJwR38LYmHGxcwT+XtQfWz
55BFvfHrdhWELhUke7IBm12HQiik9vw/hDllSPOQQ1/s/vxzaxakijIFJ8rf1iJV
C2Pb1BrjR+BCit8wN7wH/bjbkYenPLLdaK47n0QWXnOnlV0lHvoj5aerlKAbslFB
o+k1fesKmtyBzVssnLSvBjmeAq2XGZzQvtzIG+CTxBSWk7NKXVZQnElZ1ipUkema
ZbIsbAa+exrj+C3c1W9pyaeiyu1eomWkuuzjDsqUPrZcyK5kag28DFGDmPARF1dc
q//Uy6B9hqlmtldCaqJ8L72sfuLYxsR+nt5ZUlTfPzqJEXKtdv2XuZJD+aDi4wCD
db0ti0z3nVoGfdeQd4ekUK6GvXw6qbqdZ6Jwo9RGTvXJ9SFLsnWNhAIQ5lbaCZnj
eAH9qat9HtOFeqmfZ5t9
=CHJV
-----END PGP SIGNATURE-----

--f1V9hGvJIYI6R1Zo--

--===============8952590770565155102==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8952590770565155102==--
