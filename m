From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: pcm: Always honor DAI min and
 max sample rate constraints
Date: Wed, 27 Nov 2013 12:21:53 +0000
Message-ID: <20131127122153.GU14725@sirena.org.uk>
References: <1385542698-13362-1-git-send-email-lars@metafoo.de>
 <1385542698-13362-2-git-send-email-lars@metafoo.de>
 <s5hk3fu6sqt.wl%tiwai@suse.de> <5295D500.50607@metafoo.de>
 <s5h7gbu6q6y.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0417922263034483877=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id D4A252616B8
 for <alsa-devel@alsa-project.org>; Wed, 27 Nov 2013 13:21:57 +0100 (CET)
In-Reply-To: <s5h7gbu6q6y.wl%tiwai@suse.de>
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
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0417922263034483877==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YgseLHR9uOh11QTZ"
Content-Disposition: inline


--YgseLHR9uOh11QTZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 27, 2013 at 12:26:29PM +0100, Takashi Iwai wrote:
> Lars-Peter Clausen wrote:

> > My thinking as well. There are some driver which do set CONTINUOUS or KNOT,
> > but don't specify a minimum and maximum rate and probably rely on the fact
> > that we always call snd_pcm_limit_hw_rates() (E.g. the kirkwood drivers do
> > this). In my opinion those drivers should be fixed and once that is done we
> > can add a check that skips snd_pcm_limit_hw_rates() if KNOT or CONTINUOUS is
> > set. The current behavior isn't optimal e.g. if a driver sets
> > SNDRV_PCM_RATE_CONTINUOUS and SNDRV_PCM_RATE_8000_192000 and rate_max to
> > 384000, we'd still end up with a maximum rate of 192000 because of
> > snd_pcm_limit_hw_rates().

> Right.  We should catch all them once, then add a sanity check
> something like

It seems neater if snd_pcm_limit_hw_rates() does the right thing no
matter what the rates are - this centralises the logic for handling this
which reduces the complexity for drivers.

> 	WARN_ON((rates & SNDRV_PCM_RATE_KNOT) && \
> 		(rates & ~SNDRV_PCM_RATE_KNOT));
> 	WARN_ON((rates & SNDRV_PCM_RATE_CONTINUOUS) && \
> 		(rates & ~SNDRV_PCM_RATE_CONTINUOUS));

This does make sense, though we'll need to change the constraint merging
code in ASoC since right now it assumes that combining the masks will do
the merge which won't be the case if you have devices with one of these
flags together with any other flags (either specific rates or the other
non-bitmask one).  It would be nice if we were just throwing the device
constraints into the core constraint code and letting it merge them
together.

--YgseLHR9uOh11QTZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSlePeAAoJELSic+t+oim93sUP/1sE1hJezjWBGXhOCOPeOwEd
RUFfEN42c+gccK+JTGoXw8cVbFf4lINmqLzVYSv1zoPH4tBv6C/2/DGwkhwLVIjx
PJrF3JBDtDHN7IXYJGpcqqdZvTZZZkXyN2VKtmgNUn210uaHlR4Z22+zOTiKyRSn
iz93vL2gZ4try8XkkvR2Lxzr1pxeNoRAN/llXEs/Q7Ifz8t2CmAQ7Y96Cqtq1lid
VVzhDJemhrsjn4Eyj0LAXb9WocSHFDLhXS/CLn4dm94+UC26Oq5fqLtBiL+NsOoN
ILegYifaPEorKTFB3ySsO9Wo/Q8OJbeLumDviFQGYTk+WzNiMij8jtGbxzcqmcS2
G0GBzuWNCdlieHnzrqjLuMl35EsnxkyLnqlFVE7QvRdZV8VAY5dH+FTN2fQk2oR8
NqDm9/BABy1BJ2fTJkGW0ugr92PVRp5bsaLRjCvLqPvNWrcR5e739p8q54utYPxK
CQF7tfGVPkQKSurdstFF+LZAhddOcbu/sRDy1GM6XMEPXoNhaVdnKqdwwy7gFObQ
b1GEh+gc/3ZcauXWTwBHQWRWlJjq46RlbMJ0Dky0NlCPyzUpEox751Ec+/SL7744
8nTqJw8QRENzC7iB2xS7zsLczwGF1gwVSPiHv7mXiER8EX95H0qEWNi6vqwkgaKZ
ulEULvqsM+m7xIYi7ePk
=xa3d
-----END PGP SIGNATURE-----

--YgseLHR9uOh11QTZ--

--===============0417922263034483877==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0417922263034483877==--
