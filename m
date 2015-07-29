From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/5] ASoC: dapm: Consolidate input and
 output path handling
Date: Wed, 29 Jul 2015 14:14:39 +0100
Message-ID: <20150729131439.GF20130@sirena.org.uk>
References: <1437930302-2789-1-git-send-email-lars@metafoo.de>
 <1437930302-2789-4-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5594842941496403699=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4CF0D260639
 for <alsa-devel@alsa-project.org>; Wed, 29 Jul 2015 15:14:59 +0200 (CEST)
In-Reply-To: <1437930302-2789-4-git-send-email-lars@metafoo.de>
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


--===============5594842941496403699==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ULyIDA2m8JTe+TiX"
Content-Disposition: inline


--ULyIDA2m8JTe+TiX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 26, 2015 at 07:05:01PM +0200, Lars-Peter Clausen wrote:

> Testing on ARM shows that the combined code size of the specialized
> functions is about 50% larger than the generlized function in relative
> numbers. But in absolute numbers its less than 200 bytes, which is still
> quite small. On the other hand the generalized function increases the
> execution time of dapm_power_one_widget() by 30%. Given that this function
> is one of the most often called functions of the DAPM framework the
> tradeoff seems to be worth it.

This reads like you mean to say that it's worth it to combine things in
spite of the 30% speed hit...  you're not clear which tradeoff you mean.

> To avoid this still keep two versions of these functions around, one for
> input and one for output. But have a generic implementation of the
> algorithm which gets inlined by those two versions and then let the
> compiler take care of optimizing it into specialized versions.

=2E..which the compiler presumably actually manages to do.

> --- a/include/sound/soc-dapm.h
> +++ b/include/sound/soc-dapm.h

> +/**
> + * snd_soc_dapm_widget_for_each_sink_path - Iterates over all paths in t=
he
> + *   specified direction of a widget
> + * @w: The widget
> + * @dir: Whether to iterate over the paths where the specified widget is=
 the
> + *       incoming or outgoing widgets
> + * @p: The path iterator variable
> + */
> +#define snd_soc_dapm_widget_for_each_path(w, dir, p) \
> +	list_for_each_entry(p, &w->edges[dir], list_node[dir])

This is a macro not a static inline?  The other macros that use this are
macros but that's more outdated code than anything I think, might be
worth fixing that while we're at it.

>  #define DAPM_UPDATE_STAT(widget, val) widget->dapm->card->dapm_stats.val=
++;
> =20
> +#define dapm_widget_for_each_path_safe(w, dir, p, next_p) \
> +	list_for_each_entry_safe(p, next_p, &w->edges[dir], list_node[dir])

It's a bit odd not to have this in the header next to the unsafe
version.

> +#define SND_SOC_DAPM_DIR_REVERSE(x) ((x =3D=3D SND_SOC_DAPM_DIR_IN) ? \
> +	SND_SOC_DAPM_DIR_OUT : SND_SOC_DAPM_DIR_IN)
> +
> +#define dapm_for_each_direction(dir) \
> +	for ((dir) =3D SND_SOC_DAPM_DIR_IN; (dir) <=3D SND_SOC_DAPM_DIR_OUT; \
> +		(dir)++)

Eew.

>  	list_for_each_entry(w, &card->widgets, list) {
> -		w->inputs =3D -1;
> -		w->outputs =3D -1;
> +		w->endpoints[SND_SOC_DAPM_DIR_IN] =3D -1;
> +		w->endpoints[SND_SOC_DAPM_DIR_OUT] =3D -1;

Loop over the endpoints array in some of the users like this perhaps?

> +	dapm_for_each_direction(dir) {
> +		rdir =3D SND_SOC_DAPM_DIR_REVERSE(dir);
> +		snd_soc_dapm_widget_for_each_path(w, dir, p) {
> +			if (p->connected && !p->connected(w, p->node[rdir]))
> +				continue;

Looks like dapm_for_each_direction should be
snd_soc_dapm_for_each_direction - the above looks wrong.

--ULyIDA2m8JTe+TiX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVuNG+AAoJECTWi3JdVIfQmNcH/2HDPs08r+CDhiSMSSoo9bMj
BNN8yEbV4SW8Vr1vwQKmbfF16ipuxIg3GHtVo4E1o+xeQnr/bd3cHqNmhTxlV2/A
GcLhP+BGB2Tl5pwIADbhRADBqUWASrQdzM8rdjjrPf817rxC4mWhnrdxOaVWZyOq
FDTnZjdJBlRRC0oEpcyWdqLjFQDMHDIdDXu7hxo4r0gU6HTxkM8A9ad8Tl8cfP7a
cRrXntU3srO7U6OajVgut1Pc0MdEDJvvS4uoEw0NoKyzCs/y16B/QNeNPnjUYUDK
8hx70Tyzdzd0XTAVtNo3plC1eKnbo2gieX1xG8xgKG0I0BwU5YJfhUMkQGIOUhA=
=R2VX
-----END PGP SIGNATURE-----

--ULyIDA2m8JTe+TiX--

--===============5594842941496403699==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5594842941496403699==--
