From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsi: reserve prefetch period on DMA
	transferring
Date: Mon, 26 Aug 2013 13:02:55 +0100
Message-ID: <20130826120255.GE10783@sirena.org.uk>
References: <87ioytuffh.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2661636858171280901=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 21764261A79
 for <alsa-devel@alsa-project.org>; Mon, 26 Aug 2013 14:03:01 +0200 (CEST)
In-Reply-To: <87ioytuffh.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Tomohito Esaki <etom@igel.co.jp>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2661636858171280901==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X3gaHHMYHkYqP6yf"
Content-Disposition: inline


--X3gaHHMYHkYqP6yf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 25, 2013 at 11:36:23PM -0700, Kuninori Morimoto wrote:
> Current FSI is supporting DMAEngine transfer,
> but, it needs to use work queue.
> Therefore, DMA transfer settings might be late if there is heavy task.
> This patch reserves next period beforehand on DMA transfer function.
> Android sound will be breaking up without this patch.

Applied, thanks.

--X3gaHHMYHkYqP6yf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSG0PrAAoJELSic+t+oim9MGIP/3SrrcBcRvur5laMkfqLX6xk
uDvjnvQInkvuQW+bWFeOu8Y/+mcyQ1xMaIlCJMitLcKhdiIqgRQJyPdSDKylDxu0
H0SJmvz536RdViuaAi8O9WSDTGjPh++GEWkANrWZ4zkQBaH/Csfu05P1GCpEZyOt
HFu4tlbrP/g/hqm9ZOrc21a5UsDM7A8tOijIkbohr8xxkat6ZCm3PfkF52FZ58O4
0fJ0qhPVR5pHkhksj5aRjwnb0XTuVej6EcgWjcZ+CVKKf8VwtsfUCIxqpIsPBjhg
wQcjpgEjRsDXKSHPZ5cSPFTF718kf5XsOl+A9vjhL6DjqiuYzMOv0TzOYU7UVY8I
TYl3GX4tQ+SD8nd0mjQRYKlavWEpU6Emo4WJdataKV3JX8UFJAG616aqS144Lv8D
H3mDZRJt0ngHeoXS0rqyCpOPxW8yckzIcQMkfAHj2Ta8Wu9EkmAIfoaLcAQ6cPLw
mu2aARwuJhFPrnAniOQnF0NLQaqPGZWSRAxZSeEupwFNmOSqe+tkCnWPjHY/h6XL
YmgT7SjD/ktyX9zV9YjzlfNc90Ag/pAaYfHGXEI1djCGNBwVi7Q2htsUkyVvr7HF
ToWxVirQWPoZitRF1DLQGlNJQqxdNMaO6g3OnB7e4Jzr5AFBDm4CfwgU3H6ZwvTp
Mx/DBNOZ8vzvn8b9jgwt
=SbxF
-----END PGP SIGNATURE-----

--X3gaHHMYHkYqP6yf--

--===============2661636858171280901==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2661636858171280901==--
