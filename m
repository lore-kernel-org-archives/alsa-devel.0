From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Linux Kernel-3.5 crashed as dapm is not supported
	by codec
Date: Wed, 7 Nov 2012 15:56:07 +0100
Message-ID: <20121107145606.GJ20844@opensource.wolfsonmicro.com>
References: <505AFB0B.7010306@st.com>
 <20120920114951.GJ17666@opensource.wolfsonmicro.com>
 <505BE5BB.5010008@st.com> <5098E929.7040404@st.com>
 <20121106114323.GD10080@opensource.wolfsonmicro.com>
 <5099F265.6010008@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8014409137324934870=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 29D30265020
 for <alsa-devel@alsa-project.org>; Wed,  7 Nov 2012 15:56:10 +0100 (CET)
In-Reply-To: <5099F265.6010008@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rajeev kumar <rajeev-dlh.kumar@st.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============8014409137324934870==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="e5GLnnZ8mDMEwH4V"
Content-Disposition: inline


--e5GLnnZ8mDMEwH4V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 07, 2012 at 11:02:21AM +0530, Rajeev kumar wrote:

> Turn on logging does not helping in giving any extra information in
> this case. Backtracing the code gives me the line number. Please
> find below the information.

Perhaps if you were to share the logging someone might spot something,
or perhaps if you thought about the logging in more detail...

> static void soc_dapm_shutdown_codec(struct snd_soc_dapm_context *dapm)
> 3540 {
> 3541         struct snd_soc_dapm_widget *w;
> 3542         LIST_HEAD(down_list);
> 3543         int powerdown = 0;
> 3544
> 3545         list_for_each_entry(w, &dapm->card->widgets, list) {
> 3546                 if (w->dapm != dapm)
> 3547                         continue;
> 3548                 if (w->power) {
> 3549                         dapm_seq_insert(w, &down_list, false);
> 3550                         w->power = 0;
> 3551                         powerdown = 1;
> 3552                 }
> 3553         }

> If you check line number 3545, it is trying to get widget from card.
> and the system get crashed as there is no entry for dapm in the card.

Your analysis does not appear to correspond to the code.  The DAPM
context is being used to find the card here, not the other way around as
you say.  How have we managed to get an active DAPM context which isn't
part of a card?

> As I mentioned previously, I have provided widgets support only at
> codec level not at platform/machine level. So extracting widgets
> from card may create an issue.

> Note:
> Just to make an experiment, I have added a single widget in machine
> driver then also I am getting the same crash log.

So if you've tested this and found that this is not related to having
widgets in the card what is making you continually mention that you
don't have widgets in the card?  Having no widgets outside the CODEC is
totally normal.

--e5GLnnZ8mDMEwH4V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQmnZ5AAoJELSic+t+oim9dcEP/jOIocR487t2Sla7koBvwngf
a44TqpkfTLdpn2NMhxF95evvICbxxEjsUYi4gnKTRTt2Crow99oYx+Kswi1ZcHrU
DNqxxqJCF/fRh3njZOq7Ii0IEQQzHixGlcdcgR6l1j1yICcMiof2XqWztxo9YL2G
uXVqWUgXjmI8zF5LlzRZXvISEE+Vvt8kzHS4cI3vf3mwA6MM+P1+u7/M/rQdsuIx
c+QXYIEWb7O7kaw+4d9Cd7NANuHLmaO4dGPR27yGr1f7ufvt/juvdwSxHiivxofg
af304QEVli4vjjrYSaeFhPLPuR5H/KmasfjZ5KykDmaBKx9JhJmwYXkp9CARqZCa
GFpu/U//TYicybpC3KHz7dfDr2aQm7lo08p0d14tC5LSIx46aoQ2QMu+Ahbo+7TG
FtCVdT6SW+DmmtxxxZ/SFXDg8or9Nupk4Vgw8qaBRHM0Uilgb9MJzo7y2yJlmz11
hEHhTLF9iK9un2Cj5d+tiweGIzgKLwHjwfOexEajRGxUMkdKMcji2R9wJA88EDbL
1uFYPcksAdYyb4KPj1m9mNzWW8rRDtFujphFyVkBBYiVZJE+HVYBWxvhT7G0Yc5u
AEYxYTaT1v8/gKduHCZCh9Jrn/o59Kqk/FhLlSDQ/yyK4cRM1Ck9KoGh4b+513cK
Lki8f+BT5tYenOW9VUlJ
=BLyH
-----END PGP SIGNATURE-----

--e5GLnnZ8mDMEwH4V--

--===============8014409137324934870==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8014409137324934870==--
