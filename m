From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: rt5645: Add jack detection
 workaround for MINIX Z83-4 based devices
Date: Wed, 30 Aug 2017 22:23:19 +0100
Message-ID: <20170830212318.4tolhwdafspddcry@sirena.org.uk>
References: <29ad0cbd-b58d-70e3-0647-a2d633b7e57e@gmail.com>
 <20170830211217.5s3ubddjrpngkbb7@sirena.org.uk>
 <CAFXWsS_GL+xGPZc-ySjRqEejp=GPU9qkE80zaCZge63QiwnQkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4244281005140495762=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 747A2267217
 for <alsa-devel@alsa-project.org>; Wed, 30 Aug 2017 23:23:20 +0200 (CEST)
In-Reply-To: <CAFXWsS_GL+xGPZc-ySjRqEejp=GPU9qkE80zaCZge63QiwnQkw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ian W MORRISON <ianwmorrison@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4244281005140495762==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i3uqgyek7l4zu6xp"
Content-Disposition: inline


--i3uqgyek7l4zu6xp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 31, 2017 at 07:16:10AM +1000, Ian W MORRISON wrote:
> On 31 August 2017 at 07:12, Mark Brown <broonie@kernel.org> wrote:
> > On Thu, Aug 31, 2017 at 07:04:31AM +1000, Ian W MORRISON wrote:

> >> v2: Applied and tested again sound -b for-next and linux-next -b master

> > You're submitting this to me, it needs to apply to *my* tree:

> >    git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git

> Yes, v2 is now applied and tested against your
> git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git using
> branch for-next. Is that correct or should I use a different branch?

Are you sure you're up to date there?  It didn't apply against either
the rt5645 branch or my for-next branch, I applied a few Realtek patches
earlier today.

--i3uqgyek7l4zu6xp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmnLMYACgkQJNaLcl1U
h9C6Ugf+KG36fmOUhI46irTzdRLGiWM3PZG+7GbBE6A2jXq3zaH3oh37ZI1ov75P
LWOzYHt+XreEEkcVjW5UjfWBXIwzNjsg2Hq2CNla/PYOnxghxnHNeI/Tc7lTbsu4
vinVaIyR8CiPO5hLZHLMu7to10ixS9+OOQ3WMTAM1uTS77tswlwpEodmxYi2m707
UZEiqv1B6irxIfWOn4pyFmbZljlNjnrwJMhhIznqutYseVdgIz+aFYH650ARgdLR
/szL7sVLNSxHgXZUKYKn4R73LL+B4Vhuv1eUqwnacLJOEVr9GmkTuoZqCHJ+7sC/
vib/ocf40ctJz0R24CtiNTVCK1SCHw==
=44f4
-----END PGP SIGNATURE-----

--i3uqgyek7l4zu6xp--

--===============4244281005140495762==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4244281005140495762==--
