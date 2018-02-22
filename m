From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 02/11] ASoC: rt5651: Remove
 is_sys_clk_from_pll, it has ordering issues
Date: Thu, 22 Feb 2018 10:48:16 +0000
Message-ID: <20180222104816.GA5905@sirena.org.uk>
References: <20180220221511.22861-1-hdegoede@redhat.com>
 <20180220221511.22861-2-hdegoede@redhat.com>
 <20180221111821.GA8334@sirena.org.uk>
 <7c0a41b1-6765-13e6-be96-b354c744ba29@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7257662795486680469=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9484B267684
 for <alsa-devel@alsa-project.org>; Thu, 22 Feb 2018 11:48:23 +0100 (CET)
In-Reply-To: <7c0a41b1-6765-13e6-be96-b354c744ba29@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Carlo Caione <carlo@endlessm.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org


--===============7257662795486680469==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 21, 2018 at 08:38:01PM +0100, Hans de Goede wrote:
> On 21-02-18 12:18, Mark Brown wrote:
> > On Tue, Feb 20, 2018 at 11:15:02PM +0100, Hans de Goede wrote:

> > Only if jack detection is enabled, if jack detection is not in use for
> > some reason then the PLL isn't required and should be powered off - this
> > is normally handled by having the jack detection code force enable
> > things.

> As the commit message tries to explain, the code this removes is fundamentally
> broken and this is not jack-detection related:

>    "dapm_power_widgets() first builds a list of which widgets to power-up
>     before actually powering any of them up. For dapm-supply widgets their
>     connected method, in our case is_sys_clk_from_pll() get called at this
>     point.

>     Before this commit is_sys_clk_from_pll() was looking at the actually
>     selected clock in the RT5651_GBL_CLK register. But the sysclk itself is
>     selected by another dapm-supply (the "Platform Clock" supply in the
>     machine driver) and any changes to that supply part of the same power-
>     transition get executed after building the list, causing
>     is_sys_clk_from_pll() to return the wrong value."

Right, but there's a couple of jumps in your reasoning with the actual
solution.

> As for that the PLL should be powered-off when not needed, I agree but that
> is controlled by the machine-driver through the "Platform Clock" dapm supply
> and if that leaves things on for some reason then that is the problem which
> we actually need to fix, e.g. this will also leave the MCLK input clk enabled
> needlessly.

I don't follow this bit, sorry.  If there's a DAPM supply that's being
enabled when it's not needed then we should just disable it.

> I really don't see how configuring a broken sysclk (GBL_CLK points to PLL1,
> but PLL-bit in PWR_ANLG2 is OFF) is ever a good thing, instead we should make
> sure we always switch to the RCCLK when we don't need the SYSCLK.

> Last force-enabling the PLL bit on all machines where we can do jack-detection
> (not only over-current, but the JD irq in general needs a valid sysclk) would
> in practice mean always force-enabling the PLL bit since almost all boards have
> jack-detection once we add the necessary quirks, so this really is not a solution.

A bit confused here as well, sorry - I think you're assuming I'm
suggesting some particular solution but I'm not sure what that is.

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqOn+0ACgkQJNaLcl1U
h9D9Ngf/VTLQ0+/9RWG0vX2AuxMQNpAf5b6g9eB4d9/7vtjMMPe0fQDzvivuxOiL
cEKkl2tT/sQhimZ6DqUcoGuf+zBCV2kJak92JfHgeSA4iIKK23yjBTfQZJxiwxZ4
WHlVTvGwjnUNNWcRizznXBu5h5cSsEHxxqbV0bC7x8WDdf285pIJ39S2DafskXB2
jdvMgBmGQhrb1hacc8nDzG6TJCEyAhK/uNp8GRIyZpS2sU4m3gxXRKmXQp4GkG0s
Z5RmHDm+BMRtzSnB/BX6XsUWe0zIgJU1Zh7raEvJvdYc+twkrJ2H+mVtOLjS/7Jw
5mlM2VcLciJ3Zd+6EfnS7XD4nnS5/Q==
=xa/e
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--

--===============7257662795486680469==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7257662795486680469==--
