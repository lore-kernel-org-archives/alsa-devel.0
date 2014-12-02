From: Xavier Hsu <xavier.hsu@linaro.org>
Subject: Re: [PATCHv6 3/9] ASOC: wm8971: modify the control of
	deemphasis
Date: Tue, 2 Dec 2014 15:54:32 +0800
Message-ID: <CAHa2TOb+utb-+Nn5wj+MzWPeoMH=YCAw=L8dGBZb2oygqaePxQ@mail.gmail.com>
References: <1417416721-17271-1-git-send-email-xavier.hsu@linaro.org>
 <1417416721-17271-3-git-send-email-xavier.hsu@linaro.org>
 <20141201100459.GA18129@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f50.google.com (mail-wg0-f50.google.com [74.125.82.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F5BB260439
 for <alsa-devel@alsa-project.org>; Tue,  2 Dec 2014 08:54:33 +0100 (CET)
Received: by mail-wg0-f50.google.com with SMTP id k14so16110611wgh.23
 for <alsa-devel@alsa-project.org>; Mon, 01 Dec 2014 23:54:32 -0800 (PST)
In-Reply-To: <20141201100459.GA18129@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Andy Green <andy.green@linaro.org>, Patch Tracking <patches@linaro.org>, patches@opensource.wolfsonmicro.com, Lars-Peter Clausen <lars@metafoo.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hi Richard and Charles :
Thanks for your feedback.
Sorry for waste your time to help us for checking our patches because I
make a mistake.
We have a platform that contain wm8973 audio codec.
I need to apply all patches and then I can test our patches.
After testing our patches, I go back to PATCHv6 3/9 and modify our program.
But I forgot to modify some code......
(static const char const *wm8971_deemp[] = {"None", "32kHz", "44.1kHz",
"48kHz"};
=> static const int wm8971_deemp[] = {0, 32000, 44100, 48000};)

I am very sorry....
Please forgive my carelessness...

We will check all our patches and then release them.
If you have any other suggestions, please let me know, thanks.
Sorry again.

BR,
Xavier

2014-12-01 18:04 GMT+08:00 Richard Fitzgerald <
rf@opensource.wolfsonmicro.com>:

> On Mon, Dec 01, 2014 at 02:51:55PM +0800, Xavier Hsu wrote:
> > We add a switch for automatic updating
> > the frequency of wm8971.
> >
> > Signed-off-by: Xavier Hsu <xavier.hsu@linaro.org>
> > Signed-off-by: Andy Green <andy.green@linaro.org>
> > ---
> >  sound/soc/codecs/wm8971.c |   75
> +++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 72 insertions(+), 3 deletions(-)
> >  mode change 100644 => 100755 sound/soc/codecs/wm8971.c
> >
> > diff --git a/sound/soc/codecs/wm8971.c b/sound/soc/codecs/wm8971.c
> > old mode 100644
> > new mode 100755
> > index 60c90c6..b5cb636
> > --- a/sound/soc/codecs/wm8971.c
> > +++ b/sound/soc/codecs/wm8971.c
> > @@ -40,6 +40,11 @@ static struct workqueue_struct *wm8971_workq;
> >  /* codec private data */
> >  struct wm8971_priv {
> >       unsigned int sysclk;
> > +
> > +     /* De-emphasis */
> > +     struct mutex deemph_mutex;
> > +     int playback_fs;
> > +     bool deemph;
> >  };
> >
> >  /*
> > @@ -104,7 +109,6 @@ static const char const *wm8971_alc_func[] = {"Off",
> "Right",
> >                                             "Left", "Stereo"};
> >  static const char const *wm8971_ng_type[] = {"Constant PGA Gain",
> >                                            "Mute ADC Output"};
> > -static const char const *wm8971_deemp[] = {"None", "32kHz", "44.1kHz",
> "48kHz"};
> >  static const char const *wm8971_mono_mux[] = {"Stereo", "Mono (Left)",
> >                                             "Mono (Right)", "Digital
> Mono"};
> >  static const char const *wm8971_dac_phase[] = {"Non Inverted",
> "Inverted"};
> > @@ -118,6 +122,66 @@ static const char const *wm8971_rpga_sel[] =
> {"Line", "Mic", "NC",
> >                                             "Differential"};
> >  static const char const *wm8971_adcpol[] = {"Normal", "L Invert",
> >                                           "R Invert", "L + R Invert"};
> > +static const char const *wm8971_deemp[] = {"None", "32kHz",
> > +                                        "44.1kHz", "48kHz"};
>
> This is the same as the original version of the array that you've deleted.
> I'm guess from the code below that you intended to change this to an
> array of integers, messed up, and didn't bother to test that your patch
> compiled before posting it up here.
>
> > +
> > +static int wm8971_set_deemph(struct snd_soc_codec *codec)
> > +{
> > +     struct wm8971_priv *wm8971 = snd_soc_codec_get_drvdata(codec);
> > +     int val = 0, i, best = 0;
> > +
> > +     /* If we're using deemphasis select the nearest available sample
> > +      * rate.
> > +     */
> > +     if (wm8971->deemph) {
> > +             best = 1;
> > +             for (i = 2; i < ARRAY_SIZE(wm8971_deemp); i++) {
> > +                     if (abs(wm8971_deemp[i] - wm8971->playback_fs) <
> > +                         abs(wm8971_deemp[best] - wm8971->playback_fs))
>
> wm8971_deemp[i] is a string and then you try to subtract a value from it.
> I wouldn't expect that to even compile (at least not without warnings), and
> if it does compile I can't imagine what the result would be and I doubt it
> is what you wanted.
> I'm not even sure what you were trying to do here.
>
> > +                             best = i;
> > +             }
> > +             val = best << 1;
> > +     }
> > +
> > +     dev_dbg(codec->dev, "Set deemphasis %d (%dHz)\n",
> > +             best, wm8971_deemp[best]);
> > +
>
> wm_8971_deemp[best] is a string
>
>
>
