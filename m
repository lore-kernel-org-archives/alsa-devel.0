From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: ASoC: pxa-ssp: atomically set stream
	active masks
Date: Mon, 19 Mar 2012 13:05:37 +0000
Message-ID: <20120319130537.GC3130@opensource.wolfsonmicro.com>
References: <1332144773-3263-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8365282644520841922=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 91D4010401C
	for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2012 14:05:41 +0100 (CET)
In-Reply-To: <1332144773-3263-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, stable@kernel.org, s.neumann@raumfeld.com, Haojian Zhuang <haojian.zhuang@marvell.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============8365282644520841922==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GPJrCs/72TxItFYR"
Content-Disposition: inline


--GPJrCs/72TxItFYR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 19, 2012 at 09:12:53AM +0100, Daniel Mack wrote:
> PXA's SSP engine fails to take its current channel phase into account
> when enabling a stream while the engine is already running. This
> results in randomly swapped left/right channels on either the record
> or the playback side, depending on which one was enabled first.

Applied, thanks.

--GPJrCs/72TxItFYR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPZysIAAoJEBus8iNuMP3dn9wP/3jvXUSQZiKjQL2Y9aW4qMex
x59L4hXhItH9z3MksV2WiT8Oug7fmEevZ8NyBfho2QDfdhgXxAgyl0tVNOmF3ONV
jxbRWlQUtaULAzLkODdhoFhs7qfxM0y6Qmj1DHhA9ZEuuLa3GDNBN09XywIVDeoK
lGSahUg0Q52cJC0lBSkurkcptek/loC9HB7cgFxInizjCrbxFF2FpAZpbI7c+gnF
DU/JsSmh2FsFOCf2Hf92KCXGMXUo8fNRzBGo8gZIZx1+BCIsQd0SLs34BkzhvVFV
JqAQffsVDBW5dFit+Euxrr64i6p4378BCR6PTj0kgFnqyHhYDoFPaaZRoKT8GFrT
eowh/2ybkNZKQara52NA4FYkyCus1GAAGFS1NTGV4DmCHOhS2KvfWsM/LUAMHyZp
lVDh/j72sMhXxzLpkK7x0UnefMAr6HAMriSR/YtYLDSJnYWOw5UbwGuDgulKgOJX
xfX/gx5tQt3idX6ss3/gGvM7UkwcTXbqsC+2KnN44aLDTAkc84v1LxkQNvVWAMKa
jo6uWFGAxcCt4gzK5TwYnZaCPZADkb4IpcjG9kTmUOeIUARmj1UgUMrcPs8F1fu+
Wa+YzcyWV6PxXjGCZrhCqgmKOP8I9j7utQf5axQTi8w77ylzdJwJjJGa9dpm26et
1P5qRVj+Xp1YRMaBzr5l
=8bR6
-----END PGP SIGNATURE-----

--GPJrCs/72TxItFYR--

--===============8365282644520841922==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8365282644520841922==--
