From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/5] ASoC: dapm: Consolidate input and
 output path handling
Date: Tue, 4 Aug 2015 17:00:19 +0100
Message-ID: <20150804160019.GT20873@sirena.org.uk>
References: <1437930302-2789-1-git-send-email-lars@metafoo.de>
 <1437930302-2789-4-git-send-email-lars@metafoo.de>
 <20150729131439.GF20130@sirena.org.uk>
 <55BDEE72.2050401@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4019756702104509274=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 496BB26582D
 for <alsa-devel@alsa-project.org>; Tue,  4 Aug 2015 18:00:33 +0200 (CEST)
In-Reply-To: <55BDEE72.2050401@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4019756702104509274==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tDg5AmReZES28+f8"
Content-Disposition: inline


--tDg5AmReZES28+f8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 02, 2015 at 12:18:26PM +0200, Lars-Peter Clausen wrote:
> On 07/29/2015 03:14 PM, Mark Brown wrote:

> >>  #define DAPM_UPDATE_STAT(widget, val) widget->dapm->card->dapm_stats.=
val++;
> >> =20
> >> +#define dapm_widget_for_each_path_safe(w, dir, p, next_p) \
> >> +	list_for_each_entry_safe(p, next_p, &w->edges[dir], list_node[dir])

> > It's a bit odd not to have this in the header next to the unsafe
> > version.

> You'd only need the unsafe variant if the paths are modified while being
> traversed. I'd rather not encourage drivers to do this by hand. So this
> macro is internal to the DAPM core.

It's the unsafe version that's in the header though?  I can tell why
they're separate, I'd just rather keep them together even so - drivers
shouldn't really be iterating over widgets at all.

> >>  	list_for_each_entry(w, &card->widgets, list) {
> >> -		w->inputs =3D -1;
> >> -		w->outputs =3D -1;
> >> +		w->endpoints[SND_SOC_DAPM_DIR_IN] =3D -1;
> >> +		w->endpoints[SND_SOC_DAPM_DIR_OUT] =3D -1;

> > Loop over the endpoints array in some of the users like this perhaps?

> It's not really worth it if you only have a single line inside the loop.
> Doesn't make the code shorter nor more legible.

It does save me wondering if we've missed any other array elements which
was my first thought here.

--tDg5AmReZES28+f8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVwOGTAAoJECTWi3JdVIfQf4EH/ipr3dQnlpPi1aA7vZZZBuWp
uobKZCB7axRnLAA7snrV4rM7aDbBR38rd7ccJtlCcFsLFf7xMOar2AjskfLDn+hy
OtvBADlCY9M8FJN8QLASe1ZmGSptiQs7L2/60xgFXhdzWiv2pHFVMTX/UI0ojSMz
U2CTBVYfgm1FRPBuB0Ww8MBbERfuaGspZgRrym3upaKZSUpcLnrGuv0FpyYSSd/3
f5OGvkV/4iU1b3w9hRhW8KEuvEDD6do9xNzJ+gqdbmr7gmnHg9kYVMExpWhfoXkl
3Gi6dwTNHnZsfAqBCELreVGkLES++N4ZOTdUsW79M1FzjQe+nnIysRjR2yuGreQ=
=tY+q
-----END PGP SIGNATURE-----

--tDg5AmReZES28+f8--

--===============4019756702104509274==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4019756702104509274==--
