From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 0/2] Add snd_card_disconnect_sync()
	helper
Date: Tue, 17 Oct 2017 21:05:39 +0100
Message-ID: <20171017200539.vjmxs2g3aat5zntx@sirena.co.uk>
References: <20171011101618.8736-1-tiwai@suse.de>
 <87fuanv70u.wl%kuninori.morimoto.gx@renesas.com>
 <s5hfuano5k0.wl-tiwai@suse.de>
 <87efq7v2qf.wl%kuninori.morimoto.gx@renesas.com>
 <s5hh8v3pelc.wl-tiwai@suse.de>
 <87k1zvn8ci.wl%kuninori.morimoto.gx@renesas.com>
 <s5hvajfxfx0.wl-tiwai@suse.de>
 <87k1zu7g1l.wl%kuninori.morimoto.gx@renesas.com>
 <s5h7evuxdop.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2517304043842638103=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C750266D69
 for <alsa-devel@alsa-project.org>; Tue, 17 Oct 2017 22:05:44 +0200 (CEST)
In-Reply-To: <s5h7evuxdop.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============2517304043842638103==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yuv4zy3rf2vrbb5c"
Content-Disposition: inline


--yuv4zy3rf2vrbb5c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 17, 2017 at 12:37:42PM +0200, Takashi Iwai wrote:
> Kuninori Morimoto wrote:

> > I'm happy to solve this issue, but I'm not good at DPCM.
> > If you can give me some help/advice, I can debug it.

Honestly I'm not super good with DPCM either, Liam wrote that code and
I've never needed to delve too aggressively into it.

> It seems that the whole disconnect call can be dropped for the BE, as
> it does nothing practically for the register callback, either.

That feels like it's going to blow up on us at some point...  it's
probably right for most things though.

--yuv4zy3rf2vrbb5c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnmYpIACgkQJNaLcl1U
h9DT3wf+O6bJI66SYdZQ/VOJrah+gveeS3C+Ja69Z3uOtWs9PW7OwgnjN0l+4V47
hJ4UrA+suJeilpHlck1oA3vkAwf6ixb230Tza/6Fwze5bjSko5HExpnTms5vsoYx
QgASpXfOqk5nGxen1sGXwbj7PObqK3oLhTmx0FQO9E6i9U17ZbCE0Q3BiWcTWjDO
tmjWAPBCZRj/UDGW9f2imSONr2yDUuzftvb4uJpVhpSa3htnMcDC076SHo8F4Ohq
FQaCs5MD2RGsul2iY3MTGFpHwoJXMTmAYcq2KzTprvP+5vPPQF88sfP7yh0aYStC
lJJOmo8ad2r+23X11KS2V10A+M7xhQ==
=N3/U
-----END PGP SIGNATURE-----

--yuv4zy3rf2vrbb5c--

--===============2517304043842638103==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2517304043842638103==--
