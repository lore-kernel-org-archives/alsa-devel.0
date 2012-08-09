From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH] ALSA: hda - Defer probe when loading patch
	firmware
Date: Thu, 9 Aug 2012 09:36:42 +0200
Message-ID: <20120809073642.GA24695@avionic-0098.mockup.avionic-design.de>
References: <1344494723-6827-1-git-send-email-thierry.reding@avionic-design.de>
 <s5hhascft86.wl%tiwai@suse.de>
 <20120809070813.GA6979@avionic-0098.mockup.avionic-design.de>
 <s5hd330frn1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2710077619772988003=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
 [212.227.126.186])
 by alsa0.perex.cz (Postfix) with ESMTP id AB185265F3E
 for <alsa-devel@alsa-project.org>; Thu,  9 Aug 2012 09:07:01 +0200 (CEST)
In-Reply-To: <s5hd330frn1.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org


--===============2710077619772988003==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 09, 2012 at 09:31:30AM +0200, Takashi Iwai wrote:
> At Thu, 9 Aug 2012 09:08:13 +0200,
> Thierry Reding wrote:
> >=20
> > On Thu, Aug 09, 2012 at 08:57:13AM +0200, Takashi Iwai wrote:
> > > At Thu,  9 Aug 2012 08:45:23 +0200,
> > > Thierry Reding wrote:
> > > >=20
> > > > Recent changes to the firmware loading helpers cause drivers to sta=
ll
> > > > when firmware is loaded during the module_init() call. The snd-hda-=
intel
> > > > module requests firmware if the patch=3D parameter is used to load =
a patch
> > > > file. This patch works around the problem by deferring the probe in=
 such
> > > > cases, which will cause the module to load successfully and the dri=
ver
> > > > binding to the device outside the module_init() call.
> > >=20
> > > Is the "recent" change meant 3.6 kernel, or in linux-next?
> > >=20
> > > In anyway, I don't understand why such a change was allowed.  Most
> > > drivers do call request_firmware() at the device probing time.
> > > If this really has to be resolved in the driver side, it must be a bug
> > > in the firmware loader core code.
> >=20
> > A good explanation of the problem and subsequent discussion can be found
> > here:
> >=20
> > 	http://article.gmane.org/gmane.linux.drivers.video-input-infrastructur=
e/49975
>=20
> Yeah, but it doesn't justify this ugly module option.
> It's a simple bug.  Papering over it with this option doesn't fix
> anything.

It's not an option, all it does is defer probing if and only if the
patch parameter was specified to make sure the firmware load won't
stall. I realize that this may not be an optimal solution, but at least
it fixes the problem with no fallout.

A proper fix would require a larger rewrite because it would entail
using the asynchronous firmware load operations. That in turn would
require the initialization to be split into several stages.

Thierry

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQI2iKAAoJEN0jrNd/PrOh7YMP/iGuXFqC9foVDzFA3hij87hZ
6x/TYMtVTWPU3A2Gwc9+7ryj1JJCEvZFwxf4wmXN1+CV9FLBfm6El/I8j2RgJ5QE
LqHvfLppamd0UkI83w53qHpIB6YFZTv8Y/8fOz07GV6r9KK6xclruNqLVilQnhnJ
gLYTbcm4thjRswSnY3Fw2KVDZnbRwyVS18Xxp1jBjwaqdGoF343WJQjj5EHaUp3Q
Bx+TILcrsCOzotfg+SpX6mTRXAr5/r4UhGxuxlhJKUL3x5JO7Z+9mbeo3PsfT0bk
XIIlYwIVqRVlSgKSjbn8Om+f57FmTcg1zEypnaQLMT9jNB+ouk0BUQDztZn3QKND
Ezwc7jiFMr6ViOwh2x+SCVwsMgXQuLLOaZOPg+F1TnC3DO9wMGS0Nb4eHem4tvT1
AZ43Z4RW3murFnWTOh6XWwSwOasD+DAK64dJxfkjkfw6S0tQz63KoG2kmT86hq+O
p3mdgiCbRVo2PkyT9JdhMmBQpD4Rt3NXZ+4kgBLa+X8IP2fKu3rWsRjyIJ4FlGb1
KOijWqIFpzPNnevHnndqnk317FwulOHVgIDG5rF1iibqOT2zZQwlzHlFcFqLtcC+
fp2iomhBwl61n1nf1nH54Y9wuBNCoqHznIAVq4iAkpx64Eml9wy9ssT6UDoHNKbv
Zmk708UiY8j+XEhJ/UhD
=o5gv
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--

--===============2710077619772988003==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2710077619772988003==--
