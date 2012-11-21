From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm0010: Up the completion timeout to
 20ms instead of 10ms
Date: Wed, 21 Nov 2012 19:53:06 +0900
Message-ID: <20121121105304.GD18117@opensource.wolfsonmicro.com>
References: <1353494864-29289-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2891876684884020476=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1DC82265CD2
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2012 11:53:33 +0100 (CET)
In-Reply-To: <1353494864-29289-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============2891876684884020476==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="at6+YcpfzWZg/htY"
Content-Disposition: inline


--at6+YcpfzWZg/htY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 21, 2012 at 10:47:44AM +0000, Dimitris Papastamos wrote:
> Increase timeout to be more reliable and avoid the chance of
> missing interrupts during boot.

Applied, thanks.

--at6+YcpfzWZg/htY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQrLJ5AAoJELSic+t+oim9EtMQAIkGg6M4kE2ePJCfjlU9rkTt
GXBWxtWeTYATDuDfzisOeFOlEwvzVXTNo4xLn1m0PyX1FAO6b1GNJ6c4koaIhtdw
5Oe+PGQ4HUINS9EwWMCuM+M+SDR8TjAeiPvNwwWjRPQBO7V8MHC1U0KHMBjID6E3
XvhrdlvkE8Mb47macz8VRZwJanhwitZGypm7Azsrpu91lPa7zDRw6allYLyDd5GM
EwYFFSB5jmmbh8VYEtGU6G4j3diEac82B+IlBpClzK69aInUpFvQMVNR0a8ijBUh
xReBUVUJpWYYJ/K3bJsxDpp34f6FktBUmC32gkTqV5tML6mS8bswTNf6WTC9fWLu
Rdc31wjnhtoXSyJjxc2q4nq2TvVbl+Ft8PShaBz1ssABq82j0dUt+f4Rq9PXDdNo
fv+c/CZZRl48cgnH9Hasv4RxmfderBdQGXeYeN72lxJyD6DM28EafqV5BpwTRssz
Mp7hGG4S2cmOwRmEfyU108BCd79vxsfl4PALVBx/Ur+P3CcCD1o/wCc4IV+QPK24
FttsCKLBeejyAKfmyMG1notoAfGgHiG4VAY5caUNtox+i1ChXW3m9pIgxLd8pPUK
AeyCT+yxt6r9pmh/vv0CHEPcaVU4+g5mfeICFjrhENDimaiXBgXavgc3yJ9BF6Hm
YqjJI+6TrfWNxwXNgS65
=xyth
-----END PGP SIGNATURE-----

--at6+YcpfzWZg/htY--

--===============2891876684884020476==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2891876684884020476==--
