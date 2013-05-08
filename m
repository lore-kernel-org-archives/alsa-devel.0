From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 2/6] ASoC: ux500: Do not clear state if already idle
Date: Wed, 8 May 2013 13:03:26 +0100
Message-ID: <20130508120326.GF3459@gmail.com>
References: <20130508080448.GG3102@gmail.com>
 <1368002354-15471-1-git-send-email-fabio.baltieri@linaro.org>
 <20130508103401.GX7478@sirena.org.uk>
 <20130508110451.GC3459@gmail.com>
 <20130508113124.GH7478@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130508113124.GH7478@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Fabio Baltieri <fabio.baltieri@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Ola Lilja <ola.o.lilja@stericsson.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 08 May 2013, Mark Brown wrote:

> On Wed, May 08, 2013 at 12:04:51PM +0100, Lee Jones wrote:
> > On Wed, 08 May 2013, Mark Brown wrote:
>=20
> > > Ugh, please don't do stuff like this - you're posting an individu=
al
> > > revision of a patch buried in the middle of a thread.  This just =
makes
> > > things hard to follow and error prone.  Repost the patch series
>=20
> > It's so much more convenient to do it this way. Re-sending entire
> > patch-sets for small fixups is clumsy and annoying at best. Creatin=
g
> > even more prone to error.
>=20
> Then consider what happens as soon as you get more than one update to
> the patch, or there's any meaningful discussion on the patches - pick=
ing
> out which of many versions in bifurcating threads.  You shouldn't eve=
n
> assume that followups to the patches are being read, for example if i=
t's
> clear that there's revision required and it's all device specific
> discussion rather than framework stuff I'll often just stop reading t=
he
> thread and wait for the respost.

<snip>

> > Surely most people have their mail setup as threaded? Then the
> > time-line and subsequent patch versions are very easy to follow are=
n't
> > they? I get a nice trace like this:

<snip>

> This doesn't work nearly so well once you start getting meaningful
> discussion, multiple branches on the thread and indentation can make =
it
> hard to spot where the latest patch is and it's still more effort to
> find the latest version.

Yes, of course one still has to use common sense. If this happens then
I'd say a re-post would be the obvious thing to do. I'm speaking more
about situations such as this, where the discussion is trivial and the
fixup, less so.

> > > or wait until what can be applied is applied then repost.
>=20
> > Taking patches out-of-order, or 'willy-nilly', is asking for troubl=
e.
>=20
> We've been through this repeatedly.  If your early patches won't work
> without the later patches then you need to improve your early patches=
 so
> they stand alone.

It's never okay for early patches to rely on later ones and yes, all
patches should be as orthogonal as possible. But it is okay for later
patches to rely on earlier ones.

Besides, I was more referencing the massively increased effort
imparted to the developer by applying patches in an arbitrary order.
=46orcing the developer to rearranging and rebase the patch-set causing
unnecessary merge conflicts. It's better if the maintainer takes the
patch-set in the order it was written to prevent unnecessary (which is
the key word here) such things.

> Asking people to re-review an enormous patch series
> because of a change at the end isn't helpful

I completely agree. Hence why I reap Acks and apply them on next
submission to show the maintainer what they have reviewed and accepted
already.=20

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
