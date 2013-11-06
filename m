From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 21/31] ASoC: dapm: Use WARN_ON() instead of
	BUG_ON()
Date: Wed, 6 Nov 2013 11:48:36 +0000
Message-ID: <20131106114836.GK11602@sirena.org.uk>
References: <1383673218-18405-1-git-send-email-tiwai@suse.de>
 <1383673218-18405-22-git-send-email-tiwai@suse.de>
 <20131106102431.GM11602@sirena.org.uk>
 <s5htxfpvlib.wl%tiwai@suse.de>
 <20131106111529.GH11602@sirena.org.uk>
 <s5hppqdvk79.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6079693363981155592=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id D74522616F4
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2013 12:48:41 +0100 (CET)
In-Reply-To: <s5hppqdvk79.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6079693363981155592==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b+chlBtRKJDCtqTb"
Content-Disposition: inline


--b+chlBtRKJDCtqTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 06, 2013 at 12:33:14PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > Please fix the comment about BUG_ON() being useless; it does exactly
> > what it's supposed to do.

> Well,  I can correct the word "useless" with "stupid" in the comment,
> as BUG_ON() is the most stupid idea to do at such a point.  soc-dapm.c
> is the common code that can be executed from any others. How you can
> know that the machine *must* be killed suddenly at this point?  If you
> didn't attach the console beforehand, you can't get even any debug
> logs.

The point is that it's not appropriate in this situation but not
useless; if it were useless you should be sending a patch to remove it
=66rom the kernel entirely. =20

> Using BUG() and BUG_ON() in buggy points without any really serious
> damage (like heavy memory corruption or data corruption) has to be
> avoided.  Linus stated this in the past, too.  (I have no pointer
> now, unfortunately.)

The ones in DAPM are mostly about memory corruption; if this stuff is
getting confused then there's a good chance that the data structures
that it's looking at aren't what they're supposed to be.

> > >  	list_for_each_entry(w, pending, power_list) {
> > > +		if (WARN_ON(reg !=3D w->reg))
> > > +			continue;
> > >  		dapm_seq_check_event(card, w, SND_SOC_DAPM_POST_PMU);
> > >  		dapm_seq_check_event(card, w, SND_SOC_DAPM_POST_PMD);
> > >  	}

> > We're not using reg here...

> Because you must not issue *_POST_* events without *_PRE_* events.
> *_PRE_* are skipped for these entries in the previous WARN_ON()
> checks.

No, that's not the case at all - it's very rare for devices to have both
events in the first place.

--b+chlBtRKJDCtqTb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSeiyRAAoJELSic+t+oim9ROsP/R/nnZLq1buTLyraqrEYBBdW
Bj1I5dz8NKsScOwDiMaOZsf1SGA8tKQ3ByJO81RfPy4bBbju3/pzL1kExxW3tEZF
6vtnSwYnRU8444sA2VaFHwU+zykEIKEOnNL3y1jNvjzsOqskz3P/P+T/e4kt7NTI
0KJ6yzrQYYJ126NQdf9GJvb2AEJjHlJ98bqmV77nJHaLvHAl0Nt1mS0pXCSYFGzD
dLc0Z/iAEemJJ+W5tzJgqmsgX5txTQbNYkeIIQ0hS44KMnMuEgDZbMqjjHDPDLsg
kwo2OW19+q3FWtc2Xe+batIul3cIrIslBWdQlSgbpMtbmo8a5kM53twrExE4VCIa
RjgeZP9UqhHXbHRVwg3vDOk1hxVG+o1RY4YSSXoZfhObA3iLymaspK+w6Zp3OlqS
l2cXvL6+Zqz2ihRtE4+0zD6dopojBpwtHqp/JHYEfBIIW5e1A0vv6mfl47lsbTV+
Y0BgTi6n7Bi6sLTFrSoLlUYv73c3dHb8ual6QtIIBFjhDgoJHNqKTLuOseRAsuig
lwZ94K3IhMyiNrHHJaVI4nyz8Wz1N/fK+2ws8Ej8ltynvCTux1dIAsKGPrdD/L3Q
dFGk8g2fpmkTQqmvvx2UQSPaC3atIQvoKrspUSEVUyEe5u2jKtdARqW5dwqy29UJ
09NnPUgfurAGW9CilFRH
=S/gg
-----END PGP SIGNATURE-----

--b+chlBtRKJDCtqTb--

--===============6079693363981155592==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6079693363981155592==--
