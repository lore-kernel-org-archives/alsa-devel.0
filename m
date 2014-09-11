From: Xavier Hsu <xavier.hsu@linaro.org>
Subject: Re: [PATCHv3 8/9] WM8971 adds kcontrol functions
Date: Thu, 11 Sep 2014 11:35:35 +0800
Message-ID: <CAHa2TOZXEZDDaGjYaStbOZ1y8Q=di3WhF2R6shq00D2RjzHqTw@mail.gmail.com>
References: <1409628470-13059-1-git-send-email-xavier.hsu@linaro.org>
 <1409628470-13059-8-git-send-email-xavier.hsu@linaro.org>
 <20140902124155.GJ12043@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f180.google.com (mail-we0-f180.google.com
 [74.125.82.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 9869B265613
 for <alsa-devel@alsa-project.org>; Thu, 11 Sep 2014 05:35:36 +0200 (CEST)
Received: by mail-we0-f180.google.com with SMTP id t60so5030601wes.11
 for <alsa-devel@alsa-project.org>; Wed, 10 Sep 2014 20:35:36 -0700 (PDT)
In-Reply-To: <20140902124155.GJ12043@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: Andy Green <andy.green@linaro.org>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Patch Tracking <patches@linaro.org>
List-Id: alsa-devel@alsa-project.org

Hi Charles :
Thanks for your feedback.
I will set these registers through DT.

BR,
Xavier

2014-09-02 20:41 GMT+08:00 Charles Keepax <
ckeepax@opensource.wolfsonmicro.com>:

> On Tue, Sep 02, 2014 at 11:27:49AM +0800, Xavier Hsu wrote:
> > This patch improves WM8971.
> > We add kcontrol functions on WM8971.
> >
> > Any comments about improving the patch are welcome.
> > Thanks.
> >
> > Signed-off-by: Xavier Hsu <xavier.hsu@linaro.org>
> > Signed-off-by: Andy Green <andy.green@linaro.org>
> > ---
> >  sound/soc/codecs/wm8971.c |    6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/sound/soc/codecs/wm8971.c b/sound/soc/codecs/wm8971.c
> > index 95e7c39..6d34565 100755
> > --- a/sound/soc/codecs/wm8971.c
> > +++ b/sound/soc/codecs/wm8971.c
> > @@ -284,6 +284,12 @@ static const struct snd_kcontrol_new
> wm8971_snd_controls[] = {
> >
> >       SOC_DOUBLE_R_TLV("ADC Volume", WM8971_LADC, WM8971_RADC,
> >                        0, 255, 0, adc_vol),
> > +
> > +     SOC_SINGLE("Analogue Bias", WM8971_ADCTL1, 6, 3, 0),
>
> Given this relates to the AVDD voltage feels it is very unlikely
> to change at runtime. Do we expect it to? Otherwise it might be
> better added as a DT entry.
>
> > +     SOC_SINGLE("Right Speaker Playback Invert Switch", WM8971_ADCTL2,
> > +                4, 1, 0),
> > +     SOC_SINGLE("Headphone Switch POL", WM8971_ADCTL2, 5, 1, 0),
>
> Again the polarity of the headphone detect is not going to change
> at runtime so this should probably be a DT entry.
>
> > +     SOC_SINGLE("Headphone Switch EN", WM8971_ADCTL2, 6, 1, 0),
>
> I am less clear on whether or not this should be a control or a
> DT entry, so as long as you are happy this is consistent with the
> usage.
>
> >  };
> >
> >  /*
> > --
>
> Thanks,
> Charles
>
