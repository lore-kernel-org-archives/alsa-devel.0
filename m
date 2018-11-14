From: Mark Brown <broonie@kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH 1/2] ASoC: cs35l36: Add
 support for Cirrus CS35L36 Amplifier
Date: Wed, 14 Nov 2018 11:55:14 -0800
Message-ID: <20181114195514.GZ2089@sirena.org.uk>
References: <1542134957-2395-1-git-send-email-james.schulman@cirrus.com>
 <20181113192556.GI2089@sirena.org.uk>
 <alpine.DEB.2.10.1811141254470.9698@james-tower>
 <SN2PR19MB08131DB009E1162D35CEED2DE4C30@SN2PR19MB0813.namprd19.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8885009471482401282=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E303A2677E8
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2018 20:55:24 +0100 (CET)
In-Reply-To: <SN2PR19MB08131DB009E1162D35CEED2DE4C30@SN2PR19MB0813.namprd19.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Schulman, James" <James.Schulman@cirrus.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, James Schulman <james@cirrus.com>, "Handrigan,
 Paul" <Paul.Handrigan@cirrus.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "Keepax,
 Charles" <Charles.Keepax@cirrus.com>
List-Id: alsa-devel@alsa-project.org


--===============8885009471482401282==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="diT81a9gloLbuVo+"
Content-Disposition: inline


--diT81a9gloLbuVo+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 14, 2018 at 06:54:02PM +0000, Schulman, James wrote:
> On Tue, 13 Nov 2018, Mark Brown wrote:
> > On Tue, Nov 13, 2018 at 12:49:16PM -0600, James Schulman wrote:

> >> +static const struct snd_kcontrol_new cs35l36_boost_mux[] = {
> >> +    SOC_DAPM_ENUM("Boost Enable", boost_enum),
> >> +};

> > Simple on/off conttrols should be _SINGLE controls with Switch at the
> > end of their name.  It's not super clear why this is in DAPM as a widget
> > at all, the routing around it is:

> > +       {"BOOST Mux", "On", "Channel Mux"},
> > +       {"CLASS H", NULL, "BOOST Mux"},

> > which is a bit perplexing.  Possibly this should be handled in the event
> > for the main amplifier?

> We used _ENUM instead of _SINGLE because we wanted the default value to be
> "On" instead of "Off". We don't want the default assumption to have boost
> turned off. However, we're happy to change this if you would rather have
> consitency with the _SINGLE controls.

I don't follow this at all.  Setting a default value for a control is
not related to the type of the control.

> >> +    /*
> >> +     * Rev B0 has 2 versions
> >> +     * L36 is 10V
> >> +     * L37 is 12V

> > \o/

> Yes we had 2 silicon spins for this revision >_< is there anything about
> this comment you want us to change?

You could more explicitly explain what happened here, revisions and
spins are generally synonymous so it's confusing.

> >> +    }
> >> +
> >> +    return IRQ_HANDLED;

> > This unconditionally reports that it handled the interrupt, even if it
> > didn't.  This will stop the interrupt core handling for faulty interrupt
> > lines working and will disrupt any support that gets added for handling
> > shared threaded interrupts.

> Earlier in the handler, we have a check to see if any unmasked bits are
> set. If not we return IRQ_NONE. I figured this would be enough to ensure
> we don't unconditionally report IRQ_HANDLED.

What if something you didn't expect got unmasked by some bug?

> I think we will add an err_disable_regs jump statement to ensure we don't
> try to use the uninitialized reset_gpio handle. Once we do that, I think
> this will handle -EPROBE_DEFER cleanly?

Yes.

--diT81a9gloLbuVo+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvsfaAACgkQJNaLcl1U
h9C2xAf/TzUL6LjDXyVJmLGqWYNDDyyIXbjTn5CTNIeoK6tWCPXFhUiuA/vwSdFf
sEFqgS4mNNl7e/AOwRIoqy2fTBGqWrMws2qqEBEiILkFBmFT/SpVsfHB2wyf6ojd
HmF3vwvCgobOV1B8k5Tnfc2XN9Ye3zillzqjR2rlrK33215yfarZIdAwEO7XxTj0
WQYcuyx+XcmYNWfdvoNQNxuKxoF4F3dwEnUy/Na5Ow3Ytf575jMSIMsmvOCxjRct
DUZes2n0JQW7jbTdJDwZErJKpOWEe/5XDgPn0a6kNxeaCfYgYaUvO2K91x48+PFN
OOZImaEVBoEslYUeA70p9f4S590biA==
=5sv6
-----END PGP SIGNATURE-----

--diT81a9gloLbuVo+--

--===============8885009471482401282==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8885009471482401282==--
