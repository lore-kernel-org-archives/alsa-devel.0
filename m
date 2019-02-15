From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: simple-card: fixup refcount_t
 underflow
Date: Fri, 15 Feb 2019 17:31:08 +0000
Message-ID: <20190215173108.GF7897@sirena.org.uk>
References: <878syh8svy.wl-kuninori.morimoto.gx@renesas.com>
 <CAEnQRZD3CRzHDd-eGbVWqBUmNuqGaXJwTboQ3v1TnZAN3B_4bw@mail.gmail.com>
 <CAEnQRZC+jDPRLhNEY5xP9AFxvqFvjBVRDxVfNbgfURudXuO1FQ@mail.gmail.com>
 <20190215170257.GE7897@sirena.org.uk>
 <s5h36opvugv.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1132870278991968770=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id ED1EA266A9D
 for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2019 10:20:29 +0100 (CET)
In-Reply-To: <s5h36opvugv.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Daniel Baluta <daniel.baluta@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Vicente Bergas <vicencb@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1132870278991968770==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="O98KdSgI27dgYlM5"
Content-Disposition: inline


--O98KdSgI27dgYlM5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 15, 2019 at 06:21:04PM +0100, Takashi Iwai wrote:

> Actually it's not all.  As mentioned in my earlier post, there are
> more of refcount unbalance in the code.  Lots of them, really.

> Below is a patch I've fixed quickly over the whole scanning the sound
> tree.  Some might be incorrect, so more detailed review for each piece
> of change is needed...

Extra references aren't such a problem for practical systems since we
don't actually ever free any of the DT (there's no mainline way to use
overlays yet...), that's how none of this stuff ever gets noticed.  I'm
not surprised there's loads of missing frees TBH.  In contrast if we've
got extra frees they will get noticed and cause problems.

--O98KdSgI27dgYlM5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxm91sACgkQJNaLcl1U
h9B8cQf9FB7/Is+3tNAzqFSvyTdyfirRKAjeQ/jwbeMowSrNWO3jg53AjTnVRErR
hladT1liA0NV2UfbXKhHSwyX4oVF5635enW6yKoObXWmbaqhbx/bUrBre3pf+wV7
RoduO1Lw/EXQ9G0kWibC2un/8bZVqHGD3cHEqB2ceRWH0Mzpg+MAIz3hvm8eQg4o
/c1n3CxlgCTVcfpgIuAcJDQ6d9w8tEMVsqsuYjrcJ4fYorKGWGbkbZ2+gC2NN+ue
zZ4vxZENZBaqIVGW04cy7wiGy50eA44cnLBarW2SBjhnSrjhEZNAqprnKQyJUO5b
FBwwGpuSPR29h9k+cvbtiOZwTKkeEg==
=xxOQ
-----END PGP SIGNATURE-----

--O98KdSgI27dgYlM5--

--===============1132870278991968770==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1132870278991968770==--
