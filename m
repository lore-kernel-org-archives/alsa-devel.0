From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 1/2] ASoC: dmaengine-pcm: Add support for
 querying DMA capabilities
Date: Mon, 15 Jul 2013 20:51:45 +0100
Message-ID: <20130715195145.GB11538@sirena.org.uk>
References: <1373906531-6938-1-git-send-email-lars@metafoo.de>
 <20130715172643.GZ11538@sirena.org.uk>
 <20130715165721.GV16653@intel.com>
 <20130715175726.GA11538@sirena.org.uk>
 <51E43D6C.1050000@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8543967896005238563=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 945382617A5
 for <alsa-devel@alsa-project.org>; Mon, 15 Jul 2013 21:51:55 +0200 (CEST)
In-Reply-To: <51E43D6C.1050000@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============8543967896005238563==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qjo19A2vmS5T5MQB"
Content-Disposition: inline


--Qjo19A2vmS5T5MQB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 15, 2013 at 08:20:28PM +0200, Lars-Peter Clausen wrote:
> On 07/15/2013 07:57 PM, Mark Brown wrote:
> >On Mon, Jul 15, 2013 at 10:27:21PM +0530, Vinod Koul wrote:

> >Right, we probably want to set an artificial floor here but it still
> >seems like we should be checking that the device actually supports this.
> >If the hardware can only support 64 bytes then the above code won't work
> >properly.

> It shouldn't be to hard to extend the dma_caps API with a
> min_sg_len. But is this something you've actually seen in existing
> hardware for that the driver would make use of the dmaengine PCM
> framework? If it is more of theoretical nature we can still easily
> add it later if it becomes necessary.

I'm not aware of anything but equally well I made zero effort to look
and note that quite a few existing drivers appear to have minimum values
quite a bit above 16 though I doubt they are all actual restrictions.

> That said it is not uncommon that the segment size needs to be a
> multiple of the burst size. Adding support for that is still on my
> TODO list but will require some changes to some of the existing
> users, since implementing this will be a lot easier if all users use
> the snd_dmaengine_dai_dma_data struct for their DAI DMA data.

Yes, burst sizes are one source of restriction I've seen - probably the
main one.

--Qjo19A2vmS5T5MQB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR5FLOAAoJELSic+t+oim9krYP/2y0qZUmOdKfMWeQ9oNGrz/l
cEbADdh5mLSM4svQ++ooXQ29wGURoqL0JwdBNosoqfmXVB3HBGL1hdMQo9S8kHkE
K8+jfg5K7j0nyhqr80bUqy3IzdTAc0vkTWD87+6FWvMoIoiJ5dMbbBi5U/iHF0bk
9OaFxDArFMQ2GROdy+pOXhDE6CNiiZOVnIKpG1UtcqVOLs/JzzNVrJ2RYssOvaHw
HKWX44m7YsAcCLsNgvP5jNOLsreKwh41ALbm2y7rpaZntUI2v/LVQeLKUatp9SLJ
RK7jEXdKwGHhbZHV7KSaQYrJJfyVl3VcboRqjljW+ExNUvq60fcVLnEvTdw9RLFW
anHpDEOJqhyasxe0wHvzhvuuJzNQM5YB3t5Jrxsvy1UsHZTVIx9wa06YolB5VcsT
rFHpbIx3Nh1bLRcEI/nJXv1hqrgI8ICSnaDcdtvjL8NLKXu/dNTvkagqhcUsaqjR
ktiWf0iQX0K6JPysuU9gymJWmBeC4t0Vb62dsUvSOv3EiX6DqUETrZfdQAjv3eke
K3u1+MjfKuqrtfY4bQTNE0APpc21/6qq6bB4V2bcR3eKzyGESDP98DyWruriumPr
XsL8jkiKrbBTE5W+sKwyBAoDaItwpL7REMiP1fYKpwLxOt88QzLJt+7M5CSOL6R0
eU0Sieez3PYlycIZuHhp
=Nh1Z
-----END PGP SIGNATURE-----

--Qjo19A2vmS5T5MQB--

--===============8543967896005238563==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8543967896005238563==--
