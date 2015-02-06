From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: core: call
 snd_soc_unregister_card() when component cleanup
Date: Sat, 7 Feb 2015 05:46:59 +0800
Message-ID: <20150206214659.GA31311@finisterre.sirena.org.uk>
References: <87h9v4gbhg.wl%kuninori.morimoto.gx@renesas.com>
 <87iofj7qhc.wl%kuninori.morimoto.gx@renesas.com>
 <20150204205503.GM21293@sirena.org.uk>
 <87lhkcj55p.wl%kuninori.morimoto.gx@renesas.com>
 <87k2zwj4zf.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0113401007433762521=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AA7592604E6
 for <alsa-devel@alsa-project.org>; Sat,  7 Feb 2015 09:28:20 +0100 (CET)
In-Reply-To: <87k2zwj4zf.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0113401007433762521==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 05, 2015 at 05:33:55AM +0000, Kuninori Morimoto wrote:

> ASoC devices are organized as [CPU]-[CARD]-[CODEC]. Then, [CPU]/[CODEC]
> are based on [component] structure. Now, each [CARD] device knows that
> it has organized from which [component]. But current [component] doesn't
> inform to [CARD] that it was removed when user called rmmod or unbind it.
> Thus, [CARD] which lost some [components] still exist in system.
> And then, ALSA sound card will have some problem if user used this [CARD]
> in such timing. This patch unregister [CARD] when [component] was removed.
> If you want to use this [CARD] again,=20
> you need to re-insmod or re-bind removed [component] and [CARD] again.=20

So, there's a problem here but...

> @@ -2695,6 +2695,7 @@ static void snd_soc_component_add(struct snd_soc_co=
mponent *component)
>  static void snd_soc_component_cleanup(struct snd_soc_component *componen=
t)
>  {
>  	snd_soc_unregister_dais(component);
> +	snd_soc_unregister_card(component->card);
>  	kfree(component->name);
>  }

=2E..this doesn't look like the right fix.  If we just plain unregister
the card then if the component that was removed is loaded again then the
card won't be reinstantiated since the core has forgotten about the
card.  Further, if the card driver is removed then we'll get a duplicate
attempt to unregister it which doesn't seem clever.

What we need to do here is undo all the work that was done to
instantiate the card but not actually unregister it, returning
everything to the state it was in before the card was instantiated.
That's obviously a much more substantial change than this but it's
what's needed (and is the main reason this is broken at the minute).

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU1TZPAAoJECTWi3JdVIfQnpoH/RqgSPafSzHX5JRMG0s30JkU
vP87TrYdT6zJZQK0d8Cqud3xVRolb/D7hy/HKNZZKmIo5nEbYMHvVWjyIAIbN7ld
q8s9AN6jpOkFB/qnso9iUF22TrWnlO6Oli8a4S2PlqDk4Eitdjt7phHNlYLU3Y9D
RuuseVDjDurtWu8tdMf8VWxvilMBxIfq+NyGEfUrQZzSB/FAO3UTMhXgJiWDXbZW
FtKj0XFdFi4Cqszw5kuDu1FaRWafJ1l2SfYSBb4I0n3lT2DccThnAU2Utzkic/z+
bG2OyKIEy0tN2GDsnMRc4QogzZ1yj5VpUVoz1ue1PS2qO9yvqMDY2TfhGmHcd7Q=
=MbYC
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--

--===============0113401007433762521==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0113401007433762521==--
