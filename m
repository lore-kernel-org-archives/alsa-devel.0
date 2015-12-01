From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dapm: Replace siggen widget type
 with mic widgets
Date: Tue, 1 Dec 2015 19:36:13 +0000
Message-ID: <20151201193613.GP1929@sirena.org.uk>
References: <1448991128-22784-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <565DED87.1030600@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3812981674577791824=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 54B4C261ADA
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2015 20:36:21 +0100 (CET)
In-Reply-To: <565DED87.1030600@metafoo.de>
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
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3812981674577791824==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2hpmsZ6F8OXGVmCg"
Content-Disposition: inline


--2hpmsZ6F8OXGVmCg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 01, 2015 at 07:57:11PM +0100, Lars-Peter Clausen wrote:
> On 12/01/2015 06:32 PM, Charles Keepax wrote:

> > The siggen widget type doesn't really require its own special handling.
> > It can be handled identically to a mic widget, ie. it is a source of a
> > signal and causes things to power up when an output is connected.

> > However, as siggen widgets present as always on (the power check always
> > returns 1), this leads to some odd interactions with DAPM.

> Sounds sensible, but I'd keep the siggen type and just change the
> power_check callback. snd_soc_dapm_mic widgets are a bit special in that
> they also influence how input and output widgets behave, we don't want the
> same behavior for siggen widgets, since siggen widgets are internal to CODEC
> while mic widgets are usually external.

Yeah, the siggen widgets were created because mics are funky - best to
just fix the bug.

--2hpmsZ6F8OXGVmCg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWXfasAAoJECTWi3JdVIfQku0H/3Cs7qx8Z7ULm+hmQ2dkn13m
/llVet1n1aIL8C9dgKC8mN/HNyQ6lD23FUiBYqKo4m78iW3cqWDeGoLA6PEOk0ZM
8lwLeZSEEkFcYxHRRK38eijg8DfB8pGvQNGtRBjWWQ9VwBBt1o+EWS0XmoqJ1Fe9
hx5nhY3keU5HxiHmFg44oFMszxhlIspgvyYbeL1XsuUqQpTSN7jSTlTSf3z5bNkM
PFVgdlHrzw3BnW8/XXfFdXoKZrbVv4r5FYShnk901RNZ6oAvwNBbaXWbSFpkCFq0
xBssXX8lucd0kDcoManddCp6ZvjrC+cr29B8WsVPcQWx5u7GcjBJl1jG/T+mfA4=
=jt3w
-----END PGP SIGNATURE-----

--2hpmsZ6F8OXGVmCg--

--===============3812981674577791824==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3812981674577791824==--
