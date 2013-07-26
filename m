From: Felipe Tonello <eu@felipetonello.com>
Subject: Re: [PATCH 4/4] ALSA: oxygen: Updating jack
 implementation according new ALSA Jacks
Date: Fri, 26 Jul 2013 12:02:51 -0700
Message-ID: <CAGrhNMzaBcUb4GHLXr5uR2g4YNSD60vcDpDKQO=S9H2jAx6pgA@mail.gmail.com>
References: <1374863133-6745-1-git-send-email-eu@felipetonello.com>
 <1374863133-6745-5-git-send-email-eu@felipetonello.com>
 <20130726185609.GY9858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f178.google.com (mail-we0-f178.google.com
 [74.125.82.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F947265840
 for <alsa-devel@alsa-project.org>; Fri, 26 Jul 2013 21:02:52 +0200 (CEST)
Received: by mail-we0-f178.google.com with SMTP id u57so2209228wes.37
 for <alsa-devel@alsa-project.org>; Fri, 26 Jul 2013 12:02:52 -0700 (PDT)
In-Reply-To: <20130726185609.GY9858@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Wang Xingchao <xingchao.wang@linux.intel.com>, linux-kernel@vger.kernel.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Fri, Jul 26, 2013 at 11:56 AM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Jul 26, 2013 at 11:25:33AM -0700, Felipe F. Tonello wrote:
>> From: "Felipe F. Tonello" <eu@felipetonello.com>
>>
>> ALSA standard jacks already are implemented using ALSA KControl.
>> So there is no need implement that itself or to use snd_jack
>> for input events only.
>
> Similar changlog comment as on the ASoC patch and...

Ok.

>
>>       snd_jack_new(chip->card, "Headphone",
>> -                  SND_JACK_HEADPHONE, &data->hp_jack);
>> +                  SND_JACK_HEADPHONE, 0, &data->hp_jack);
>>       xonar_ds_handle_hp_jack(chip);
>
> ...this really ought to be done as part of the commit that adds the
> parameter since it breaks the build until this patch is applied.

But that's why is a patch series. But as you say, are you suggesting
me to propose this changes in one patch only?

Felipe Tonello
