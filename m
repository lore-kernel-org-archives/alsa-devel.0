From: Mark Brown <broonie@kernel.org>
Subject: Re: ASoC updates for v4.2
Date: Mon, 22 Jun 2015 15:43:38 +0100
Message-ID: <20150622144338.GS14071@sirena.org.uk>
References: <20150622092616.GN14071@sirena.org.uk>
 <s5hmvzs6p4v.wl-tiwai@suse.de>
 <20150622103034.GQ14071@sirena.org.uk>
 <s5hfv5k6l65.wl-tiwai@suse.de>
 <20150622135729.GR14071@sirena.org.uk>
 <s5h1th37s13.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5356519456589905761=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 053062650EE
 for <alsa-devel@alsa-project.org>; Mon, 22 Jun 2015 16:43:46 +0200 (CEST)
In-Reply-To: <s5h1th37s13.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Koro Chen <koro.chen@mediatek.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5356519456589905761==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QH7PnJlwq6+Q/jfo"
Content-Disposition: inline


--QH7PnJlwq6+Q/jfo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 22, 2015 at 04:10:32PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:
> > > Mark Brown wrote:
> > > > On Mon, Jun 22, 2015 at 11:58:24AM +0200, Takashi Iwai wrote:

> > > > > And, looking at the code, it seems calling runtime suspend in the
> > > > > following way at probe:

> > > > I'm confused, where's the call to runtime suspend?

> > Sorry, I'm still confused about what you're seeing in the probe - I know
> > where the callbacks for runtime PM are registered but I'm not seeing a
> > call to suspend (or something that I'd expect to trigger one) in the
> > above?

> There is no place calling runtime suspend manually, that's why the
> compiler catches and warns.

Right, that's why I was confused - you said it was calling runtime
suspend.

> > > But my concern above isn't about the warning itself.  I just stumbled
> > > on the code invoking runtime resume while looking at this warning, and
> > > wondered the behavior with CONFIG_PM=n.

> > > Usually this kind of warning could be simply fixed by adding a proper
> > > ifdef.  But, this driver calls runtime resume in the probe manually.

> > Sure, that's a fairly common pattern though?

> Depends.  The more common pattern seems to call pm_runtime_resume().
> And this will skip the call of runtime PM when CONFIG_PM=n.

That's another way of doing the same thing but it still leaves the same
thing with sharing the runtime code - if the runtime suspend and resume
paths are the same as the normal power up/down sequence you need to have
an explicit call to the shared power up function somewhere in probe and
can't ifdef things.

It does also mean that there's always going to be a bounce on of the
power in probe which is a bit sad though hardly the end of the world.

--QH7PnJlwq6+Q/jfo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJViB8ZAAoJECTWi3JdVIfQFOQH/1h/8MyC9+39AtVlwUrliq0s
5snVhql5dWMYRi0VtWIla9TnyYvW3ocqRWiZ73TtVT1ECn24/umxzG7hzZJcRYT4
yWIIUBDg76zYBuK5f3rMb6gKEMmA8cOou7GGR5ZMkm1KU+Qjdyt/uT0T6D2j/ZWS
NoHKHRDA3tcdmDYcc5CYg7Hv/rCQKyXPrMerblSYLBl+8CigdtGmYVQMVipQuXsT
JIv2TeTFMb1Mf8lNJb+cFrfx6iXcdx8xpuXk27lEOiqC/vOf0KZ/YP9ecGjyh3dz
DWP49TaQPuZSF2F1PeD8uhLm/Ugjg/QCfem+uAaE9zI4rxPRaE8pLP/FrGE/LEQ=
=Jsmy
-----END PGP SIGNATURE-----

--QH7PnJlwq6+Q/jfo--

--===============5356519456589905761==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5356519456589905761==--
