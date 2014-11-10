From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Fix kerneldoc errors
Date: Mon, 10 Nov 2014 19:22:11 +0000
Message-ID: <20141110192211.GJ3815@sirena.org.uk>
References: <1415637045-20868-1-git-send-email-tiwai@suse.de>
 <20141110175508.GD3815@sirena.org.uk>
 <s5hlhniswhy.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8285004409603736089=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 91EA3265AD3
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 20:23:28 +0100 (CET)
In-Reply-To: <s5hlhniswhy.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8285004409603736089==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SfiY5U5w26VY+QNu"
Content-Disposition: inline


--SfiY5U5w26VY+QNu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 10, 2014 at 08:09:45PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > On Mon, Nov 10, 2014 at 05:30:45PM +0100, Takashi Iwai wrote:

> > > + * @list:   linked list of assigned pins to the same jack

> > I thought there was a way to mark implementation details that the user
> > isn't supposed to look at as such in kerneldoc?

> You can put /* private: */ and /* public: */ comments.  See
> Documentation/kernel-doc-nano-HOWTO.txt.

> But in this case, the list item appears as the first, so it'd become a
> bit ugly.  Also, struct snd_soc_jack_zone has already the description
> of list item, so having only one shown and one hidden would be
> inconsistent.  For these reasons, I chose to add a comment on it,
> too.

If we are going to do this sort of stuff and have people looking at the
output I'd prefer that we did do those annotations (and move things
around).  This just happened to be the first change in the diff but I'd
guess there may be some other things that are undocumented because
people aren't supposed to be looking at them (as well as ones that were
just missed).

--SfiY5U5w26VY+QNu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUYRBiAAoJECTWi3JdVIfQ1qoIAIYfFB507GqTBaju0r+Iq2J9
lziBrsJ0BM/6fUr96oQvM9jNdrEBmfQlxlSV0zfmDv/me0RtYcrX0KPD+O0DtCfe
98eaBYVeHSt768+35R2VPMrf5Sdps95rVVqKI76OMO6syks28oFYVzBcVfXBgy87
qRe97eRXxfSMUBfmcGpYEYAYvd2Jcq2cHXUX2hhljw/hrarRgjdCio+FxKALNfcC
Nr4BcEZIPk/JdX+77iGDEkdyV3d8Sm9UPbcDm890CITA8SVV/A8aRDvBsCK87vO9
xK3MyIQIPJm8FDrO4Pr/IvsNm7grdP102rHdepAIcpm8s8KLd9oD57NVdIriwA0=
=GiaL
-----END PGP SIGNATURE-----

--SfiY5U5w26VY+QNu--

--===============8285004409603736089==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8285004409603736089==--
