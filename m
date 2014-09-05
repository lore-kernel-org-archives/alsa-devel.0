From: Xavier Hsu <xavier.hsu@linaro.org>
Subject: Re: [PATCHv3 6/9] WM8971 uses msleep to replace work
	queue
Date: Fri, 5 Sep 2014 11:09:42 +0800
Message-ID: <CAHa2TOba05tN7P-876hNrxB43Cv36wS379As8rGOQJ58Kues+Q@mail.gmail.com>
References: <1409628470-13059-1-git-send-email-xavier.hsu@linaro.org>
 <1409628470-13059-6-git-send-email-xavier.hsu@linaro.org>
 <20140902100050.GG12043@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f173.google.com (mail-we0-f173.google.com
 [74.125.82.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D4E52656AD
 for <alsa-devel@alsa-project.org>; Fri,  5 Sep 2014 05:09:42 +0200 (CEST)
Received: by mail-we0-f173.google.com with SMTP id t60so11092954wes.4
 for <alsa-devel@alsa-project.org>; Thu, 04 Sep 2014 20:09:42 -0700 (PDT)
In-Reply-To: <20140902100050.GG12043@opensource.wolfsonmicro.com>
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
This device driver (we use wm8973) can normally run on our platform.
Anyway, I modify some part of our device driver.
 (msleep(100) => msleep(1000))
 (Before msleep, it will call wm8971_set_bias_level(codec,
codec->dapm.bias_level) first)

BR,
Xavier


2014-09-02 18:00 GMT+08:00 Charles Keepax <
ckeepax@opensource.wolfsonmicro.com>:

> On Tue, Sep 02, 2014 at 11:27:47AM +0800, Xavier Hsu wrote:
> > This patch improves WM8971.
> > We use msleep to replace work queue.
> > "As suggested by Mark Brown"
> >
> > Any comments about improving the patch are welcome.
> > Thanks.
> >
> > Signed-off-by: Xavier Hsu <xavier.hsu@linaro.org>
> > Signed-off-by: Andy Green <andy.green@linaro.org>
> > ---
> >  sound/soc/codecs/wm8971.c |   25 ++-----------------------
> >  1 file changed, 2 insertions(+), 23 deletions(-)
> >
> > diff --git a/sound/soc/codecs/wm8971.c b/sound/soc/codecs/wm8971.c
> > index 20cfdd3..68b4f52 100755
> > --- a/sound/soc/codecs/wm8971.c
> > +++ b/sound/soc/codecs/wm8971.c
> > @@ -36,8 +36,6 @@
> >
> >  #define      WM8971_REG_COUNT        43
> >
> > -static struct workqueue_struct *wm8971_workq;
> > -
> >  /* codec private data */
> >  struct wm8971_priv {
> >       unsigned int sysclk;
> > @@ -774,16 +772,6 @@ static struct snd_soc_dai_driver wm8971_dai = {
> >       .ops = &wm8971_dai_ops,
> >  };
> >
> > -static void wm8971_work(struct work_struct *work)
> > -{
> > -     struct snd_soc_dapm_context *dapm =
> > -             container_of(work, struct snd_soc_dapm_context,
> > -                          delayed_work.work);
> > -     struct snd_soc_codec *codec = dapm->codec;
> > -
> > -     wm8971_set_bias_level(codec, codec->dapm.bias_level);
> > -}
> > -
> >  static int wm8971_suspend(struct snd_soc_codec *codec)
> >  {
> >       wm8971_set_bias_level(codec, SND_SOC_BIAS_OFF);
> > @@ -801,8 +789,7 @@ static int wm8971_resume(struct snd_soc_codec *codec)
> >               reg = snd_soc_read(codec, WM8971_PWR1) & 0xfe3e;
> >               snd_soc_write(codec, WM8971_PWR1, reg | 0x01c0);
> >               codec->dapm.bias_level = SND_SOC_BIAS_ON;
> > -             queue_delayed_work(wm8971_workq, &codec->dapm.delayed_work,
> > -                                msecs_to_jiffies(1000));
> > +             msleep(100);
> >       }
> >
> >       return 0;
> > @@ -813,19 +800,13 @@ static int wm8971_probe(struct snd_soc_codec
> *codec)
> >       int ret = 0;
> >       u16 reg;
> >
> > -     INIT_DELAYED_WORK(&codec->dapm.delayed_work, wm8971_work);
> > -     wm8971_workq = create_workqueue("wm8971");
> > -     if (wm8971_workq == NULL)
> > -             return -ENOMEM;
> > -
> >       wm8971_reset(codec);
> >
> >       /* charge output caps - set vmid to 5k for quick power up */
> >       reg = snd_soc_read(codec, WM8971_PWR1) & 0xfe3e;
> >       snd_soc_write(codec, WM8971_PWR1, reg | 0x01c0);
> >       codec->dapm.bias_level = SND_SOC_BIAS_STANDBY;
> > -     queue_delayed_work(wm8971_workq, &codec->dapm.delayed_work,
> > -                        msecs_to_jiffies(1000));
> > +     msleep(100);
>
> Does this patch actually work? You have taken out the
> queue_delayed_work and replaced it with a delay (which is 10x
> shorter than the delayed work version), but you  haven't replaced
> the call to wm8971_set_bias_level that used to be in the delayed
> work?
>
> >
> >       /* set the update bits */
> >       snd_soc_update_bits(codec, WM8971_LDAC, 0x0100, 0x0100);
> > @@ -846,8 +827,6 @@ static int wm8971_remove(struct snd_soc_codec *codec)
> >  {
> >       wm8971_set_bias_level(codec, SND_SOC_BIAS_OFF);
> >
> > -     if (wm8971_workq)
> > -             destroy_workqueue(wm8971_workq);
> >       return 0;
> >  }
> >
> > --
>
> Thanks,
> Charles
>
