From: Mark Brown <broonie@kernel.org>
Subject: Re: ASoC updates for v4.2
Date: Mon, 22 Jun 2015 14:57:29 +0100
Message-ID: <20150622135729.GR14071@sirena.org.uk>
References: <20150622092616.GN14071@sirena.org.uk>
 <s5hmvzs6p4v.wl-tiwai@suse.de>
 <20150622103034.GQ14071@sirena.org.uk>
 <s5hfv5k6l65.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5807836603567971601=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AF5AE265057
 for <alsa-devel@alsa-project.org>; Mon, 22 Jun 2015 15:57:38 +0200 (CEST)
In-Reply-To: <s5hfv5k6l65.wl-tiwai@suse.de>
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


--===============5807836603567971601==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="c1TZOjW/0w0yugbT"
Content-Disposition: inline


--c1TZOjW/0w0yugbT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 22, 2015 at 01:24:02PM +0200, Takashi Iwai wrote:
> At Mon, 22 Jun 2015 11:30:34 +0100,
> Mark Brown wrote:
> > On Mon, Jun 22, 2015 at 11:58:24AM +0200, Takashi Iwai wrote:

> > > And, looking at the code, it seems calling runtime suspend in the
> > > following way at probe:

> > >         pm_runtime_enable(&pdev->dev);
> > >         if (!pm_runtime_enabled(&pdev->dev)) {
> > >                 ret = mtk_afe_runtime_resume(&pdev->dev);
> > >                 if (ret)
> > >                         goto err_pm_disable;
> > >         }

> > I'm confused, where's the call to runtime suspend?

> It's in
> static const struct dev_pm_ops mtk_afe_pm_ops = {
> 	SET_RUNTIME_PM_OPS(mtk_afe_runtime_suspend, mtk_afe_runtime_resume,
> 			   NULL)
> };

Sorry, I'm still confused about what you're seeing in the probe - I know
where the callbacks for runtime PM are registered but I'm not seeing a
call to suspend (or something that I'd expect to trigger one) in the
above?

> But my concern above isn't about the warning itself.  I just stumbled
> on the code invoking runtime resume while looking at this warning, and
> wondered the behavior with CONFIG_PM=n.

> Usually this kind of warning could be simply fixed by adding a proper
> ifdef.  But, this driver calls runtime resume in the probe manually.

Sure, that's a fairly common pattern though?

> > > I'm not sure whether this really behaves correctly, especially when a
> > > kernel is built without CONFIG_PM.

> > Could you be more specific about the problem you're seeing?  If runtime
> > PM is disabled pm_runtime_enabled() will return false and we'll run
> > through the resume path during probe() instead, otherwise we'll runtime
> > resume whenever we need to use the hardware.

> The runtime suspend is never called when CONFIG_PM=n.  OTOH, we call
> runtime resume *always* at probe when CONFIG_PM=n.  This looks
> inconsistent to me.

Yeah, it should really resuspend the hardware in the remove path.

> If it's a part of the mandatory initialization, it should be named
> explicitly so, and make the runtime resume callback just calls it
> instead.

I disagree, I think either way is fine - if the clear intent and
expectation is that the driver is used with runtime PM it seems fine to
structure things to to say say "this is the special case path for !PM".
I'd actually like to see this pattern better supported by the core so
that drivers can enable runtime PM with calls that have !PM paths like
in this driver, it'd make the whole !PM case a lot simpler.

--c1TZOjW/0w0yugbT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJViBRJAAoJECTWi3JdVIfQKT8H/i+lwBb496vpRamfhch7mS27
F9fZGpYfkILRiWxba+Ykh5GPkxRzfUU8wYtcKO4B6X4U5CODSk+sYDnKPgVtQnzz
p17kmWSFWsrJnNjF8yibbkwhrfPvAMxzH9X6AmTV5hAanOIcVe+/gTK6+l0zzmxB
pfosxQGtmvl7K8eKa1TDpfIcvkSMnYzslipeniP8Te80ZL4ckuMEBGzoBmw35Yw1
TDDsxOim0pOoIs54dSqHbhXyQq/A8Jz+fIyGITsreWdJk47jOrZexzuKrVNiwmcJ
7582/9QiITzpAglnJcSkLLW+J6lHE561tATfVhig6m9AyYCnwnfQckXor2jgXHA=
=s1HD
-----END PGP SIGNATURE-----

--c1TZOjW/0w0yugbT--

--===============5807836603567971601==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5807836603567971601==--
