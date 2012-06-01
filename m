From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v5] sound/soc/lapis: add platform driver
 for ML7213
Date: Fri, 1 Jun 2012 09:30:18 +0100
Message-ID: <20120601083018.GH24139@opensource.wolfsonmicro.com>
References: <CANKRQnhNWC2F6zKgBMJY7HnipJbA5p-=6Lz4uGZqBKNQ688Z3w@mail.gmail.com>
	<20120524100742.GH5361@opensource.wolfsonmicro.com>
	<CANKRQnj_LdGQPYPV7d5NNZBx8oM5aAGHu4qZidiiS6C4eNtNJQ@mail.gmail.com>
	<1337941231.1580.19.camel@vkoul-udesk3>
	<20120527221956.GB25019@opensource.wolfsonmicro.com>
	<CANKRQnhwkhGUHi6WQhw-sRJuKari3SLcipCJXVp27OZ29=Vxkw@mail.gmail.com>
	<20120530121449.GI9947@opensource.wolfsonmicro.com>
	<CANKRQni4uqQJ99ycOScHmn-g1kz2_XH7ePL+n1taG5jAbDSubw@mail.gmail.com>
	<20120531104538.GA2666@opensource.wolfsonmicro.com>
	<CANKRQnjdiV+e=N+n_ZP04jmCAhxKjgZ+wab+anbgO+VJPNo=PQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3134532375569288860=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E2139104569
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Jun 2012 10:30:21 +0200 (CEST)
In-Reply-To: <CANKRQnjdiV+e=N+n_ZP04jmCAhxKjgZ+wab+anbgO+VJPNo=PQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Cc: Vinod Koul <vinod.koul@linux.intel.com>, lars@metafoo.de, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============3134532375569288860==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UTZ8bGhNySVQ9LYl"
Content-Disposition: inline


--UTZ8bGhNySVQ9LYl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 01, 2012 at 05:13:45PM +0900, Tomoya MORINAGA wrote:

> > Linus' tree, or mine.

> Sorry, I couldn't find.
> Is your saying Linus's tree this ?
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> However, any ASoC driver doesn't use cyclic DMA's.

$ grep CYCLIC sound/soc/soc-dmaengine-pcm.c=20
	dma_cap_set(DMA_CYCLIC, mask);

--UTZ8bGhNySVQ9LYl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPyH2BAAoJEBus8iNuMP3deKEP/3Djm3B9K0mBDLBCvjU71CO+
m+i+NmZupFqbBxkxz8SkfGv9ajX+0UPNdYY6vThQG4ggtyc/A1ejnWuO6vL6S9UK
3GMJTFvHjg3BhBCC11xdyJpVBUNVdMXrhyDtbDe3P80V4h/mfZETgSMLmL6dIHyn
KMb+MA+j5LLh7vnigMobp8z0Zra8eZzmrktSYL3dFNlg+GhEa+ixfBW98FOH2sU+
1ITcaBxRvWardBWRKoDzR1PsZcZ7ajLtJ4K5mTbVTM3kfNkkHcNlNFW5YTfxyo8b
9APANxysU8BWEvMxXgDCaxMoZjYoC2dh2cGXzQaQA+y9vKnkECwJhF9IF+RNfyhE
uNv33avnmCeqw0swTFdSqDbEg3UExekhK6yHPgtVkLCsEzxpqg5QstGDpdCYYuGA
wS5p3vwAuui+YofkQYTApgT7cg1XFFLFtO/L9JBLH1BNkhZXVNGfTRJs1b6EXqJc
NQvNp3ap6ZoJfi1DzSdfc267FyGRFijmk2+HgNMbxDV9rpqkauZO04shQlwaI/Bz
h9zkB4lds8irdKrotRhFQLfZ4QUzQjXGsNf+dpmMIdtKRorCUm6Dbg5fUNffmRr7
xyk6FB0qFnka34OdAw/QtcCdRJT6487N87ckCC9o+amMNl/n62oF8A9mQYV4W839
Iputd6WtIwY5brZtIiuq
=NduQ
-----END PGP SIGNATURE-----

--UTZ8bGhNySVQ9LYl--

--===============3134532375569288860==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3134532375569288860==--
