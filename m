From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 00/12] ASoC: dapm: Cleanups and speed-ups
Date: Tue, 28 Oct 2014 00:14:35 +0000
Message-ID: <20141028001435.GG18557@sirena.org.uk>
References: <1413826604-3212-1-git-send-email-lars@metafoo.de>
 <20141022113634.GX2344@sirena.org.uk> <544BAC7D.2000508@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8811583157203067502=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EFCDF261558
 for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2014 01:15:09 +0100 (CET)
In-Reply-To: <544BAC7D.2000508@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8811583157203067502==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AeHkbrJcO8giN/MO"
Content-Disposition: inline


--AeHkbrJcO8giN/MO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 25, 2014 at 03:58:21PM +0200, Lars-Peter Clausen wrote:

> There are two patches in this series which have direct impact on the stats.
> The first one is the one that marks paths from a supply as a supply path.
> Those paths are skipped in is_connected_{input,output}_ep and hence supply
> widgets no longer appear in the path checks stat. While this might look
> pretty good in the stats the actual performance improvement is not that big
> since is_connected_{input,output_ep} will return right away if it encounters
> a supply widget. The change is still worth doing since the check if a path
> is connected to a supply comes essentially for free and we can also remove
> the code that handles supply widgets from is_connected_{input,output_ep}.

> The second change is the last patch in this series which caches the
> connected input and output path numbers between multiple runs of
> dapm_power_widgets() and only re-calculates those numbers if they could have
> changed. Since per DAPM operation typically only either changes the number
> of inputs or outputs the number of path checks is reduced by 50%. The number
> of neighbor checks is also reduced about the same percentage, but since the
> number of neighbors encountered when walking from sink to source is not the
> same as when walking from source to sink the actual numbers will slightly
> vary from card to card (e.g. for a mixer we see 1 neighbor when walking from
> source to sink, but the number of inputs neighbors when walking from source
> to sink).

Right, I get all this - my point was more that I had to think about it
rather than being able to see it from the changelog and with performance
it's particularly important since it's the sort of thing people end up
looking for when they run into problems in production so giving them a
helping hand is good.

--AeHkbrJcO8giN/MO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUTt/qAAoJECTWi3JdVIfQRIMH/2SKNHiLIsbLgyZeH2Z6TxbL
QpQDUvQXhFFItqylRy9LqG72ViqfnR0TNhd+DAC2gNXvJCOHR9wXmZJsCpxmY744
pcS+aB9I9c27aKlHvYciAoU648TZoJo7aMWQE4QZSxgyLiQt/y9WgIGDzKa+tU31
C8W29gxmmHx4g30Cj7Fdhfh98J/y/f2kZpbv2U1fwklHjHTqIwFzcKp/hR1HK3Td
MxewwXwA8CLZngjNadkl99UUamDw5AFw59ZFq/moyRhHI9sOwVvrfEylJ/WhQ7UC
xJlOkHMMDDImKzQpYpOMaoazwaLhQ14mU2So2FmmCi+jKY+4swY3hDxWxZxD9vw=
=7zKs
-----END PGP SIGNATURE-----

--AeHkbrJcO8giN/MO--

--===============8811583157203067502==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8811583157203067502==--
