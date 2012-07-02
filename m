From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: tegra: use sound pcm library for
 substream dma buffer
Date: Mon, 2 Jul 2012 10:56:06 +0100
Message-ID: <20120702095606.GB25093@opensource.wolfsonmicro.com>
References: <1341219273-7439-1-git-send-email-ldewangan@nvidia.com>
	<1341219273-7439-3-git-send-email-ldewangan@nvidia.com>
	<s5hehouv81c.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6005443470990033035=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B6DA5244E1
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Jul 2012 11:56:07 +0200 (CEST)
In-Reply-To: <s5hehouv81c.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, swarren@nvidia.com, clemens@ladisch.de, linux-kernel@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============6005443470990033035==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jho1yZJdad60DJr+"
Content-Disposition: inline


--jho1yZJdad60DJr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 02, 2012 at 11:14:55AM +0200, Takashi Iwai wrote:
> Laxman Dewangan wrote:

> > -	if (!card->dev->dma_mask)
> > -		card->dev->dma_mask = &tegra_dma_mask;
> > -	if (!card->dev->coherent_dma_mask)
> > -		card->dev->coherent_dma_mask = DMA_BIT_MASK(32);

> The mask setup is still required even if you use the preallocation
> helper.

Though that code is at least notionally buggy anyway, it should be the
DMA controller device that's used to obtain the DMA mask rather than the
card device which is basically unconnected with DMA.

--jho1yZJdad60DJr+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP8XArAAoJEBus8iNuMP3d0GcP/juy+KjjowfRcD0fujfsEhbh
abBRaq1KnHqdZY6xtDA9sYhy/raKAV8w4sigRJR+ItLBmxPv+PrsRAcTVEdkVzk2
0Iej5OJy53l3o2uqrgdzuC7YdP2ExOJMfHh/rcKV27NldNhHZogIdKeBAeBOcXc7
xcqkom45yV4WHq9goessJ09gzy2mvh/5+5SGxogsf2kthI2QsAFjji+koLKSJacQ
0hd7MwMoTzuZsGfMEi7EBD2pN+P5CUrjmh2HTUxa9uZEVGfJBzI3NRIKrm50fnG7
/1fdvIDMnFGMfMD4L0w9nkqqH16D2N46W0yBP1p2eRwz4SwSMtQ8OnkI0DeZa9iA
L1wSh8L2M3hA6y2miltow5ZrSqLX6jeUOxoZSFRY0VrJss6cUgz4vUpjEj0ge5Lh
M2MM1GBB5gzlcu5F+ogCPIfjvTzhcPV0FT9v9apKS1fiQSUnYzsqhb/ntKTRsiRe
iAKCoAdEvy9J3vgj3aKvCM/X5gzqXRpvNhr0LVPdhpEmGCxDAnIKKvvQQQLOBGAC
rDc+zYpQVPop1rbmSopeNK4LzElVaweFTMMyTSj37SzRIo2K5sYiDF9xZnOTBzUV
SmFbzedQCk2i4IhqV3LtILRBor0w4lWA1jMeHD7Re23BDUY2JGjjrc366JpkjE6d
OCgoS+sU2HlnL5rOP+Sr
=iVgz
-----END PGP SIGNATURE-----

--jho1yZJdad60DJr+--

--===============6005443470990033035==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6005443470990033035==--
