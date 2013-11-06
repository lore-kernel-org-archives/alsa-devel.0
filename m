From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 21/31] ASoC: dapm: Use WARN_ON() instead of
	BUG_ON()
Date: Wed, 6 Nov 2013 23:48:06 +0000
Message-ID: <20131106234806.GD2674@sirena.org.uk>
References: <1383673218-18405-1-git-send-email-tiwai@suse.de>
 <1383673218-18405-22-git-send-email-tiwai@suse.de>
 <20131106102431.GM11602@sirena.org.uk>
 <s5htxfpvlib.wl%tiwai@suse.de>
 <20131106111529.GH11602@sirena.org.uk>
 <s5hppqdvk79.wl%tiwai@suse.de>
 <20131106114836.GK11602@sirena.org.uk>
 <s5hk3glvisi.wl%tiwai@suse.de>
 <20131106160304.GA2674@sirena.org.uk>
 <s5h1u2twin3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2446276677038674078=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C121265454
 for <alsa-devel@alsa-project.org>; Thu,  7 Nov 2013 00:48:10 +0100 (CET)
In-Reply-To: <s5h1u2twin3.wl%tiwai@suse.de>
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


--===============2446276677038674078==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iVCmgExH7+hIHJ1A"
Content-Disposition: inline


--iVCmgExH7+hIHJ1A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 06, 2013 at 06:21:36PM +0100, Takashi Iwai wrote:

> So, basically what such lazy people would need is a knob to make
> WARN*() triggering panic().  But this shouldn't be done
> unconditionally for all DAPM usages, or better in all sound driver
> usages.

Sure, it's a bit nicer in some situations.  My point is that you're
greatly overstating the problems with asserting in practical usage.
The environment and productisation process used with this stuff is
different to that for PCs.

> BTW, another substantial problem is that this dapm code doesn't handle
> any errors...

Feel free to send patches.  I've never considered it a high priority to
go through and add stuff there since the unwinding code is way more
effort to write than it's worth and would never get tested - generally
where constructive error recovery is possible the natural user reaction
of stopping and restarting things is about as constructive as it gets
anyway.  There's always something more pressing to work on.

> > They shouldn't be generated unmatched but it's extremely rare for them
> > both to actually be used by one widget.

> So, the unprocessed list item must be filtered out.

I don't understand what you mean by this?

> >  To the extent that they're used
> > matched it's with the PRE_PMU matched with POST_PMD and vice versa,
> > though using just one is quite common for inserting delays.  It's going
> > to cause more harm than good to actively suppress events.

> It won't suppress any events that have been working.
> Remember that there's been BUG_ON() with the very same condition
> before the patch.  Thus any good-working cases must not hit with this
> conversion.

But then we're still left with bombing out if the first half of the
function ever changes.  The check is there for the benefit of the
register handling, the fact that it's affecting events is just a side
effect rather than the intention.

Remember also that BUG() can be disabled so there is a faint chance that
we'd not trigger, and of course the issue might be introduced between
the two events.

--iVCmgExH7+hIHJ1A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSetUzAAoJELSic+t+oim9qC4P/j2yKfRuryshlm0rKaRN5cBf
vB36DaLiaK4gk+BLlrK1LFY+2ZGdEn6DyUVVzcg5CjjVRvvC8MqNd4JQDcR1c80F
1xOx0EfvEKJjNwuu2fdgsmRVAknPuR20APku0zjYGW0wlJeZkjZKXdVrjYwa/RhP
3zG4cuPyqNTV7KavU5hj/b+SUYRB3qozGF5ZPmmZ1I+2bsUGf4yVSUun6AyDjYsJ
+0CeHz5LiRxC/i+Y2R3NuxOl930S51f/8gSOXHwtqdSPoWmI2YP99oHQ9TkvSt8C
cHJ5CcPQeQiVwRpnrR+jmktITzNotLKSBLhJEOYnyE9HZKq0C2DoFcM90cvGYRfy
Obqeu5nTIogw7Mqt9MkCeCBqKC6wZEQf1ANDhnkfqgypBr2SQ26tSj/kI4M4NirP
nxEqU+T1ni5Lfv7Dvgv1tFKdDxY/zf2aGb+ZigIo+L3NDPNGlOirSvdjU+mw8D/q
v8MGSfj5EMGfSb+HI2h3SpFfLVynk2izx+8MK4uie2rOOAO9nCswAzvNgExd6OMD
by5SyhdH/l4aMIKW7iaZeKNCLN4hYRElXzJHRH2AsZ1Kr1A3KnmQqYoXbwNc2Vsr
CFJNzseSOOp/7nwh7JHyFAkEJKd2Z9muSworXqXQ60UkLB3vdc20zArzK7f//zP2
XeYzUIioVK7QZSMFyX8Y
=eUpu
-----END PGP SIGNATURE-----

--iVCmgExH7+hIHJ1A--

--===============2446276677038674078==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2446276677038674078==--
