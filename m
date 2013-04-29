From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm8962: Convert to
 devm_input_allocate_device()
Date: Mon, 29 Apr 2013 11:19:59 +0100
Message-ID: <20130429101959.GE5019@opensource.wolfsonmicro.com>
References: <1356009506-4766-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <CALq1K=+sJUZ++_sMkU1Sg9+aE-HpF1tnfPHGCEJ789hj19Yp9A@mail.gmail.com>
 <20130425125234.GV5019@opensource.wolfsonmicro.com>
 <CALq1K=+ViDvsCZDR5KndX-T1Dt6tghPjiP7F6wm+npYOw2DE1A@mail.gmail.com>
 <20130428094745.GA5877@sirena.org.uk>
 <CALq1K=+=J9oPGvbrXuhS=Bgqj+viC5EAkTHKkNuHxBadExpXdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7620928356445702756=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 850C52619FD
 for <alsa-devel@alsa-project.org>; Mon, 29 Apr 2013 12:20:01 +0200 (CEST)
In-Reply-To: <CALq1K=+=J9oPGvbrXuhS=Bgqj+viC5EAkTHKkNuHxBadExpXdA@mail.gmail.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, patches <patches@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org


--===============7620928356445702756==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Tk7bxryrhVQGv1nz"
Content-Disposition: inline


--Tk7bxryrhVQGv1nz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 28, 2013 at 09:32:18PM +0300, Leon Romanovsky wrote:

> I think the reason of our misunderstanding is due to the name of
> input_free_device call. From the code, it is device destroy function,
> and the freeing itself done as an error handling of
> input_register_device
> (http://lxr.free-electrons.com/source/drivers/input/input.c#L2114).

> How do you think we need to proceed? Do I need to send patches with
> explicit call to input_free_device function?

I really think the input API needs to be looked at here, this is all way
too error prone.  Calling input_free_device() on something allocated
using devm_ looks like an error itself...

--Tk7bxryrhVQGv1nz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRfklIAAoJELSic+t+oim9y4QP/0UoQGAzXVoWpYSJ7oGcIfxl
Q/ceE91K9MUOgC6zsTG+jhr7XJUXmq4bssHYJetrqbbdfB2tDdtDA+WMYpC0D2po
BNo6fbWc/pZiA/3OmlkbCnQ4r9vVs5H0yDrgsHD0j8AKv/l6LaG4zmpRwPeMKN83
S+K3Gg9rxpn1hZj/IULN30X0AQSE5Wf7E2Eqbcdou4crUA7/weV1q90cJUixyvGr
//TCZn/Xt9duTuM1kZPcr+DaE3E8k/pvRYjT+j7Da8SPrHe72jhL9R7l4BnWjnxG
qpdG/3ek6cyzXM9hrTEgcSuWf88FmwdQRnyZj2eY9mv6dAzHRDqyTLbWnRHFByYY
tZcR5KotRrvJnyVT/o8bpfIym8nxpRdcyLV7WePQfjQP4Pkd0m5+9RuMbNpSePxZ
SzNzEjtgfiHgfsrpUcyKUaUK2SYA5V2oDHlgk014VnvkKiy4FhYgrYPuKCabBpsN
AawW/xyWWpRxFllYcAXNQar27Zf05cis/7iT5aGcJR9WG4mW7hfk5HI+6XQap3WO
qiguuaR8HDrYDItdC6EgMd4Q7pbtKanzbGFUGhOWQBL0lyoo5CfBbbZwwg4KdXi0
vv0Y5vZVCe/Bm0AaM/ZMadk93jkZ77GFWUZ4Mqyf7gWHUm+sZwd88PlKTlrbutKS
erPmjuUEF4z8cs6DOID2
=uw1f
-----END PGP SIGNATURE-----

--Tk7bxryrhVQGv1nz--

--===============7620928356445702756==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7620928356445702756==--
