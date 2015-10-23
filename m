From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 2/2] ASoC: nau8825: Show device
	properties
Date: Sat, 24 Oct 2015 00:49:07 +0900
Message-ID: <20151023154907.GG29919@sirena.org.uk>
References: <1445298546-23975-1-git-send-email-benzh@chromium.org>
 <1445298546-23975-3-git-send-email-benzh@chromium.org>
 <20151022161756.GV8232@sirena.org.uk>
 <CAOV7By+yBAiCOB=QBE3i6pc=0hs04ZNsBF_Rhzr_fqG_Lp-QXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6426257660813629943=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7383E261A83
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 17:49:18 +0200 (CEST)
In-Reply-To: <CAOV7By+yBAiCOB=QBE3i6pc=0hs04ZNsBF_Rhzr_fqG_Lp-QXg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ben Zhang <benzh@chromium.org>
Cc: John Hsu <KCHSU0@nuvoton.com>, alsa-devel <alsa-devel@alsa-project.org>, Anatol Pomozov <anatol@google.com>, Liam Girdwood <lgirdwood@gmail.com>, Chih-Chiang Chang <ccchang12@nuvoton.com>
List-Id: alsa-devel@alsa-project.org


--===============6426257660813629943==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7lMq7vMTJT4tNk0a"
Content-Disposition: inline


--7lMq7vMTJT4tNk0a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 22, 2015 at 06:48:50PM -0700, Ben Zhang wrote:
> On Thu, Oct 22, 2015 at 9:17 AM, Mark Brown <broonie@kernel.org> wrote:

> > Hrm...  we do already have multiple ways of dumping the DT...

> Could you point me to some of the ways of dumping DT? Is there a

The entire device tree is available via /proc/device-tree.

> generic way of dumping device properties provided by ACPI _DSD?

You can also dump the entire ACPI using acpudump from acpica-tools (it
may be packaged under a different name in your distribution).

> Sometimes devices may be flashed with different versions of coreboot
> firmware which contain different _DSD values. When debugging, it's
> helpful to know the exact platform data seen by a codec driver.

Sure, but that's hardly driver specific so the firmwares provide
infrastructure for this.

--7lMq7vMTJT4tNk0a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWKlbuAAoJECTWi3JdVIfQbqsH/0SKEZaZDMWfhZ2BWSCcgg+1
5BP0S8LE3W332Tz/8hOXnDZZdwNT06QikbW40tcscDns+ACT/YFtVz1OvbHJsCr+
JAUr8j85J0AkmnTlPvc5U7eSdT/uoEOCwFGqZ8Af+RoNFOOri7fgQQaEWZ6JwzGb
SDbsHjblwTDe837PJkI3kdxNX7tSLvrfdR8tvAj5KqTUKFsaAi11YOsGv8jZP5Az
/VtjiLRWPanJO/l7KctmMUYgH4awvXm0F85mXKOS3a777Wm4d+/XGr5IPcqZMmkU
h8qb620aqoFeVYBd5aMiUAZ0Bi8HgZG7C+akf4bOyu5tGJNaudClJry0rEb7QUo=
=pSp6
-----END PGP SIGNATURE-----

--7lMq7vMTJT4tNk0a--

--===============6426257660813629943==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6426257660813629943==--
