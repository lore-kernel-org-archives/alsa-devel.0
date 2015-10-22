From: Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH v4 5/8] clk: rockchip: Allow the RK3288 SPDIF clocks to change
 their parent
Date: Thu, 22 Oct 2015 05:10:00 -0700
Message-ID: <20151022121000.20687.48364@quantum>
References: <1444311079-2892-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <11755202.f1LLWMlYi0@phil> <1444390555.9895.271.camel@collabora.co.uk>
 <1745884.LUbKvMh2Tj@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1745884.LUbKvMh2Tj@diego>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Cc: linux-rockchip@lists.infradead.org, Jaroslav Kysela <perex@perex.cz>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Quoting Heiko St=C3=BCbner (2015-10-11 03:43:27)
> Hi Sjoerd,
>=20
> Am Freitag, 9. Oktober 2015, 13:35:55 schrieb Sjoerd Simons:
> > On Thu, 2015-10-08 at 17:10 +0200, Heiko Stuebner wrote:
> > > Am Donnerstag, 8. Oktober 2015, 15:31:16 schrieb Sjoerd Simons:
> > > > The clock branches leading to sclk_spdif and sclk_spdif_8ch on
> > > > RK3288
> > > > SoCs only feed those clocks, allow those clocks to change their
> > > > parents
> > > > all the way up the hierarchy.
> > > >=20
> > > > Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> > >=20
> > > Just as comment, if I'm seeing that right, this patch needs "clk:
> > > rockchip:
> > > handle mux dependency of fractional dividers" and friends [0] to
> > > apply and
> > > also actually handle the fractional dividers correctly.
> > >=20
> > > For the clock change itself:
> > > Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> >=20
> > Oh sorry yes, i completely forgot to at that as note on this patch
> > (series). These are on top of your series as those are required to =
make
> > things actually work as expected.
> >=20
> > Which reminds me, i was wondering how to best move that forward. Co=
uld
> > you pick this one up to include it in the next round of your series=
?
> > (Otherwise i'm happy to rebase it once you do a v2)
>=20
> I guess that will depend on how the core series gets handled. Aka if =
there=20
> needs to be a v2 (depending on the clock maintainers) I can pick that=
 up as=20
> part of it. Otherwise we'll just need to ping the clock-maintainers s=
eparately=20
> on this patch if necessary.

I've spoken with Heiko on irc about v2 about using the coordinated cloc=
k
rates patches for handling the mux/fractional dividers thing. I'd prefe=
r
to use the ccr approach, which puts a delay on that series.

Is there anything wrong with merging this patch #5/8 as-is? Will the
struct clk_core.rate accounting not match the hardware if we set
CLK_SET_PARENT_RATE on these clocks?

Regards,
Mike

>=20
>=20
> Heiko
>=20
