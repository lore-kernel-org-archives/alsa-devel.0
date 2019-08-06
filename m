From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [linux-sunxi] Re: [PATCH v4 6/9] ASoC: sun4i-i2s: Add multi-lane functionality
Date: Tue, 6 Aug 2019 14:22:13 +0800
Message-ID: <CAGb2v66D4-QvWYPXE=rf6Zv93X1LjnxUgpk+5wdAL_b7MM3vaA@mail.gmail.com>
References: <20190603174735.21002-1-codekipper@gmail.com> <2092329.vleAuWJ0xl@jernej-laptop>
 <20190731122953.2u3iabd6gkn7jv7k@flea> <1589203.0AjJVEASy3@jernej-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1589203.0AjJVEASy3@jernej-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc: linux-sunxi <linux-sunxi@googlegroups.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Code Kipper <codekipper@gmail.com>, Christopher Obbard <chris@64studio.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, "Andrea Venturi (pers)" <be17068@iperbole.bo.it>
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 1, 2019 at 1:32 PM Jernej Škrabec <jernej.skrabec@gmail.com> wrote:
>
> Dne sreda, 31. julij 2019 ob 14:29:53 CEST je Maxime Ripard napisal(a):
> > On Tue, Jul 30, 2019 at 07:57:10PM +0200, Jernej Škrabec wrote:
> > > Dne torek, 04. junij 2019 ob 11:38:44 CEST je Code Kipper napisal(a):
> > > > On Tue, 4 Jun 2019 at 11:02, Christopher Obbard <chris@64studio.com>
> wrote:
> > > > > On Tue, 4 Jun 2019 at 09:43, Code Kipper <codekipper@gmail.com> wrote:
> > > > > > On Tue, 4 Jun 2019 at 09:58, Maxime Ripard
> > > > > > <maxime.ripard@bootlin.com>
> > >
> > > wrote:
> > > > > > > On Mon, Jun 03, 2019 at 07:47:32PM +0200, codekipper@gmail.com
> wrote:
> > > > > > > > From: Marcus Cooper <codekipper@gmail.com>
> > > > > > > >
> > > > > > > > The i2s block supports multi-lane i2s output however this
> > > > > > > > functionality
> > > > > > > > is only possible in earlier SoCs where the pins are exposed and
> > > > > > > > for
> > > > > > > > the i2s block used for HDMI audio on the later SoCs.
> > > > > > > >
> > > > > > > > To enable this functionality, an optional property has been
> > > > > > > > added to
> > > > > > > > the bindings.
> > > > > > > >
> > > > > > > > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> > > > > > >
> > > > > > > I'd like to have Mark's input on this, but I'm really worried
> > > > > > > about
> > > > > > > the interaction with the proper TDM support.
> > > > > > >
> > > > > > > Our fundamental issue is that the controller can have up to 8
> > > > > > > channels, but either on 4 lines (instead of 1), or 8 channels on 1
> > > > > > > (like proper TDM) (or any combination between the two, but that
> > > > > > > should
> > > > > > > be pretty rare).
> > > > > >
> > > > > > I understand...maybe the TDM needs to be extended to support this to
> > > > > > consider channel mapping and multiple transfer lines. I was thinking
> > > > > > about the later when someone was requesting support on IIRC a while
> > > > > > ago, I thought masking might of been a solution. These can wait as
> > > > > > the
> > > > > > only consumer at the moment is LibreELEC and we can patch it there.
> > > > >
> > > > > Hi Marcus,
> > > > >
> > > > > FWIW, the TI McASP driver has support for TDM & (i think?) multiple
> > > > > transfer lines which are called serializers.
> > > > > Maybe this can help with inspiration?
> > > > > see
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre
> > > > > e/s
> > > > > ound/soc/ti/davinci-mcasp.c sample DTS:
> > > > >
> > > > > &mcasp0 {
> > > > >
> > > > >     #sound-dai-cells = <0>;
> > > > >     status = "okay";
> > > > >     pinctrl-names = "default";
> > > > >     pinctrl-0 = <&mcasp0_pins>;
> > > > >
> > > > >     op-mode = <0>;
> > > > >     tdm-slots = <8>;
> > > > >     serial-dir = <
> > > > >
> > > > >         2 0 1 0
> > > > >         0 0 0 0
> > > > >         0 0 0 0
> > > > >         0 0 0 0
> > > > >     >
> > > > >     >;
> > > > >
> > > > >     tx-num-evt = <1>;
> > > > >     rx-num-evt = <1>;
> > > > >
> > > > > };
> > > > >
> > > > > Cheers!
> > > >
> > > > Thanks, this looks good.
> > >
> > > I would really like to see this issue resolved, because HDMI audio support
> > > in mainline Linux for those SoCs is long overdue.
> > >
> > > However, there is a possibility to still add HDMI audio suport (stereo
> > > only) even if this issue is not completely solved. If we agree that
> > > configuration of channels would be solved with additional property as
> > > Christopher suggested, support for >2 channels can be left for a later
> > > time when support for that property would be implemented. Currently,
> > > stereo HDMI audio support can be added with a few patches.
> > >
> > > I think all I2S cores are really the same, no matter if internally
> > > connected to HDMI controller or routed to pins, so it would make sense to
> > > use same compatible for all of them. It's just that those I2S cores which
> > > are routed to pins can use only one lane and >2 channels can be used only
> > > in TDM mode of operation, if I understand this correctly.
> > >
> > > New property would have to be optional, so it's omission would result in
> > > same channel configuration as it is already present, to preserve
> > > compatibility with old device trees. And this mode is already sufficient
> > > for stereo HDMI audio support.
> >
> > Yeah, it looks like a good plan.
> >
> > > Side note: HDMI audio with current sun4i-i2s driver has a delay (about a
> > > second), supposedly because DW HDMI controller automatically generates CTS
> > > value based on I2S clock (auto CTS value generation is enabled per
> > > DesignWare recomendation for DW HDMI I2S interface).
> >
> > Is that a constant delay during the audio playback, or only at startup?
>
> I think it's just at startup, e.g. if you're watching movie, audio is in sync,
> it's just that first second or so is silent.
>
> >
> > > I2S driver from BSP Linux solves that by having I2S clock output
> > > enabled all the time. Should this be flagged with some additional
> > > property in DT?
> >
> > I'd say that if the codec has that requirement, then it should be
> > between the codec and the DAI, the DT doesn't really have anything to
> > do with this.
>
> Ok, but how to communicate that fact to I2S driver then? BSP driver solves
> that by using different compatible, but as I said before, I2S cores are not
> really different, so this seems wrong.

Maybe we could make the DW-HDMI I2S driver require the I2S clock be on all
the time? You wouldn't need any changes to the DT.

ChenYu
