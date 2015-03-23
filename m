From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 0/2] ALSA: jack: Refactoring for jack
 kctls
Date: Mon, 23 Mar 2015 09:52:51 -0700
Message-ID: <20150323165250.GG14954@sirena.org.uk>
References: <1426865953-1606-1-git-send-email-yang.jie@intel.com>
 <550FDA5B.8020604@canonical.com>
 <20150323150031.GB14954@sirena.org.uk>
 <s5ha8z34uoi.wl-tiwai@suse.de>
 <20150323163543.GD14954@sirena.org.uk>
 <s5hy4mn3c01.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0360846636505216816=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D65A5260531
 for <alsa-devel@alsa-project.org>; Mon, 23 Mar 2015 17:52:27 +0100 (CET)
In-Reply-To: <s5hy4mn3c01.wl-tiwai@suse.de>
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
Cc: liam.r.girdwood@intel.com, alsa-devel@alsa-project.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org


--===============0360846636505216816==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="t4apE7yKrX2dGgJC"
Content-Disposition: inline


--t4apE7yKrX2dGgJC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 23, 2015 at 05:38:22PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > > Now the question is whether we need representing the same item for
> > > input jack, even though it's nothing but a place holder.  If we want
> > > to have consistency between input and kctl jack items, then yes.
> > > OTOH, we might want to drop buttons from kctls in anyway, so such a
> > > consistency has no importance.  Then we may just ignore phantom jacks
> > > for input jacks but create only phatom jack kctls, too, either by
> > > adding a new flag to indicate that, or let type=0 behaving like that.

> > I'm not sure I see the relevancy of buttons here?

> Well, you pointed that buttons are needed only for input devices, that
> implicitly means that we don't need to create kctls for buttons.

OK, right - if we had a jack that was button only and didn't have any
capability for detecting accessories.  That'd be a bit odd though.

> That is, it's not guaranteed that all jack items have to be present in
> as both input and kctl.  Following this logic, we may make phantom
> jacks only appearing in kctls but not in input.

Right, I understood that bit - I was just confused about the buttons.

--t4apE7yKrX2dGgJC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVEETiAAoJECTWi3JdVIfQ4VwH/RBJ3biQC3nyMqse7nmYvBhF
E8S7KUhX0c/OH2S9RQTbXqgVmu6iU2s2WPPXw1Hxf+3qi3Lycf5jriUFxUPazlQR
E1IMQEqTNaFlJ6uBWknlIv1JydSXVoVX6ZeEp+dbMRV56v3r9aMbcE0bKqHgy1r1
bVqdm9hIh4MyeMg8e8XgwjF1JRuAIyDoAoRi9rAypQwMRUfbuo7ZtU1n5FT53leQ
mWGr1WRX3S/jdrfOARRqJ8sl4K+w3ae35dQxZNUkKVmp5A/w6TVu4pSLkMzXruNO
zWT86wxEYsZXmpc4XGQLC5OqF5vwlag7/U7l7SMCxrTpL/F4QeIUF5X9MXGArHA=
=Y/cs
-----END PGP SIGNATURE-----

--t4apE7yKrX2dGgJC--

--===============0360846636505216816==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0360846636505216816==--
