From: Daniel Drake <drake@endlessm.com>
Subject: Re: [PATCH 2/2] ASoC: Intel: add machine driver for
	BYT/CHT + ES8316
Date: Mon, 15 May 2017 12:07:54 -0600
Message-ID: <CAD8Lp45R42GjBDu5bVAYU4Q=KjNFrsQ4+Gcv3Wi4mycesp2a2w@mail.gmail.com>
References: <20170510181649.14580-1-drake@endlessm.com>
 <20170510181649.14580-2-drake@endlessm.com>
 <c34ff89d-3b64-cbf3-db99-97d7f3e38d57@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f42.google.com (mail-oi0-f42.google.com
 [209.85.218.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 70FEC26745F
 for <alsa-devel@alsa-project.org>; Mon, 15 May 2017 20:07:57 +0200 (CEST)
Received: by mail-oi0-f42.google.com with SMTP id l18so140603130oig.2
 for <alsa-devel@alsa-project.org>; Mon, 15 May 2017 11:07:56 -0700 (PDT)
In-Reply-To: <c34ff89d-3b64-cbf3-db99-97d7f3e38d57@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Linux Upstreaming Team <linux@endlessm.com>, Liam Girdwood <lgirdwood@gmail.com>, yangxiaohua <yangxiaohua@everest-semi.com>
List-Id: alsa-devel@alsa-project.org

On Wed, May 10, 2017 at 12:49 PM, Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
> You may want to add a comment that this patch is based on the use of SSP2
> and hence cannot work on BYT-CR devices.

I'm not quite clear on the terminology here. What does BYT-CR mean exactly?

I named the driver with "byt" in addition to "cht" as I was hoping it
can support the baytrail devices mentioned here:
https://bugzilla.kernel.org/show_bug.cgi?id=189261#c71

I also see that bytcht_da7213 is documented as supporting Baytrail
devices and only uses SSP2. But bytcr_rt5640 does switch to SSP0 on
valleyview, and I could do the same.

Not sure which way I should go here at least without more info from
the reporter, let me know if you have any suggestions.

>> +static const struct snd_kcontrol_new byt_cht_es8316_controls[] = {
>> +       SOC_DAPM_PIN_SWITCH("Headphone"),
>> +       SOC_DAPM_PIN_SWITCH("Microphone 1"),
>> +       SOC_DAPM_PIN_SWITCH("Microphone 2"),
>
>
> do you really need to control the two analog mics independently? And along
> the same lines, should there be a path for DMICS?

The ES8316 datasheet is clear that it supports 2 independent analog
stereo mics, and the codec driver exposes the relevant controls for
that, so I added two here. There is a mux so you have to choose which
one you feed into the ADC, but (if you wanted to) you could e.g. feed
the other into the HP output mixer, and use both simultaneously.

The product I'm working with only uses one of them though, so I could
delete the other one if you think that makes sense?

The datasheet does say "Support digital mic" but it makes almost no
other mention of DMIC support, not even which of the 4 mic input pins
you would use for that. The codec driver does expose a single
SND_SOC_DAPM_INPUT("DMIC") though so I could very easily add a route
here, although I would have no way of testing it.

Thanks for your help

Daniel
