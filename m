From: Mark Brown <broonie@kernel.org>
Subject: Re: Applied "ASoC: soc-core: add .num_platform for
 dai_link" to the asoc tree
Date: Tue, 22 Jan 2019 20:36:37 +0000
Message-ID: <20190122203637.GM7579@sirena.org.uk>
References: <87h8e2ami9.wl-kuninori.morimoto.gx@renesas.com>
 <20190121192029.CB44E1127D00@debutante.sirena.org.uk>
 <87ef951mhd.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7143740881449918994=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A425626687D
 for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2019 21:36:38 +0100 (CET)
In-Reply-To: <87ef951mhd.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============7143740881449918994==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dpynvXbW/eW9Tpc3"
Content-Disposition: inline


--dpynvXbW/eW9Tpc3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 22, 2019 at 11:10:09AM +0900, Kuninori Morimoto wrote:

>    I think "platform" settings is not mandatory in this case.
>    So we can allow "no platform" in modern style.
>    But what do you think ?

Yes, I think that's fine especially when you start looking at things
like CODEC<->CODEC links.

> 2) On legacy style, if sound card dirver doesn't indicate specific "platform",
>    then, "snd-soc-dummy" platform will be selected automatically.
>    It is implemented on snd_soc_init_platform() today.
>    In modern style, we can force to indicate necessary platform,
>    or, not allow implicit snd-soc-dummy platform selection.
>    But what do you think ?

IIRC the goal with dummy was twofold.  One was to avoid having to list
dummy in things like DT bindings where we don't want platform specifics
(but I'm sure we could arrange something there).  The other was to
ensure that we always have something there so we don't need to test for
platform operations being there outside of init which again we could
deal with I think.

--dpynvXbW/eW9Tpc3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxHftQACgkQJNaLcl1U
h9B5aQf9EL0GPnb97V3XQPLhbOpMApjG4LdH80xeU40NWe/rvK5txqFF4rSbEF6n
M4aUTypC4OBKJjXy6I32g7gxn8QQn/r2rRAQUNevBiI8LTblsk8Yrs66QfpoITzJ
JGKc4UK0GvWB2/YLcS7gHrtS5LOfQhm5HqNkLWw6Tf73PUEbk++R4+8nhB6yujOJ
0MXQ5xPuc55HBCURpCa0Ew0TPFkrFHFmFEQ2NRE7HYTd6CWInXuvkBUhSPkdp5+3
r/vV6f4/nYAUsb4BF64cMROnACEuVoOEcdpBqVPZZvQtoagrbJOqY8kyBYAvJreB
MicLdMjmcRH5CKVXZUveJt35xw2f7w==
=hmTi
-----END PGP SIGNATURE-----

--dpynvXbW/eW9Tpc3--

--===============7143740881449918994==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7143740881449918994==--
