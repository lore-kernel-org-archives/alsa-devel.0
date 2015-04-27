From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/3] ASoC: DPCM can care FE/BE merged format
Date: Mon, 27 Apr 2015 21:33:10 +0100
Message-ID: <20150427203310.GJ22845@sirena.org.uk>
References: <87mw22ufs3.wl%kuninori.morimoto.gx@renesas.com>
 <s5hr3reklel.wl-tiwai@suse.de>
 <87y4llucde.wl%kuninori.morimoto.gx@renesas.com>
 <s5hiocplv8x.wl-tiwai@suse.de>
 <20150421104210.GE22845@sirena.org.uk>
 <87pp6xm36l.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0361824839937887758=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EFBEF26041C
 for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2015 22:33:16 +0200 (CEST)
In-Reply-To: <87pp6xm36l.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0361824839937887758==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NXACYHFQzLMfb2dt"
Content-Disposition: inline


--NXACYHFQzLMfb2dt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 22, 2015 at 12:13:31AM +0000, Kuninori Morimoto wrote:

> >> Maybe I'm misunderstanding, but if this feature
> >> refines above all hw_params, it will conflicts
> >> with .be_hw_params_fixup ?

> >Yeah, there it'll need to clear the flag.

> .dpcm_merged_foramt is using bit field, like this

> 	unsigned int dpcm_merged_foramt:1;

Note that you've misspelt this - should be "format".

> I think we don't need flag control, but should I ?
> (many other options are same style in struct snd_soc_dai_link)

Not quite sure what "flag control" is here, sorry?

> > > There are indeed cases where a BE takes incompatible hw configuration,
> > > which needs be_hw_params_fixup.  But, in general, the FE's hw_params
> > > is just copied to BE.  That is, we assume here blindly that FE's
> > > configuration is compatible with BE's.  And, now this assumption isn't
> > > true in rcar's case, so we face the issue.

> > Well, it's as much that we're assuming there's rewriting going on which
> > handles things - in many of these systems everything will be going
> > through a DSP which rewrites everything on the way.

> I guess we can use .be_hw_params_fixup if it is
> "special rewrite" (ex 48kHz -> 44.1kHz, 8ch -> 2ch etc...).
> But like this case (= it needs rewrite but normally we assume it)
> using general method is useful.

> I'm happy to create/send v2 patch, but, it will be "flag" fixup ?

I'm having a bit of a hard time following, sorry.  If what you're saying
here is that if we have a fixup method we should by default assume that
only the front end constraints are relevant and ignore the back end then
that does actually seem reasonable.

--NXACYHFQzLMfb2dt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVPp0FAAoJECTWi3JdVIfQ6GYH/0ntnwy31qTM6qSQodut10k0
4Yo+4Lp7SkNaGsBNZtS8pX0iTyh7ocgy/gySGxHhy1tlBXogyvBpcA9Zwh8fTu7O
im1xU56uWtoGemDwQxF8s4WAFudBW0d0yLidkV/XuvgFRybPWesiOqHMEn28f4PR
tWDELZVR7V3A4+4cmlNezEOA3J4WYdTqMUbj302ZauoZB+jD89Tq1aWe+efvtYQk
J9YO9cv0ywHeva7X0Eby/oOu99sL+C6lQ2l9SJV7+lDw3pSVgy/etsXV7Xj4m1pa
LoNVH6XCDHWlDedn+T+bjYIwrUr4rPniddkRI4T5agxyGuEsUAQLVfJ3mbpXup8=
=qVRt
-----END PGP SIGNATURE-----

--NXACYHFQzLMfb2dt--

--===============0361824839937887758==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0361824839937887758==--
