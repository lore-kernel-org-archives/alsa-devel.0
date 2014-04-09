From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] ALSA: hda - Make full_reset boolean
Date: Wed, 9 Apr 2014 12:33:09 +0200
Message-ID: <20140409103307.GA9527@ulmo>
References: <1397035706-11079-1-git-send-email-thierry.reding@gmail.com>
 <s5heh16vny1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5843689127035710004=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f47.google.com (mail-bk0-f47.google.com
 [209.85.214.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 985F0261606
 for <alsa-devel@alsa-project.org>; Wed,  9 Apr 2014 12:34:03 +0200 (CEST)
Received: by mail-bk0-f47.google.com with SMTP id w10so2181697bkz.20
 for <alsa-devel@alsa-project.org>; Wed, 09 Apr 2014 03:34:03 -0700 (PDT)
In-Reply-To: <s5heh16vny1.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============5843689127035710004==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 09, 2014 at 11:42:30AM +0200, Takashi Iwai wrote:
> At Wed,  9 Apr 2014 11:28:26 +0200,
> Thierry Reding wrote:
> >=20
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > The full_reset argument to azx_init_chip() carries boolean rather than
> > numerical information, so update the type to reflect that.
> >=20
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  sound/pci/hda/hda_controller.c | 8 ++++----
> >  sound/pci/hda/hda_intel.c      | 4 ++--
> >  2 files changed, 6 insertions(+), 6 deletions(-)
>=20
> Forgot to patch hda_controller.h?

Indeed. Turns out this didn't cause build breakage for me because I had
turned off HDA for some other test again.

Sorry about that. New patch sent out.

Thierry

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTRSHjAAoJEN0jrNd/PrOhym8QAJ3PgV14B/iRSJLBFS2jrzYR
dVEvTVF9plj5ku9wJpfSPPrp5kCZQudkau5QM09t8PfP1X1zOJ8NnBjftLqGjQyn
Y50bbloLfcSU4p3FEhbpygM9m068TzquJJh42TVkXvW+JxcrAyXl1AjQdiNa+rTE
6vG8PP1VZgjjQ8rlHZVoAYf32czQcO6W1B0rku7oBoOHptATClnr3QiZEHPv+BgB
Wxahq8guRBJ+R6WTdwx2DUXoS8L+aGPGP43yF0wnQuhbHAdU3Y+ObDhFmAfqsHQG
2/ZWqWdvodFP8FHEXmKscADcJBlsSK4bgoBQtmb0Crnf+k05tlM4/yAbyiLI0dSr
yFd+mCvzaW783ErviJS8DPFc3rbhgixeMjfWHUK6+vHF1YwnZpOLK6427vhk6m5r
TtAtMIAU4ZLYr3rcQOAp7K2gl8pT8Cp9GdLv3L2zew78rKqKDbVwV6fiKAOLcbKt
az/8w0kUnFdGOkxy0ZGFdGalcX6xVihmveY4pBOb8K4PqxyL2OqfMeKIek+vbDz6
CrQT2AreKqyp6Ago+UUlZN7Kb+TLTPbU5oc41RpuHbh+lkS3g3E3N7NWQn9mUs3Y
/fFyHubBTCUQLL1YdnFSzqc1ZTnDoUH3z9b1kUeXMeIy/FZrGPFlSl0fF8mJt7Ej
i+leN2q4g4QO6dixd9lq
=jCIj
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--

--===============5843689127035710004==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5843689127035710004==--
