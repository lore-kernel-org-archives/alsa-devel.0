From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5] ASoC: cs53l30: Add support for Cirrus
 Logic CS53L30
Date: Thu, 2 Jun 2016 18:17:53 +0100
Message-ID: <20160602171753.GQ2282@sirena.org.uk>
References: <1458082066-2859-1-git-send-email-tim.howe@cirrus.com>
 <20160517234333.GB29471@Asurada-Nvidia>
 <20160531165358.GH29837@sirena.org.uk>
 <CAG5mAdw-gh2_ZQ17h3HS=pMZaW-bGhoKgNDz_hbwzw2rBKs8ig@mail.gmail.com>
 <20160531173505.GI29837@sirena.org.uk>
 <CAG5mAdwB-YCiFV0L+KgULKcmRVEhHK68mBrf9UHe0s-1UBotJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2480803483326264117=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B126626047C
 for <alsa-devel@alsa-project.org>; Thu,  2 Jun 2016 19:18:13 +0200 (CEST)
In-Reply-To: <CAG5mAdwB-YCiFV0L+KgULKcmRVEhHK68mBrf9UHe0s-1UBotJQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Caleb Crome <caleb@crome.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, paul.handrigan@cirrus.com, "Howe,
 Tim" <tim.howe@cirrus.com>
List-Id: alsa-devel@alsa-project.org


--===============2480803483326264117==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="X35wERi4JU/f1kly"
Content-Disposition: inline


--X35wERi4JU/f1kly
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 31, 2016 at 03:32:05PM -0700, Caleb Crome wrote:
> On Tue, May 31, 2016 at 10:35 AM, Mark Brown <broonie@kernel.org> wrote:

> > I'm not sure why mic arrays would drive that, it's not like they're
> > particularly new or innovative technology here and multi channel output
> > has been even more widely available for a long time?

> Good point.  I guess I'm coming from the SoC/mobile world where most SoCs
> support stereo only, and a couple microphones at most.  Now phones have 3-4
> or more microphones.   Amazon echo has 7 mics.  We're working on arrays of

That's fairly rare, I'd say more of the vendors are doing programmable
serial ports and those that aren't have a different model...  see below.

> We must be looking at different sorts of chips :-)  Even on new parts like
> the Snapdragon 410, they have a super inflexible I2S only port. (up to 3
> parallel I2S for up to 6 channels, but no TDM).

Qualcomm have never really wanted anyone to use I2S in their mobile
products for quite some time now - they've always wanted to do a system
sale based on either their integrated CODECs or (in the current
production designs) their own external CODECs which normally use Slimbus
to connect to the CPU (they are working off and on on upstreaming
Slimbus, nobody else ever adopted it so there's relatively little
pressure).

> and a few other chips that I'm not familiar with.  So  there does not seem
> to be overwhelming support for TDM in Alsa ASoC.  To what extent this is a
> software vs. hardware issue could use a little investigation.

It's software and legacy hardware.

> So... if anybody knows of a Cortex A53 or A57 with good TDM support in
> linux (at least 16 channels in and out), I'd love to know about it :-)

Well, if you specifically mean TDM as opposed to multi-channel our
general support for that isn't good (mainly due to lack of demand).  It
sounds like you're more interested in multi channel here though.

--X35wERi4JU/f1kly
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXUGpAAAoJECTWi3JdVIfQZhQH/0KxgTtlmmnk+F5rGY8XtYRg
2u/QPz6D4ItOGutpSfAkgAhLq0wTyBY8j7VnjewqHhleDaErBhZtK9AomZFaBV5A
00c0aDamRzZDjKUpCNPw05xcibjxhgYWYbypOqzASDroPistodUgKHwi5CcJ0R/5
/oCHzfp+RPgAYfb/aPSf//A2741wPl955YQP06IpcposKv8dfCjzZrMwR22fdYPP
aFkT5uITpFOyeFOQUauG+tM2KeQWU+pA2KFMrIPvYp4NHN2PdlFo2/SQulUKAZuY
zOCbOabFxtxgBBADj9rj7NeT3E18t7EKtub70AfXmHJS23nfE8daBN6s14DTI70=
=BEf7
-----END PGP SIGNATURE-----

--X35wERi4JU/f1kly--

--===============2480803483326264117==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2480803483326264117==--
