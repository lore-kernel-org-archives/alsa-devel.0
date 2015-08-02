From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 4/5] ASoC: dapm: Consolidate input and
	output path handling
Date: Sun, 02 Aug 2015 12:18:26 +0200
Message-ID: <55BDEE72.2050401@metafoo.de>
References: <1437930302-2789-1-git-send-email-lars@metafoo.de>
 <1437930302-2789-4-git-send-email-lars@metafoo.de>
 <20150729131439.GF20130@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2562436392003513657=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-138.synserver.de (smtp-out-138.synserver.de
 [212.40.185.138])
 by alsa0.perex.cz (Postfix) with ESMTP id 08E48260427
 for <alsa-devel@alsa-project.org>; Sun,  2 Aug 2015 12:18:34 +0200 (CEST)
In-Reply-To: <20150729131439.GF20130@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============2562436392003513657==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="mgHh7CjtxCqI4tCRECGM5uWuF6ciwLxH7"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mgHh7CjtxCqI4tCRECGM5uWuF6ciwLxH7
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 07/29/2015 03:14 PM, Mark Brown wrote:
[...]
>> +/**
>> + * snd_soc_dapm_widget_for_each_sink_path - Iterates over all paths i=
n the
>> + *   specified direction of a widget
>> + * @w: The widget
>> + * @dir: Whether to iterate over the paths where the specified widget=
 is the
>> + *       incoming or outgoing widgets
>> + * @p: The path iterator variable
>> + */
>> +#define snd_soc_dapm_widget_for_each_path(w, dir, p) \
>> +	list_for_each_entry(p, &w->edges[dir], list_node[dir])
>=20
> This is a macro not a static inline?  The other macros that use this ar=
e
> macros but that's more outdated code than anything I think, might be
> worth fixing that while we're at it.

Sorry, I don't quite understand what you mean.
snd_soc_dapm_widget_for_each_path() is a iterator so it can't be a functi=
on.

>=20
>>  #define DAPM_UPDATE_STAT(widget, val) widget->dapm->card->dapm_stats.=
val++;
>> =20
>> +#define dapm_widget_for_each_path_safe(w, dir, p, next_p) \
>> +	list_for_each_entry_safe(p, next_p, &w->edges[dir], list_node[dir])
>=20
> It's a bit odd not to have this in the header next to the unsafe
> version.
>=20

You'd only need the unsafe variant if the paths are modified while being
traversed. I'd rather not encourage drivers to do this by hand. So this
macro is internal to the DAPM core.

>> +#define SND_SOC_DAPM_DIR_REVERSE(x) ((x =3D=3D SND_SOC_DAPM_DIR_IN) ?=
 \
>> +	SND_SOC_DAPM_DIR_OUT : SND_SOC_DAPM_DIR_IN)
>> +
>> +#define dapm_for_each_direction(dir) \
>> +	for ((dir) =3D SND_SOC_DAPM_DIR_IN; (dir) <=3D SND_SOC_DAPM_DIR_OUT;=
 \
>> +		(dir)++)
>=20
> Eew.
>=20
>>  	list_for_each_entry(w, &card->widgets, list) {
>> -		w->inputs =3D -1;
>> -		w->outputs =3D -1;
>> +		w->endpoints[SND_SOC_DAPM_DIR_IN] =3D -1;
>> +		w->endpoints[SND_SOC_DAPM_DIR_OUT] =3D -1;
>=20
> Loop over the endpoints array in some of the users like this perhaps?

It's not really worth it if you only have a single line inside the loop.
Doesn't make the code shorter nor more legible.




--mgHh7CjtxCqI4tCRECGM5uWuF6ciwLxH7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVve54AAoJEOj3aLScRbOZVEkQAJJMU78SvOccTfwuWMnj1IKP
EIgBbUrtr1HjVhw6w1+MZtsEFw5iTXbuneni4+LJrFCzA6ZtxzFyhqu/jN7ddyVi
gSFwVv9KjjRR7yg+JmKWg3G3mCNwUxpbXGS/tJF6+CbnVXQU6QUyRNE15scas72D
xx/NlqC+ZRfoLzDHJUwydLhfuFKqmQSDQoBptkbgzav/gF/TU4UPrYJ8BAxy9K2y
Yg0T4YmnB4XR0MTdGx3QP83Fh0+qqHbpdmJyZl6vWuPWg2LrCe0SlXTuIFNIcxfu
ZjIx+GKxJCcAk2s6M3R+zWjGQ6xKePDUfBvMuxEjvg/mCZPH9TQdyC9Cl9OSUYaq
ngdcwi37ml63QnK82RflUVSisqE3v0DyD32x7eNU7yHW3ZoordmquYI7MXYHEiao
dubBfDC9iU4fUxBPqg2w+vpxrOkfZlbydlL8hsi3q+rpUvEc6/i8ItuKQCTGgxpK
EQigDdbaQOvpc/tZZZQcLLFIdPXUR3/h7IU2CeTn2AIOvZR0w3aJKXBWTNM+YYBS
eaZwGOtNXwk3iPf7I31f8+qAIIsdGlqP66zxU3KtAOmaQDahhbjqxHxyKoseJNfB
F0HzvbMUnTdQzjICWpUVk8i0BoZKm+TfKWseRdhBm/vX6gFVTUYIgyF0Yj6cPQl9
siBXVJhJnmp05KW3t9F7
=7lRT
-----END PGP SIGNATURE-----

--mgHh7CjtxCqI4tCRECGM5uWuF6ciwLxH7--

--===============2562436392003513657==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2562436392003513657==--
