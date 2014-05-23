From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl: Remove dependencies of boards
 for SND_SOC_EUKREA_TLV320
Date: Fri, 23 May 2014 17:09:24 +0100
Message-ID: <20140523160924.GD22111@sirena.org.uk>
References: <1400843461-24991-1-git-send-email-shc_work@mail.ru>
 <20140523112456.GC12304@sirena.org.uk>
 <1400858367.778647362@f210.i.mail.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7428018008756092620=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AFC032650FE
 for <alsa-devel@alsa-project.org>; Fri, 23 May 2014 18:09:57 +0200 (CEST)
In-Reply-To: <1400858367.778647362@f210.i.mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7428018008756092620==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="t68BHbxK7znCsyk3"
Content-Disposition: inline


--t68BHbxK7znCsyk3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 23, 2014 at 07:19:27PM +0400, Alexander Shiyan wrote:

> Yes, now I see.
> So on my opinion the true method is transform this board (for DT case) is
> to use generic sound card. In this patch , I just try to remove non-existent
> symbol dependencies, so if we have is_machine_xx checks I do not know
> the true way, since cannot test this.

Yes, transitioning to simple-card would be ideal if you can do that.  I
guess we can apply this one for now since it doesn't make things any
worse at least.

--t68BHbxK7znCsyk3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTf3KxAAoJELSic+t+oim9Rd4P/AspGyteQ0cFl9LlQaeF+G0b
fEPVS64Gt2bzclvPtk3lSrPTuJP+RoQkir9HhigfrvW6nFMEaAllnJlsysXKn2mI
v0YGJNu/0nQqdHGDTbzf/nb5cEX5i4VdPMdoscUB3ZjR0tv0ptCiR+jmZanAmJzT
JIwN9Kp/l6O1PJ/iKZ2fUTlgB31qqPUpy6wNlb49jBRxp/F0FtZRbenn4gP7ke54
7XJUCiIEYT6TZ6pwSRn9ViHodH9RbE+nROoE+yS5lgQ96MeBtJCZ0iMv/3mUe7NB
N8OwJhsNGVIcIDESOE5l2c9KGIfVSkQjIuuTLDg5Gnepode6lRW6ONZ4kJRy26X9
43xaVV9cZt/6GZ1wEuC0m1gKH/NgQF5B33b/TbL06u9yLPnaULzRvT/NphPXdGmO
bqcREphJkcMAr0uF+WbV6dAx+Ex0pZnCx6dPi/Df1k4Yok6sAQbruxqh0o0N81ZV
kuKv2+Is0l3DO1JmejkIrEpu4cmG7veaxKFKtNzbYL8rifv38P1uE9VGTDRvNUuq
xxlG7qY47y4XFKa4cYXpsZAgMrXcUL7uP7LwnWzc77CU1uTA57gQvcI/fMtQXLhR
VJKLi76lpD6Mu4ND2pQwvgWBL/+Vg7ERI83L+REXoVM/b8odEpzbPWRkOEITx2Oz
2ypJQZY+cW6dTkB2ef2L
=iuaV
-----END PGP SIGNATURE-----

--t68BHbxK7znCsyk3--

--===============7428018008756092620==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7428018008756092620==--
