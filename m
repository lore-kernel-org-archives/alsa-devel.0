From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ASoC: codec: wm9860: avoid
	maybe-uninitialized warning
Date: Thu, 20 Apr 2017 09:44:28 +0200
Message-ID: <CAK8P3a1_8GmVXu_gQ-dm_5SrA2bn8M7Vdb+kFC-hugkHCnYOww@mail.gmail.com>
References: <20170419170449.2965453-1-arnd@arndb.de>
 <CAEnQRZCDi1_dsBjo_10h2ntOH57mCXMS=GeqLUgahnoVu8pBDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f53.google.com (mail-oi0-f53.google.com
 [209.85.218.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 16129266FBF
 for <alsa-devel@alsa-project.org>; Thu, 20 Apr 2017 09:44:30 +0200 (CEST)
Received: by mail-oi0-f53.google.com with SMTP id j201so38843183oih.2
 for <alsa-devel@alsa-project.org>; Thu, 20 Apr 2017 00:44:30 -0700 (PDT)
In-Reply-To: <CAEnQRZCDi1_dsBjo_10h2ntOH57mCXMS=GeqLUgahnoVu8pBDw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Daniel Baluta <daniel.baluta@nxp.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 20, 2017 at 8:48 AM, Daniel Baluta <daniel.baluta@gmail.com> wrote:
> Hi Arnd,
>
> On Wed, Apr 19, 2017 at 8:04 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> The new PLL configuration code triggers a harmless warning:
>>
>> sound/soc/codecs/wm8960.c: In function 'wm8960_configure_clocking':
>> sound/soc/codecs/wm8960.c:735:3: error: 'best_freq_out' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>>    wm8960_set_pll(codec, freq_in, best_freq_out);
>>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> sound/soc/codecs/wm8960.c:699:12: note: 'best_freq_out' was declared here
>>
>> I think the warning was introduced by Daniel's bugfix. I've come up
>> with a way to simplify the code in a way that is more readable to
>> both humans and to gcc, which gets us rid of the warning.
>
> I've struggled with this kind of warning when reworking wm8960
> bitclock computation.
>
> Anyhow, for this exact patch the warning didn't showed up.
>
> I used:
>
> gcc version 6.2.1 20161016 (Linaro GCC 6.2-2016.11)

I'm using gcc-7.0.1 here, which overall has better warnings for
-Wmaybe-uninitialized
than older versions, but sometimes also finds new false positives.

> My next patch:
>
> https://patchwork.kernel.org/patch/9666921/ [1]
>
> which is under review, had the issue you mention (in v1)
>
> https://lkml.org/lkml/2017/4/5/246
>
> but I initialized best_freq_out with 0 to get rid of the problem.

I try hard not to do that, because it can hide real problems in case the
code gets modified further to actually have an uninitialized use that we
would otherwise get a warning for.

>> @@ -720,22 +718,14 @@ int wm8960_configure_pll(struct snd_soc_codec *codec, int freq_in,
>>                                         *sysclk_idx = i;
>>                                         *dac_idx = j;
>>                                         *bclk_idx = k;
>> -                                       best_freq_out = freq_out;
>> -                                       break;
>> +                                       return freq_out;
>>                                 }
>>                         }
>> -                       if (k != ARRAY_SIZE(bclk_divs))
>> -                               break;
>>                 }
>> -               if (j != ARRAY_SIZE(dac_divs))
>> -                       break;
>>         }
>> -
>> -       if (*bclk_idx != -1)
>> -               wm8960_set_pll(codec, freq_in, best_freq_out);
>
> I think the compiler is tricked into thinking that best_freq_out might
> be uninitialized. Notice
> that each time *bclk_idx is assigned a value (which is always >=0) we
> also initialize best_freq_out.

Right. This is probably the result of one of two things that
prevent the compiler from figuring it out:

a) bclk_idx being an indirect pointer might cause the compiler to
    decide that another operation might overwrite it, e.g. if it points
    to the same location as one of the other pointers.

b) The flow analysis might just get too tricky, so when gcc gives
    up trying to work out whether the assignment has happened
    at least once for the two variables, it concludes that it doesn't
    know, without seeing that the answer is always the same for
    both of them.

>> @@ -783,11 +773,12 @@ static int wm8960_configure_clocking(struct snd_soc_codec *codec)
>>                 }
>>         }
>>
>> -       ret = wm8960_configure_pll(codec, freq_in, &i, &j, &k);
>> -       if (ret < 0) {
>> +       freq_out = wm8960_configure_pll(codec, freq_in, &i, &j, &k);
>> +       if (freq_out < 0) {
>>                 dev_err(codec->dev, "failed to configure clock via PLL\n");
>> -               return -EINVAL;
>> +               return freq_out;
>>         }
>> +       wm8960_set_pll(codec, freq_in, freq_out);
>>
>>  configure_clock:
>>         /* configure sysclk clock */
>
> Your idea looks good, will need to rework my follow up patch on it:
>
> https://patchwork.kernel.org/patch/9666921/

Ok. Or feel free to fold my patch into yours if that makes it easier for you.

     Arnd
