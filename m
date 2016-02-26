From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: rt5640: add master clock handling for
 rt5640
Date: Fri, 26 Feb 2016 10:08:18 +0900
Message-ID: <20160226010818.GZ18327@sirena.org.uk>
References: <1456190782-18865-1-git-send-email-sugar.zhang@rock-chips.com>
 <56CC719C.1090901@linux.intel.com>
 <2199435.lA9iTvxnKV@phil>
 <20160224033259.GL18327@sirena.org.uk>
 <56CDD5DD.6040006@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Z0AzVEOeKznHFuth"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56CDD5DD.6040006@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Mark Rutland <mark.rutland@arm.com>, Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Sugar Zhang <sugar.zhang@rock-chips.com>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org


--Z0AzVEOeKznHFuth
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 24, 2016 at 10:10:05AM -0600, Pierre-Louis Bossart wrote:
> On 2/23/16 9:32 PM, Mark Brown wrote:

> >That said we really do need x86 to transition to use the clock API
> >in order to integrate with external devices, where the machine driver
> >does manage clocks we want that to move to being done using the clock
> >API rather than custom APIs.

> For Baytrail audio we have a single platform clock that can be turned
> on/off and set to 19.2 MHz or 25 MHz. No other controls are available,
> no multipliers or complicated dependencies on other clocks, parents or
> children and no other users for this clock but the audio subsystem.
> I looked at the clock framework and couldn't figure out how it would simply
> map the hardware so for now the use of the MCLK is only enabled with an
> on/off or set-rate(19.2|25) custom API. I am not an expert here so if this
> clock framework becomes a requirement to upstream code I would appreciate
> any pointers to do the right thing. I really couldn't find a simple example
> with 'Put your code here' comments to use this framework.

There's a lot of helpers like -fixed, -gate and so on - this sounds like
you could probably use those helpers (there should be lots of examples
in the kernel) or just implement a simple provider (see clk-provider.h)
depending on how the control is mapped in.  If it's that simple just
open coding a provider ought to do the job.  Then set up the client
linkage with clkdev in some way that makes sense for your platform.

--Z0AzVEOeKznHFuth
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWz6V8AAoJECTWi3JdVIfQ/zEH/1Kn3buUQMI86SzflJYeJtTx
KhmHdL+h1hOulR8RfrAjRyjdNZyGGEGm8ZAWbQTaApSZWjCtdwJh8dDm+/n2F3Xj
+cEi+ho8gSa4HklV+dRUGj5q1oMG2cjEQeaPcA59OF0iZH7c5CbPm9lKSR+15NOR
4tEvLK8HundYyGtBu+hmXnSNY1MaFnGNMvpZGwWoBXzH3h9/uTu+3Ae44NdAogT/
0AdLxt+lGmpAaylf1+WpCPT6+RW+5n7wjmT0rjhVpUkYLuweWka5scVUeKB5Etos
SAjbgC3OoCAEJyR591NjhCN/oV+GGWgFHE2WKauE+Sh9msYx0dd2dlzrsV2lYE0=
=5Xry
-----END PGP SIGNATURE-----

--Z0AzVEOeKznHFuth--
