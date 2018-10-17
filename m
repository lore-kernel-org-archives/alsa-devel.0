From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/8] sound: intel/sst: don't pass GFP_DMA32
 to dma_alloc_coherent
Date: Wed, 17 Oct 2018 10:55:22 +0100
Message-ID: <20181017095522.GB24097@sirena.org.uk>
References: <20181013151707.32210-1-hch@lst.de>
 <20181013151707.32210-6-hch@lst.de> <s5ho9bxn7ho.wl-tiwai@suse.de>
 <s5hefctm0m3.wl-tiwai@suse.de>
 <20181015095858.GA6277@sirena.org.uk>
 <20181017071900.GA23407@lst.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3538955828636038566=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0074D26759E
 for <alsa-devel@alsa-project.org>; Wed, 17 Oct 2018 11:55:23 +0200 (CEST)
In-Reply-To: <20181017071900.GA23407@lst.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Christoph Hellwig <hch@lst.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3538955828636038566==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gj572EiMnwbLXET9"
Content-Disposition: inline


--gj572EiMnwbLXET9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 17, 2018 at 09:19:00AM +0200, Christoph Hellwig wrote:
> On Mon, Oct 15, 2018 at 10:58:58AM +0100, Mark Brown wrote:

> > I don't have the patch...  in fact, having found it in list archives I
> > see there's also a SPI patch I'll have to go hunting for so I guess I'll
> > apply this one when I find that :(  Christoph, please CC maintainers.

> I tend to only add the list as there just are way too many maintainers
> for this sorts of series, and maintainers should read their list anyway.

For several of my subsystems that list is lkml, good luck reliably
getting anything noticed by a specific person by simply posting there!
Even with ASoC alsa-devel is also used by the general ALSA stuff so
there's a lot of noise, especially for things without the ASoC prefix.
I do trawl the lists but it's at best going to be delayed, especially
during busier periods.

The usual thing for things like this is to send individual patches to
specific maintainers (git send-email does the right thing with Cc: in
the commit body).

--gj572EiMnwbLXET9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvHBwkACgkQJNaLcl1U
h9AKxAf/WCxv5yUHzBNzR6Mx9msdkIXpQ58eVWjRbqfhJyhzhB4tesYIaTvS5ma8
vFht+wOjTgNk3CKtW0b0jBk5LAFUqx0tQzZZaefSceTk3brf/kblu11czJSQwXGK
q1lvbmdonJ58AotW/lC+kpvBlF94ZPqTpk5WsYnCuwMTLbIgB1RM0JjMwxJYSxzy
B8OjwnNXasiDwRlielTFxm+zXgtpt4X+WaoOHpZAbYyW6vuueaarjuA2ub1rpEKK
iNdHCv1U8t0VF2zWdAp2xpb1vfb4xQwIW8G21fWXEe/07P1q+pU9fpdpAvF5dhCX
yuUQi4bYcxzfHJQUCtph6mXV06kOug==
=eT6F
-----END PGP SIGNATURE-----

--gj572EiMnwbLXET9--

--===============3538955828636038566==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3538955828636038566==--
