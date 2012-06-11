From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: OMAP: HDMI: Initialize IEC-60958
 channel status word
Date: Mon, 11 Jun 2012 12:41:45 +0800
Message-ID: <20120611044143.GN4218@opensource.wolfsonmicro.com>
References: <1338836836-7396-1-git-send-email-ricardo.neri@ti.com>
	<1338836836-7396-2-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4727356620187708708=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D00A924B19
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jun 2012 06:41:56 +0200 (CEST)
In-Reply-To: <1338836836-7396-2-git-send-email-ricardo.neri@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: peter.ujfalusi@ti.com, alsa-devel@alsa-project.org, lrg@ti.com, s-guiriec@ti.com
List-Id: alsa-devel@alsa-project.org


--===============4727356620187708708==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Rzq/nSLlHy1djmXS"
Content-Disposition: inline


--Rzq/nSLlHy1djmXS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 04, 2012 at 02:07:16PM -0500, Ricardo Neri wrote:
> As the IEC-60958 channel status word is set by ANDing and ORing with
> the appropriate definitions, the word bytes need to be initialized
> to zero to avoid corruption due to previous hw_params calls.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

--Rzq/nSLlHy1djmXS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP1Xb+AAoJEBus8iNuMP3doJAP/08z9szk/lm2qdd4D+cfdHL3
SMMJ+0yRxaCgHwerhFgooHt0CQwjXlkjH+nbnvVuSjrYBl6kXBOp4jeeD/NhJhVQ
MvMyXuBkAMQLu5AM0W669du7TnmVUr/pFu8ALe54Ptiscc5jzNzWswTL8jx7Foad
pa++33QQOp8fL2vGl6BjGvHQzdbzksapoLRxZSlVN+QFXokWuYQx/LoSz/h9nGe+
y/LQn7rVGUI7am89aLtsuoiL1TuJqpmoYS4kVCdK50YmNtXCYBfaWO4y8i5B+Bpl
Yq3joXQ115Re1qpkXQJ7u6x18QuADSrTYYnPbFYT4J5rm16D1yBfKTGEesT0HVKg
BD9Bxdt7Bj0mfu9SyLuPZ0Lv1RkwMVUjPXRdxn8q1K6R1aCarA/sSouc7MJBPgUW
TM68TghxpihZ02XZ+W9aXZYR3LJcbN3I9/syHl0u0j3LtLIX/+pFSWAP2pZ+T540
WFsBBBX3g7WhAl2Vrop1EV/KotGrXUdUqyObMHl+8Nt2f/5Gtc4TZzC8BTgqMwpA
TBO+LLtVJjC/CpAtlMex4f18gsaVSQ9YSNllf4jup9LFng1GgOjQ3xwV6Ph2vZDX
sZpNI0BVfy/ahEc3zkEkBYLjRqe1bSpBEKo0EgXVmeXjZCfTpWdl6edkxPanZxeM
CjQuazabHh50/SQHbUzQ
=fK2V
-----END PGP SIGNATURE-----

--Rzq/nSLlHy1djmXS--

--===============4727356620187708708==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4727356620187708708==--
