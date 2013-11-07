From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 21/31] ASoC: dapm: Use WARN_ON() instead of
	BUG_ON()
Date: Thu, 7 Nov 2013 11:31:45 +0000
Message-ID: <20131107113145.GT2493@sirena.org.uk>
References: <20131106102431.GM11602@sirena.org.uk>
 <s5htxfpvlib.wl%tiwai@suse.de>
 <20131106111529.GH11602@sirena.org.uk>
 <s5hppqdvk79.wl%tiwai@suse.de>
 <20131106114836.GK11602@sirena.org.uk>
 <s5hk3glvisi.wl%tiwai@suse.de>
 <20131106160304.GA2674@sirena.org.uk>
 <s5h1u2twin3.wl%tiwai@suse.de>
 <20131106234806.GD2674@sirena.org.uk>
 <s5hbo1wekgg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0001743540928643309=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A191261722
 for <alsa-devel@alsa-project.org>; Thu,  7 Nov 2013 12:31:49 +0100 (CET)
In-Reply-To: <s5hbo1wekgg.wl%tiwai@suse.de>
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


--===============0001743540928643309==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hrnpeiJmytOBrElT"
Content-Disposition: inline


--hrnpeiJmytOBrElT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 07, 2013 at 08:31:59AM +0100, Takashi Iwai wrote:

> > But then we're still left with bombing out if the first half of the
> > function ever changes.  The check is there for the benefit of the
> > register handling, the fact that it's affecting events is just a side
> > effect rather than the intention.

> Actually the check reg == w->reg must be always true for all pending
> items, no matter at which point.  Otherwise BUG() would have hit.

Right, but that's not actually what the check is there for.  The loop is
both doing an event check and building up the register value to write,
the check is to tell us if we're confused about the register value since
we'll end up writing to the wrong register during coalescing.

> That being said, maybe a cleaner way would be to run the check over
> the loop once, and quit the function if anything inconsistent found.

Or do two passes, one for the registers and one for the events.  You
could also reorder the loop to pull the events to the top and then do
the check and skip between them and the value update, or simply remove
the BUG().

Or just don't worry about it and leave the second loop alone since none
of this is ideal - possibly the most helpful thing would be to insert a
non-coalesced write for the out of place widget, though depending on why
things are going wrong perhaps that'll just make things worse and we
should be trying to unwind the entire transaction instead.  Unwinding
the entire thing is going to be the generally safest but least helpful
option.

My main concern here is not to confuse the code by having the check for
the register value protecting an event call, that'll be confusing later
on.  If you just want to fix the BUG()s do that alone, change them to
WARN()s or whatever.

--hrnpeiJmytOBrElT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSe3odAAoJELSic+t+oim9T30P+wUc1ovnL93LiP4mV1hQRF88
KMe1gWJrhupzgWIVrK0Gheb1yXVMca9mRQIF7ySr2Kf/MpNOQbuLJoYmz42mIwl1
iE3S4e+b9ljRLodHMQNiyo0uXkZIw7UP4I5lnicXXB8NUypguS9vfkmwYf4b7jd7
WgMccufFjI7Ny38NZX/3FE/VB3ijKyRp0Qd3lbn9pSZ4xtVeTiRVM/ofASbf07dG
2VodaNfjm7Nx/tnSVBXKwIMowXpTFEzO40DFuD2ZxL6slwGZanD3TgutzpO5y+yv
iikb/jq3CzIrOKcFS8kHlm0VcXcZpg36d7MHrxSploUX3xIDyklHH9exGFRmvm+h
4lcKPC6Te8b6sZLbEkp6XsRsaKEYRcoe5yicgP6GFNAmf746AAMDULB0WDRlswxj
P77Z98sz+bdRjWhxSgXeB8kJYx2FzzsxcHkJo8gnNRO1nN1VWBbIpLEmp2dxHpjt
lXMruRsCXrDVuCPODkIjzNzUkmvsF6i5FOg5UKqtw9RkTR9cfqDVicjGxbLKUCo+
ezgUP9Gmn+eBU8wVqyEOs9a0TS5RF44RADLyfwWJmExDO1X41Jdj+rxWh5D9O24K
VMaYKMdTzYDeRKNNfScQ+ORA/Pb9bsG7EiigejSA2WQWLBb/v3GbDU9amAetx828
8hWt1iwhWJ4mB5ILQm2k
=Pkca
-----END PGP SIGNATURE-----

--hrnpeiJmytOBrElT--

--===============0001743540928643309==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0001743540928643309==--
