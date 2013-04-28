From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm8962: Convert to
 devm_input_allocate_device()
Date: Sun, 28 Apr 2013 10:47:45 +0100
Message-ID: <20130428094745.GA5877@sirena.org.uk>
References: <1356009506-4766-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <CALq1K=+sJUZ++_sMkU1Sg9+aE-HpF1tnfPHGCEJ789hj19Yp9A@mail.gmail.com>
 <20130425125234.GV5019@opensource.wolfsonmicro.com>
 <CALq1K=+ViDvsCZDR5KndX-T1Dt6tghPjiP7F6wm+npYOw2DE1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7319389199482173470=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 4AA37261645
 for <alsa-devel@alsa-project.org>; Sun, 28 Apr 2013 11:47:50 +0200 (CEST)
In-Reply-To: <CALq1K=+ViDvsCZDR5KndX-T1Dt6tghPjiP7F6wm+npYOw2DE1A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Leon Romanovsky <leon@leon.nu>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, patches <patches@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============7319389199482173470==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 28, 2013 at 08:00:29AM +0300, Leon Romanovsky wrote:
> On Thu, Apr 25, 2013 at 3:52 PM, Mark Brown <broonie@kernel.org> wrote:

> > This seems like a bug that should be fixed on the API side, it's really
> > not what you'd expect a devm function to do, and if you are explicitly
> > freeing a devm allocated object there's an expectation that you need to
> > call a corresponding devm cleanup function.

> I can't agree with you about the "expectation" - device memory can be in use.
> This code will free memory after all references will be freed.
> Additionally it is up-to developer to decide what to do if
> input_register_device call failed.
> According to the code base
> (http://lxr.free-electrons.com/ident?i=input_free_device)
> the patch is not correct.

Right, but what I'm saying is that this is not how a devm_ API is
expected to behave and is therefore at best error prone on two fronts -
both due to the fact that you need to clean up explicitly even if the
resource is not actually managed and also due to the fact that the
regular free function is being used rather than a devm_ one when
explicit deallocation is done.  Neither of these things is normal for a
devm_ API.  The behaviour you're describing says that the managed
function should actually be registration not allocation.

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRfPA2AAoJELSic+t+oim9dAYQAJLm58IRz8/s/qk/iBRXtj+z
BRRAbrXs0ypviyr1o+E0UBUzL4wUFsd9lHpysr19miZ59IRz6tSZvb9W1ZTudiVK
aStZZQgMDy/Q7c6JC5+0rPSuOpmVHlQ7oyvUF0JAzwQwKSVpDDcFWzJTJEoG/4Oe
4a7ILooQYGVwX0JzwrLlb3RtsyoUrbTxU97jLx7eAObxAnIK1CfF68RbOu1eN0+k
bm7vnKHyXzQeekNpuCsDTdCGkIl1W6ZpGI/JYzIPzIvmtYZCN2rQsLYbVYFL5Qy7
d2wXUH2oKq8GsoOgKl7i1p4rmR8SnjTlNpp1eQlF8itZuaI3qIz+CL/nAiTmmaIe
1TnDSVXQk07GlUaTtwQsC2ZAerDT6XwVICgG0fV8+y6dGLaiag4g1ZUFWBA4kGcX
SNkkaXsE6T4/fGGRgz5lDOHTybixE+ZjP8r7Iw61TdvW4sz1BFY5Wr3lauqoaT6L
8BPXZHB+AH5bqPjNYf3lbjBkBDV+wmlTwixCu45rVZMLrgCvGkemWWC9QHTZid6M
gcGcF2BztLH22KKsovwfDhj6euKROMYnRdn5KaW6q22EwaCDLTVa4fhoWE/y6Jft
A/sA557xZTr7sZimVyArXGndORDc7urNMV39uup2fEoraLKTw0EbKstlkyla73QD
LiWFrIJL2dpz0bWqX4pU
=COcb
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--

--===============7319389199482173470==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7319389199482173470==--
