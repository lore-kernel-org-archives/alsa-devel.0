From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] ASoC: soc-compress: add a config
 item for soc-compress
Date: Wed, 17 Jun 2015 13:23:40 +0100
Message-ID: <20150617122340.GC3214@sirena.org.uk>
References: <20150615150556.GQ18309@sirena.org.uk>
 <E7B1D079BA13FB44A978CC8F69C7D6A90554ACF5@SHSMSX101.ccr.corp.intel.com>
 <20150616105429.GI18309@sirena.org.uk>
 <E7B1D079BA13FB44A978CC8F69C7D6A90554B0BF@SHSMSX101.ccr.corp.intel.com>
 <20150616160607.GT18309@sirena.org.uk>
 <s5hlhfj8wb3.wl-tiwai@suse.de> <s5hioan8w6v.wl-tiwai@suse.de>
 <20150616162507.GA28601@localhost> <s5h7fr38vax.wl-tiwai@suse.de>
 <20150617025448.GB28601@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2746098239190372264=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8BB4D265CFA
 for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2015 14:23:54 +0200 (CEST)
In-Reply-To: <20150617025448.GB28601@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Zhang,
 Vivian" <vivian.zhang@intel.com>, "ramesh.babu@intel.com" <ramesh.babu@intel.com>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============2746098239190372264==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2/5bycvrmDh4d1IB"
Content-Disposition: inline


--2/5bycvrmDh4d1IB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2015 at 08:24:48AM +0530, Vinod Koul wrote:
> On Tue, Jun 16, 2015 at 06:36:22PM +0200, Takashi Iwai wrote:

Please remember to delete unneeded context from replies.=20

> > 	if (cpu_dai->driver->create)
> > 		ret =3D cpu_dai->driver->create(rtd, num);


> > and each driver passes soc_new_compress (or whatever) there.  This is
> > flexible and can be extended if any new stuff has to be handled.
> > Even PCM creation or dai widget links can be passed in that form,
> > too.

> and the default would be snd_pcm_new so that *most* drivers dont need to =
add
> this. Only Intel atom driver should add soc_new_compress() as create ops,
> hence direct reference so no gaurds required

> Looks good to me then, Mark you okay with this approach?

I'm not sure this fully helps.  This will put the reference in the CPU
driver which if there's sharing with non-compressed DAIs means that any
machine driver using the platform needs to select the compressed audio
code.  It also means that we're still in the situation whre if a machine
*can* support compressed audio it *must* support compressed audio, it's
not clear to me that people doing this sort of memory optimisation are
always going to be doing it on hardware that doesn't have the capacity
for compressed audio (or won't in the future).  But then I don't know
exactly how much memory is being saved here...

--2/5bycvrmDh4d1IB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVgWbLAAoJECTWi3JdVIfQXm4H/29nIDhtlFq2/9VI3RsQWdyi
Cl80AFJsbnXsk1kRGpvmaqW5QTc0RGOi7F+QS9BqXsJccTJWsINnE8YEHjDnte2t
v+L7LOwJsjrrW1l5OcCYVi0thd5wk/GEn5nb9wxlNeaKV+9FIYa1vYNyY/LrKSEJ
ts8xjDn3xejFB0lmbmi+7WqfdDvLApLXv4iel9UFR9IkPsCE63GeDlG8Ifx/VE4B
SPH6h/4fLvC36Zwj6jZQ+eYWkWIgFgu4Y1lJBFAnptM/GW+Ll1cB2aZ2wmxfnkCN
brKEfl9YACOhsugnXoXzdXK0ODtOtLYvtyPceDE96y+T5SdB75lDzJ2oZtl07QM=
=zfj7
-----END PGP SIGNATURE-----

--2/5bycvrmDh4d1IB--

--===============2746098239190372264==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2746098239190372264==--
