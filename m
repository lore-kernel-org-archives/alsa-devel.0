From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/5] ASoC: Davinci: pcm: Add device tree
	bindings
Date: Wed, 22 Aug 2012 16:58:08 +0100
Message-ID: <20120822155808.GP7995@opensource.wolfsonmicro.com>
References: <1344948125-5649-1-git-send-email-gururaja.hebbar@ti.com>
 <1344948125-5649-4-git-send-email-gururaja.hebbar@ti.com>
 <20120817223122.GA21445@opensource.wolfsonmicro.com>
 <1BAFE6F6C881BF42822005164F1491C33EA67DA1@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8120512297307371117=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 33C9126613C
 for <alsa-devel@alsa-project.org>; Wed, 22 Aug 2012 17:58:10 +0200 (CEST)
In-Reply-To: <1BAFE6F6C881BF42822005164F1491C33EA67DA1@DBDE01.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Rajashekhara,
 Sudhakar" <sudhakar.raj@ti.com>, "tony@atomide.com" <tony@atomide.com>, "Nori,
 Sekhar" <nsekhar@ti.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "Ujfalusi,
 Peter" <peter.ujfalusi@ti.com>, "Girdwood, Liam" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============8120512297307371117==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uIq33vy618f2J7at"
Content-Disposition: inline


--uIq33vy618f2J7at
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 22, 2012 at 01:50:09PM +0000, Hebbar, Gururaja wrote:

> From your for-3.7 branch, I could only find such implementation in Tegra
> Platform.=20
> Most Freescale platforms implements this through a device/driver method.
> Exception being sound/soc/mxs/mxs-pcm.c

> So should I follow tegra implementation?

Tegra and mxs should be good examples, yes.

--uIq33vy618f2J7at
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQNQGJAAoJEFJkBDiqVpZ4O2MQAIMb22zAqnOU8su/FurwKoFf
+8AG1i3wSfX7GNjakSduYhdhQGrNfCgQGmAHDLPur76/N9/TbBqAQ3elJqP+9Hxw
GzJij9K+XsWT2uXEKeuIayAQkgk4RdnsXByvTxCzuvjDA4zEDGQA0DThHaf1jWQu
lHG4eI7qUcbt8sCJUTtC0E/n+es56HD5H0jCYEQlL03ifhVRVkNWbyod7cXfHPW0
ohHw6uBSTwY43//o+JAnau9ymdN06yE3AblGaxSi6rwYt/6L3MYe8YuIyil9lcW8
ufHyU0cuCUpmBi+0fIm+KX/ZHGWqTMcUEUR2u9OP4cjMT1ROnLDksiRbXUNiu6Un
6fOFok4jus4BAOfVxbVMl7K87I8EUVV10IQH3TLu2UHo4EGExam4oIdrY0cEdbHz
4N2u6CLovEJ8G1QuTauX14KA/+SLGDzWEcJ8fD3bcO2lETrLwOEWdNqfPYkxmFn3
0K8d0VtJOvYdioTdUhdYfYc7gt84CBdtylfRizR+O7cwP/QcHMevmSy9vMmlrve4
IrKNqy2WFsbYiANVVUrsyh5gFxiHg0PEsYn9m7fu7/10dq9Se2TayVBQXf/p9k0C
U3icmzmsWV+8IRG0FZd7i29v97GEXF5qi+kYgupHpgVhA+Iwm46z2GZlvCs3R3Od
QgkNCjccBlHT6Oqd/+v4
=VdVq
-----END PGP SIGNATURE-----

--uIq33vy618f2J7at--

--===============8120512297307371117==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8120512297307371117==--
