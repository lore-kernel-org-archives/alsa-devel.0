From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: snd_soc_tas5086: Reinit register
	values on probe
Date: Wed, 25 Mar 2015 10:48:31 -0700
Message-ID: <20150325174831.GK3572@sirena.org.uk>
References: <1427297379-17736-1-git-send-email-pascal.huerst@gmail.com>
 <20150325162029.GF3572@sirena.org.uk> <5512F06B.1030301@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4896771592127707691=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A69152608C7
 for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2015 18:48:13 +0100 (CET)
In-Reply-To: <5512F06B.1030301@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pascal Huerst <pascal.huerst@gmail.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, tiwai@suse.de, lgirdwood@gmail.com, zonque@gmail.com, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============4896771592127707691==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kswDJesP0akhmDn8"
Content-Disposition: inline


--kswDJesP0akhmDn8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 25, 2015 at 06:29:15PM +0100, Pascal Huerst wrote:
> On 25.03.2015 17:20, Mark Brown wrote:
> > On Wed, Mar 25, 2015 at 04:29:39PM +0100, Pascal Huerst wrote:

> >> If the machine driver has been un/reloaded, the register values of
> >> the codec driver have to be reinitialized in order to run properly.

> > Hrm.  This isn't something that I'd expect to be required - I'd expect
> > that as part of the machine driver teardown to put the hardware into a
> > reasonable default state so that things come back as normal.  Can you be
> > a bit more specific about the problem that you are seeing?  We probably
> > shouldn't need the existing reset that's in the ASoC level probe either.

> The symptom is, that if I rmmod the machine driver and then modprobe it
> again. The codec does not play audio at all. I can call aplay without
> any problems, but there is no output. My guess was that I have to
> rewrite the default values after a reset. May be regmap_reinit_cache()
> is the better choice to reinit the register values? Not sure about that.

That's not really answering my question at a low enough level - what
exactly is changed in the device as a result of rewriting all the
registers?

> > I do think a version of this is useful regardless of the above...

> >>  	tas5086_reset(priv);
> >> +	regcache_mark_dirty(priv->regmap);

> > Since the device has hardware reset support we really ought to be able
> > to do the register cache resync only if the reset GPIO is missing.  How
> > about putting your code into the reset function and doing it in the
> > case where the reset GPIO is missing?  That way anything that thinks
> > it's resetting the device will get the benefit of your code.

> I thing this would not fix the issue. I do have a hardware reset. In
> that case my code would not be called at all and I would face the same
> issue (no audio output) again.

So you're saying that doing a hardware reset of the device isn't
actually resetting the device?  That suggests that either the hardware
reset code isn't working for some reason or there's a bug somewhere
else.

If the rewrite of all the registers is doing anything other than writing
the values that the registers already have that suggests we're just
randomly bashing on the device in the hope that it works...

--kswDJesP0akhmDn8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVEvTuAAoJECTWi3JdVIfQ644H/j6r/566bH8DBt3zlLYBJLf6
eWpc3Hlh+wb9jlef7+lJzkj9qcD+O1VTtiw/Ohi5VJh9vq2gyqQ85ZOon46dWv8v
/CQ+43xCY/cS3BpffBUIQ9/sGCNsJFR5duawx26fcDffyZa6kDqapfxHCnmGIXQB
iel6CeMckgiXga5qtplTKLxAOwB0Gl6gcgikonBeoLryRtXrWEMTHaYJPrn+S6T8
6NMCVcPpbv2vgfuAUAM7Uth1C0v5xBo6CSa9gTH+dnLhVQpTk7VjOvC4SsjiPOg3
hHWTvhTe/+cc6p6h3xWf+Fgscz5wecv2EjjpuotcM9jsQTruxDeab9FXnB8t6Ng=
=0Gaa
-----END PGP SIGNATURE-----

--kswDJesP0akhmDn8--

--===============4896771592127707691==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4896771592127707691==--
