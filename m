From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Make sure we only build SST
	drivers on X86
Date: Thu, 20 Feb 2014 00:57:58 +0900
Message-ID: <20140219155758.GK2669@sirena.org.uk>
References: <1392818784-6248-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <1392818784-6248-2-git-send-email-liam.r.girdwood@linux.intel.com>
 <20140219150040.GD2669@sirena.org.uk>
 <s5h1tyzw2la.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8516330097980355319=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id A4A8D265A1C
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 16:58:55 +0100 (CET)
In-Reply-To: <s5h1tyzw2la.wl%tiwai@suse.de>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8516330097980355319==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WqKVlampDlunLwEp"
Content-Disposition: inline


--WqKVlampDlunLwEp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 19, 2014 at 04:21:05PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > But lots of architectures do actually have these operations, I suspect
> > looking at some of the existing users depending on PCI is enough if
> > excessively strict (this will improve build coverage which tends to be
> > useful even if the driver can't be run).

> Yes.  I guess including linux/io.h should fix the build issue.

It should for PowerPC (and ought to be done anyway since an implicit
include is going to break eventually on x86 too) but it won't for
architectures that don't have the function at all.

> Though, limiting the build to X86 isn't bad particularly for this
> driver.

Most people working on ASoC don't build x86 that often, more build
coverage of these minority platforms is going to help avoid issues for
-next! :)

--WqKVlampDlunLwEp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBNSDAAoJELSic+t+oim9bGQP/iviUjqVDKSKJ8Lsoz5c+KaP
yE81hEBPBHSpnQ7NnYBXlPbP34KtSpcyIOjZheLZAzNNWvE8jjxseXvPFvKDYPqM
SNFkqi7ZtnS2vH2TkPmqsxA7EnQSS6pXshNke3Rd5MDssX0xi+hgqEu4AvqSDUto
KfKNLlcFRJk2E79pRBn0+3DTi8cp2qS3QbCfLmCkTq6LtCh9WduwGgN+iVFcYSVo
3zqHH2su/KC4qiXHh89zsVV7k320LwrjBlOmTOtZZ9MMHBRKqytqAqxeH30C141w
1s2+SRYPpVdBZkvfI/CKiubXdrHyz7y2ju2oCej6YlUoQiddIJU9Sxhx6CMHxt2c
rbiXML1K8Kyie2+yn5hAEN9kghx3+qWOG36/5HYGc0NZXiQUqPo0qwgtRoiS1ajr
uqHuIgSgvsnlbhZ8WdESe2x1YK3at4XDd8pYulL63/EdTdJyhuIvMECOU19APjf6
Uji0XujNk8rbCX4L0AH3VrIFNQXCcfyoEtwgM1NBVJ8M37BNBuNi2ctFGOVtSx6f
5TNFzSKXLfqitLxdIiSrRPzhHiHC/r+vnymAXEoILsAvMqvZOF5LOv8Bl2+R2ZXK
gfgN6Cmxy4b5MTyaWWDJRgwhLIvFz2/mc5sktKdG3oFOS7xVa6hn9Me+css0mw/r
k9q4sGw2Lh7m2DndwJ8j
=ZC19
-----END PGP SIGNATURE-----

--WqKVlampDlunLwEp--

--===============8516330097980355319==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8516330097980355319==--
