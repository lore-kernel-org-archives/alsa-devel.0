From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH] ASoC: sun4i-codec: fix first delay on Speaker
Date: Fri, 17 May 2019 10:29:41 +0800
Message-ID: <CAGb2v65D23-sXmZPT2t2d0XrZnO2yfUKwgc7z=1VEfVkK+855A@mail.gmail.com>
References: <1557925120-31498-1-git-send-email-georgii.staroselskii@emlid.com>
 <20190515135813.5y72f2h526yjkncy@flea> <20190515152749.GA2241@softcrasher>
 <20190516201256.te7ya3n7ugbfmzrw@flea>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190516201256.te7ya3n7ugbfmzrw@flea>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Maxime Ripard <maxime.ripard@bootlin.com>, Georgii Staroselskii <georgii.staroselskii@emlid.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Danny Milosavljevic <dannym@scratchpost.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Fri, May 17, 2019 at 4:13 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Wed, May 15, 2019 at 06:27:49PM +0300, Georgii Staroselskii wrote:
> > On Wed, May 15, 2019 at 03:58:13PM +0200, Maxime Ripard wrote:
> > > > diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
> > > > index 15d08e3..e0099519 100644
> > > > --- a/sound/soc/sunxi/sun4i-codec.c
> > > > +++ b/sound/soc/sunxi/sun4i-codec.c
> > > > @@ -1329,6 +1329,15 @@ static int sun4i_codec_spk_event(struct snd_soc_dapm_widget *w,
> > > >   gpiod_set_value_cansleep(scodec->gpio_pa,
> > > >                            !!SND_SOC_DAPM_EVENT_ON(event));
> > > >
> > > > + if (SND_SOC_DAPM_EVENT_ON(event)) {
> > > > +         /*
> > > > +          * Need a delay to have the amplifier up. 700ms seems the best
> > > > +          * compromise between the time to let the amplifier up and the
> > > > +          * time not to feel this delay while playing a sound.
> > > > +          */
> > > > +         msleep(700);
> > > > + }
> > > > +
> > >
> > > Since this is an external amplifier, I guess they would have different
> > > warm-up time depending on the exact part being used?
> >
> > I guess I might've used Speaker wrong and bumped into an existing
> > issue.  The issue first arose when I needed to connect a speaker and
> > use a mute GPIO pin to toggle it. I bumped into the lag similar to
> > the one that has been fixed in bf14da7. The word "amplifier" here in
> > my comments might be wrong and misleding. Sorry for that. I just
> > measured the latency on the speaker I'm using and it is well under
> > 1ms so this is the Allwinner DAC that is pushing the data with a
> > lag. Or some other thing, I'm not sure.
> >
> > I want to stress again that I might've experienced the issue because
> > I was abusing "Speaker" routing. I basically just needed the analog
> > audio stream and mute GPIO handling done automatically.
>
> Ok. I guess the comment should just be reflecting that then.

Sounds like the board has an external buffer / amplifier for the speaker.
Does it have a headphone jack that bypasses it? Then you could check for
the actual latency.

Also, I think it might be better if we could move to actual audio routing
and have a simple-amplifier instead.

ChenYu
