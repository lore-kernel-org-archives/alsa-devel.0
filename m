From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ALSA: memalloc: declare
 snd_sgbuf_aligned_pages() unconditionally
Date: Thu, 26 Jul 2018 17:08:16 +0100
Message-ID: <20180726160816.GJ2414@sirena.org.uk>
References: <20180725201556.21136-1-pierre-louis.bossart@linux.intel.com>
 <s5h4lgmwlwm.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3169943513685558170=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A8C082677A1
 for <alsa-devel@alsa-project.org>; Mon, 30 Jul 2018 20:22:42 +0200 (CEST)
In-Reply-To: <s5h4lgmwlwm.wl-tiwai@suse.de>
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
Cc: liam.r.girdwood@linux.intel.com, vkoul@kernel.org, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============3169943513685558170==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jQIvE3yXcK9X9HBh"
Content-Disposition: inline


--jQIvE3yXcK9X9HBh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 26, 2018 at 08:28:41AM +0200, Takashi Iwai wrote:

> I can put this to for-next branch, or to another immutable branch, so
> that Mark can pull in.  Or, it's fine that Mark applies to his tree
> together with other Intel patches, too.  Mark, what's your preference?

> In the last case, feel free to take my ack:
>   Reviewed-by: Takashi Iwai <tiwai@suse.de>

Since I can just do it immediately I applied it and pushed out a signed
tag for it:

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/alsa-add-snd-sgbuf-aligned-pages

for you to fetch changes up to 4cae99d9b5305ab8cccc839fccceb81ec9e5abda:

  ALSA: memalloc: declare snd_sgbuf_aligned_pages() unconditionally (2018-07-26 17:05:29 +0100)

----------------------------------------------------------------
ALSA: memalloc: declare snd_sgbuf_aligned_pages() unconditionally

Make this helper inline function available for all platforms. This
helps solve 0-day compilation issues when CONFIG_SND_DMA_SGBUF is not
defined.

----------------------------------------------------------------
Pierre-Louis Bossart (1):
      ALSA: memalloc: declare snd_sgbuf_aligned_pages() unconditionally

 include/sound/memalloc.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--jQIvE3yXcK9X9HBh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltZ8e8ACgkQJNaLcl1U
h9DxmAf/b//4eidYzdRt63m2D3y8do7Q8j8Q3AM7tj4fZWOEn7V5RvCHchKQnls5
5oBe5uD5goQjZipRLTG+vqCxJwTWDU2zNCLubOyXs89a8CQEbFZhIrkjGLRG7WJL
bRO3qGaIaQOTbx8UTVFXYd4lKrr33kjRJgfupG/3ZV42TZC5WrMCp4eu2qDgqEsP
wANgfvimrNVuy4A7z11iMmf5t11YB1LLKuoI8kOyJBvhGjHMyM21XW59vWg1M9mb
T2SytI1pLwkx+HwgB6kNrzaWyzX08jeiT4vHw/W/WWQhm/rdxTfIpiu503NykNO4
/HaBJu8CnWhjKsbeKFaSkHGtgXB+SQ==
=dDOr
-----END PGP SIGNATURE-----

--jQIvE3yXcK9X9HBh--

--===============3169943513685558170==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3169943513685558170==--
