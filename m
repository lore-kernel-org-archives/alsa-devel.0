From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: ak4642: cleanup struct ak4642_priv
Date: Wed, 21 Nov 2012 13:27:47 +0900
Message-ID: <20121121042742.GM4673@opensource.wolfsonmicro.com>
References: <874nkk4nyl.wl%kuninori.morimoto.gx@renesas.com>
 <20121120094324.GD10560@opensource.wolfsonmicro.com>
 <871ufo4mku.wl%kuninori.morimoto.gx@renesas.com>
 <20121120103849.GH10560@opensource.wolfsonmicro.com>
 <87sj83oa6w.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2621331601637194485=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 64D3B2651D0
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2012 05:28:08 +0100 (CET)
In-Reply-To: <87sj83oa6w.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lrg@ti.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2621331601637194485==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wKTlTxfx0Fr6BT7S"
Content-Disposition: inline


--wKTlTxfx0Fr6BT7S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 20, 2012 at 08:24:10PM -0800, Kuninori Morimoto wrote:
> This patch removed struct ak4642_priv which had
> meaningless variable.
> It is no longer needed

Applied, thanks.

--wKTlTxfx0Fr6BT7S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQrFgpAAoJELSic+t+oim9z5IP/0CT1uMhkDDrpKpqNCc6i18/
rDviH5YXj06+yHGUM6BiynOAThB9qn4ftHTQK0jSC7/oA+UTvspyyqFjYCNNktza
BR1lB5bx72d38Co5d0sXa/5tlfdUVthbSiJLRoBJ3JP0qmS9v5aDsssRJ3liNK/6
rMTuyg39KKli1yujIl0YufFo62xUtRtZCWZ96e6vznEE/SUP3raCUJztsJHXPcxe
IZ2Mra1xpmw/vKfV148SMlCdLmR8J1X+wK7i9ImRHYTlDgcb3QxSmZW181VGjN7d
NSknzUvBZ44ZMWtROiW72soeiw2gECQbpZlxTj0brxn9wUkn/ST2/8mDfzwO3+M5
j2WteRriFKl/DjgcBfCN+nIEk9TrJvHbVdwgNltCWT1mou46/Fc5b2Bsf6mvnp2N
r1ABGGgPj9FT0EIkLoeCf2LjFTBk6HG4UwrWGcF247XNmTqsoUlp0/tx5mOfZ+sJ
rCQLGVmQeGi5s0Axt6n241YdUkrIRXiCvieS0EykDmaI1y2N1A3kX5JYr34tZFsV
eWEISz0jI1KVTQBsy0Lye0Ou6u8vJUua0rDb1DrAXCe+ETBLMotSyWGLil+sso2U
eoPfyMw6CEy1CPZBM8ZpQlZdgnuDToYz+4crdBkwkvHLqPnVSpGyP5jY79ttuwZy
+nApt35kVqwuREuGdkFI
=PNJH
-----END PGP SIGNATURE-----

--wKTlTxfx0Fr6BT7S--

--===============2621331601637194485==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2621331601637194485==--
