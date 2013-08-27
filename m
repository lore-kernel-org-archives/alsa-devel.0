From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/9] ALSA: compress offfload fixes
Date: Tue, 27 Aug 2013 14:28:08 +0100
Message-ID: <20130827132808.GH10783@sirena.org.uk>
References: <1377585639-29516-1-git-send-email-vinod.koul@intel.com>
 <s5heh9fjtrn.wl%tiwai@suse.de> <20130827100955.GX2748@intel.com>
 <s5h7gf7jov7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7320076660120277537=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D180260863
 for <alsa-devel@alsa-project.org>; Tue, 27 Aug 2013 15:28:21 +0200 (CEST)
In-Reply-To: <s5h7gf7jov7.wl%tiwai@suse.de>
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
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7320076660120277537==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cW+P/jduATWpL925"
Content-Disposition: inline


--cW+P/jduATWpL925
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 27, 2013 at 02:32:28PM +0200, Takashi Iwai wrote:
> Vinod Koul wrote:

> > Since lot of embedded folks will be on 3.10 then would have been nicer if it
> > went to stable.

> "It'd be nice" doesn't satisfy the condition for stable kernels,
> unfortunately.

On the other hand if there's an issue which essentially every user is
most likely going to end up backporting a fix for it seems reasonable to
consider getting that resolved.  Personally I'd be a lot more
conservative than Vinod with this one and only consider the fix for
blocking during drain.  The current series seems rather invasive though.

--cW+P/jduATWpL925
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSHKlfAAoJELSic+t+oim99EgP+QFRWhrJtr+YmyTkN7Rv2zMJ
lirzZwfKZgjeAwY5g2lk1XAsJ0mU/aIJC4BuHyDDK3qq/PRj6CVjpDsUhWS99+Sd
sE+s5DTL6b0y2RutRf7DgPtCJ7yldLZMr3uKvm4tRg7iOcr2uzrGnbTt+4LMbs3h
/G1yxOkfrcjzlxvdHQEw2FLBmaDJ4gOoxf1iA3Y/SNi/+6aRX6I/zhsPYuWi4ufQ
ZduLZEQPJVf7KwFxHd0CKUvCDFFrtM8ro5C0/DC1DCpmkKqpUIEdjIZJ7oKquj2L
pmDbwtymnP2n2opixfbXc6QCIjwANF7NtiVKl0VGCatVmsh9zkTCH8pO07F1pj3x
q46oZa5uUfMvC93WBwNlXKhBmUoiCXTBseGuKB6wO8SGtldtOvhf4D/f7tPrSNJw
/OsrPxIy+hWhlzAzweYWRAhJPSOgSpJC7jU9tKrn2+Pfcr8h6ABRtDgy/NtdM0bO
GPadTFF6gzZPnQwSIKqwAUdnJWnM0p3HVAt8+jYOsLeiZA87eSNu9afJAPTfXuB7
FiVwAwoGrgvG+aLnNR02WtK0lHxjyVAsARbJ7RGKn7CWfbZ6WzzROV8aVwNuMaLh
Ex57sDnnOPj1G+gPzqpl4Gvf5z2A82ffcLbl7JhZsCI4PMvYRl+l/YVLOSttZeUP
yNvbZZWbjnyK78spIr3K
=bdWA
-----END PGP SIGNATURE-----

--cW+P/jduATWpL925--

--===============7320076660120277537==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7320076660120277537==--
