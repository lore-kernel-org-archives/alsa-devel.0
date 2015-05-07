From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: dapm: Add cache to speed up
	adding of routes
Date: Thu, 7 May 2015 13:48:11 +0100
Message-ID: <20150507124811.GV15510@sirena.org.uk>
References: <1430994839-32584-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1430994839-32584-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7431612418243128158=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0DC312650DB
 for <alsa-devel@alsa-project.org>; Thu,  7 May 2015 15:06:59 +0200 (CEST)
In-Reply-To: <1430994839-32584-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============7431612418243128158==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4s/bJpmTUQ8gJs0P"
Content-Disposition: inline


--4s/bJpmTUQ8gJs0P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 07, 2015 at 11:33:59AM +0100, Charles Keepax wrote:
> Some CODECs have a significant number of DAPM routes and for each route,
> when it is added to the card, the entire card widget list must be

The idea here is good but I'm having a hard time loving the
implementation.  It feels like it's hacking this specific implementation
in many different places without really abstracting things - having a
neat trick hidden in one place would be one thinng but it's spread
through several different places.

> +static struct snd_soc_dapm_widget *
> +dapm_check_path_cache(const char *name, struct snd_soc_dapm_widget *w, int n)
> +{
> +	int i;
> +
> +	if (w) {
> +		for (i = 0; i < n; i++) {
> +			if (!strcmp(name, w->name))
> +				return w;
> +
> +			w = list_next_entry(w, list);
> +		}

This will not be happy if there are fewer than n entries to look at.

>  static int snd_soc_dapm_add_route(struct snd_soc_dapm_context *dapm,
> -				  const struct snd_soc_dapm_route *route)
> +				  const struct snd_soc_dapm_route *route,
> +				  struct snd_soc_dapm_path *cache)

The fact that we're directly using the path structure as the type for
the cache here is a warning flag, it means that everywhere that knows
there is a cache at all needs to know about the specific type of the
cache.  If we were to improve the cache in the future, for example doing
something like building a hash that maps names to widgets for the
duration of probe, then everywhere would need to change.

> +	if (cache) {
> +		wsink = dapm_check_path_cache(sink, cache->sink, 2);
> +		wsource = dapm_check_path_cache(source, cache->source, 2);
> +
> +		if (wsink && wsource)
> +			goto skip_search;
> +	}
> +

This is the only place where we have _check_path_cache() calls so n is
always 2 here and it is unclear where that number comes from or what it
means without going and peering at the implementation and the commit
log.  It seems it would be better to hide that number inside the
function.

> +skip_search:
> +	if (cache) {
> +		cache->sink = wsink;
> +		cache->source = wsource;
> +	}
> +

Putting this into a store hit function would be good.

>  	mutex_lock_nested(&dapm->card->dapm_mutex, SND_SOC_DAPM_CLASS_INIT);
>  	for (i = 0; i < num; i++) {
> -		r = snd_soc_dapm_add_route(dapm, route);
> +		r = snd_soc_dapm_add_route(dapm, route, &cache);

Should we just have the cache in the dapm context or the card instead of
locally?  It's only two pointers at the minute so there doesn't seem to
be much cost from keeping it around and it might generate somme more
hits for some use cases.  Or to put it another way why is the cache
optional and created and re-created here like this?

--4s/bJpmTUQ8gJs0P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVS18KAAoJECTWi3JdVIfQZS8H/0wi5Tb5ZB6mLjIQlWnrH1E9
GhISpSAwa3iVVLf+RRd+Wa3R0GN0Ib1gIRikEpU3DR9yeKFLCi/xHELGtJYid+R1
+P9WkrnAbTc0zEGRIzy0D6AbEInz9dtewsuteMeN7zCKQJPEwS5KLAbiR+2DIUEl
39tAJYi1NYGzeTJ2KVgOjgxTLQynwR4oviJk50sRjubyzpgvRcJnKp8QoykOOWoQ
d3tGqHZEx9zDw7jucln8UchqpxjpeyiBvhZwXqde1xuztZWzx17RBsjQh4MVK+E9
B8ugOSN+uon1ILe9vMBw1smy/oHnMcC4qLZzsfGxuqtt+SBkMsqpEdkwTQ6kUEM=
=1DsB
-----END PGP SIGNATURE-----

--4s/bJpmTUQ8gJs0P--

--===============7431612418243128158==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7431612418243128158==--
