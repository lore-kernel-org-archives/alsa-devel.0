From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm_adsp: Stop region iteration when
 the desired region is found
Date: Thu, 28 Nov 2013 18:19:43 +0000
Message-ID: <20131128181943.GO27568@sirena.org.uk>
References: <1385656671-18519-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3263031456903678357=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id D0163261A59
 for <alsa-devel@alsa-project.org>; Thu, 28 Nov 2013 19:19:46 +0100 (CET)
In-Reply-To: <1385656671-18519-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3263031456903678357==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HFD/Dq8JdnjNvyuv"
Content-Disposition: inline


--HFD/Dq8JdnjNvyuv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 28, 2013 at 04:37:51PM +0000, Charles Keepax wrote:
> When locating the memory region relating to a coefficient block written
> through a bin file we keep processing the list of regions even after we
> have found the region we require. This patch adds a break, so we don't
> process redundant list items.

Applied, thanks.  I didn't look but does the same issue exist in the
main firmware load, it's probably following the same pattern?

--HFD/Dq8JdnjNvyuv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSl4k8AAoJELSic+t+oim9yKoP/RqtqDtkhYq7h1ywR/uU3nLq
A69vGJnBzBiw7mxsMBNFthuzn0OKZYJRg66a4cxcDnxSXgRJFMLvF338ehTeXrzb
EjR5l074eOENqpkjP6HsVLdyiqX47Vv6Kf58iqfF6cahliR8DeCGq2elz5fxon4I
C427iOQJFcORNkuQf3+WM4Wr7+OEswXekA4ALeCbpEHoctopz13H8E8c9BtlLw8k
5+J0JKNc3ddeNhTXP7NPwTzt1qXG/xGHOD5xXcehJq/ovHPIo29E1Fs4XCUNVtN/
FH3O44DCP2h0kptKWDpkV6d2u5JyA91t4syuYTl2q/ASLtiO2m59MwN76rH1zgL5
ZpqDpcZ1dYzmJHkKHBGNhDZvZfHW3fVhfBpYLUv3dxpIyN9Sf96ZaA2IYzrDaMcK
0to0Tg+bB3u7kRo965mvKkSYTsv1zAdgYt1/BtRxQxnYRPLgbZTsz5dYTDAUn6yK
Ft98TmMhVdUTxVJQZkLMT0R8FPI46v3Vk2lxT3d2T7nw3Y+GB05Bto3Pu6HzZ1Ny
jsGWJHWk7vGtaxmC/I0Zt6SOpYXrDpBUCQ2sn1A869OlmyUW6ywrKIjL+ZpzUgKl
GsRfsN/s7vBO3dAPOrNM+SsgaIKCzCfmWXujNonZvZyU9ZqhOw07oY631Zp/kXo5
G8gXViSR+E1L0CMp6Uyo
=Y31E
-----END PGP SIGNATURE-----

--HFD/Dq8JdnjNvyuv--

--===============3263031456903678357==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3263031456903678357==--
