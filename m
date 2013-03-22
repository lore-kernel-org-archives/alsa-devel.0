From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2 resend] ASoC: cs4271: preserve "Master
 Playback Switch" setting
Date: Fri, 22 Mar 2013 11:18:20 +0100
Message-ID: <20130322101820.GC22890@opensource.wolfsonmicro.com>
References: <1363895035-20356-1-git-send-email-zonque@gmail.com>
 <1363895035-20356-2-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8928599542819911409=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2D32026515C
 for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2013 11:18:22 +0100 (CET)
In-Reply-To: <1363895035-20356-2-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, subaparts@yandex.ru, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============8928599542819911409==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O3RTKUHj+75w1tg5"
Content-Disposition: inline


--O3RTKUHj+75w1tg5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 21, 2013 at 08:43:55PM +0100, Daniel Mack wrote:
> Currently, both the ALSA control for "Digital Master Playback Switch"
> and the ALSA core (by calling dai_ops->mute_stream()) control the same
> bits in the CS4271_VOL[AB]_MUTE registers.

> That's a problem for applications which intentionally want to keep the
> flag switched off from userspace, even though the stream is already
> playing.

> Fix this by keeping track of the states on both sides - the ALSA
> control and the ASoC core - and actually mute the Codec if either one
> of the two flags is set.

The usual fix for this is to just not have the mute operation if it's
important.  Otherwise this seems like something we ought to implement in
the core, it's not a silly feature by any stretch of the imagination but
it applies to any device with a DAI mute unless there's some device
specific thing I'm missing here.

--O3RTKUHj+75w1tg5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRTC/jAAoJELSic+t+oim9IloP/1ZcrPsqjy91XCjc+te6qYRt
T4EfkGBCzknEWDoTpneqGDP0GewjGlsKjAZmw2bGqwlJ1OqVKVqqVe+BHPrQPqJZ
DyzM9hT+BfE4C35fI/VDHId4XVAtEMKrQXfQ3xlNgDRN81d0d4jm/QndsEaGvmYV
VVC9HJtGgiM9p6jja56KQkTzRn+71lOp2GwYmcdiSmIwcBM9PEfgUS1Wbg64g70X
fYyBW3xJogtDV8IVMUESEknuYzrhxtb0r5EunYv5HpDKjVatyAV1EB5tXIBsb6YM
Szmh3HjPTGTLW86cIoxQizzOn47LWK8wuQcljDnycKBkPiPGGow8jkVY9lz4vRs7
aB0dW0yyapgVKhn8TA0XmyWCBA+iWoPeaynXcBNnRIkrjujWAdugnVCSJxrn0CCo
PGvC/SzjyzBWHIL1p7C9KhrIAJyqHZI3YkrpecDluhOQ6APtMLtYIeD5dAoRG8Vy
QuMTdSYxaKv3rmqXeEJWkXWrxSAU3z/yfG1T6eYTGPQ3J6wiffNp05NTNUaqAQPK
XGED69RdO0geJvbtL2KGcS8CfVn0nD/wFPt8abiWh33zGxDvuG+T+4LlnD7cEtsv
p5tAwuyKjSbvqMn8kDedIMDh44U+cQTLL/goO4ErFk0wrV+bl6jTM/sW7za+05+L
fLin7OlM8vs73SPxBsbt
=O/6E
-----END PGP SIGNATURE-----

--O3RTKUHj+75w1tg5--

--===============8928599542819911409==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8928599542819911409==--
