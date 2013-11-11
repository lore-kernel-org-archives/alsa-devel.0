From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V0] ASoC: pxa-ssp: add TISSP mode support
Date: Mon, 11 Nov 2013 11:21:15 +0000
Message-ID: <20131111112115.GF2674@sirena.org.uk>
References: <1383640208-11919-1-git-send-email-zhouqiao@marvell.com>
 <20131106112421.GI11602@sirena.org.uk>
 <527C43D0.2030301@marvell.com>
 <20131108101948.GD2493@sirena.org.uk>
 <527EE65D.3070804@marvell.com> <20131110111021.GB878@sirena.org.uk>
 <52803B02.6000008@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8767662914603496245=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id B9C65260886
 for <alsa-devel@alsa-project.org>; Mon, 11 Nov 2013 12:21:21 +0100 (CET)
In-Reply-To: <52803B02.6000008@marvell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Qiao Zhou <zhouqiao@marvell.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Eric Miao <eric.y.miao@gmail.com>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, "trinity.qiao.zhou@gmail.com" <trinity.qiao.zhou@gmail.com>, Chao Xie <cxie4@marvell.com>
List-Id: alsa-devel@alsa-project.org


--===============8767662914603496245==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V4b9U9vrdWczvw78"
Content-Disposition: inline


--V4b9U9vrdWczvw78
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 11, 2013 at 10:03:46AM +0800, Qiao Zhou wrote:

> Yes, it should be an improvement of current driver. The format is
> not a new one, and the DSP_A mode is suitable for it. The question
> here is to handle both PSP and SSP mode here. should I pass another
> parameter here to support it?

Can't the driver just do whatever is best automatically - why would the
user need to configure things?

--V4b9U9vrdWczvw78
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSgL2oAAoJELSic+t+oim9j3wP/2f+BihdvU4M+yRWitydytA9
d+H3a4XBiiRRdfmgOJaATF2iVwy8Z9+jstKZjAz5aW9V5zf2hRU37BppRg3PDZmE
uau17pkZIsluQ4P1Av4wUuWQNMqkTt3FKpz1dgFCKUTdlq26N3nPEw8pjVB0zokr
crdbydqe3w5edMoEculU+Kgfw5ujKbf3JpVu148pY7WRwIJSwwHtVRdDIz3oS5yK
W3phYO76g8IpKIzCsfzSyQCfi6z9yO1B5pGLkvyC5nNd1D2POD1owQdwFEOC6DxB
A4ZWt3MbkAFqsz/8+9hkLXiY1OG052oYJfixDx9wnanSvKC8aNlnZm4uzvWqAFsF
rTp2ahEhtbxkHIaoBm7UDjAj7A/9JW3FYaGQIGM17JgFGeyeej0CHpsRz+NVe7Tk
PRiqDGdBTVGGf6zTqJUmyKPZAaFr6Cb0ot+gfuTBjIwzDdA6dLod80jnB8WGCQ1X
UQD8zUm870xt1bWzCz3e3LfEqY6SP0nzWyR4pQsr6H5Cs9nLERSQWWIZAGWrED21
3uxCfBshoru4CwqT30Px3tahMtJbM5EuI17kykaHJujeWs/kbDrPYhHcV0PWEwEN
FKxEN1Q0oJacr4WpcCgBz3DgIRQzR9EZYX1SzfbVukJAUiX0HDdY9lz7z6gpteoW
2nSKr7eUHe3MU8GkRM7y
=rhQf
-----END PGP SIGNATURE-----

--V4b9U9vrdWczvw78--

--===============8767662914603496245==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8767662914603496245==--
