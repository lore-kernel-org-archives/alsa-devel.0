From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [alsa-devel] [PATCH] ASoC: skl: always select SND_SOC_HDAC_HDA
Date: Mon, 5 Nov 2018 22:19:02 +0100
Message-ID: <CAK8P3a3yWJJMqV8mRB9bS0K=+s-nvygCEk+zdSQBU8YjGwx2iQ@mail.gmail.com>
References: <20181102112456.780127-1-arnd@arndb.de> <943d10e2-299c-4393-f2f5-4ac8bbe400c3@linux.intel.com>
 <CAK8P3a1FCVTuB+ydE6syMHYPWnUW0WTCFDuyMmm35VNnpTTGBw@mail.gmail.com>
 <adc83eaa-b7c0-2c76-a434-f1d5872337f6@linux.intel.com> <20181105133545.GF10650@smile.fi.intel.com>
 <CAK8P3a0kdUtK_UuSJEPiWPxhdDULmW6RYEzu-Ug7f8VBoeWVog@mail.gmail.com>
 <s5h1s7z35t8.wl-tiwai@suse.de> <5c21e5d9-6a14-ff4f-04f2-9dbfc8665250@linux.intel.com>
 <CAHp75Vc8W6sOOOF4WUaoVD2rGijwG_5J083UG1YFgptTkuzk=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vc8W6sOOOF4WUaoVD2rGijwG_5J083UG1YFgptTkuzk=w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, guneshwor.o.singh@intel.com, naveen.m@intel.com, pankaj.laxminarayan.bharadiya@intel.com, rakesh.a.ughreja@intel.com, sanyog.r.kale@intel.com, sriramx.periyasamy@intel.com, Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>, liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 11/5/18, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> On Mon, Nov 5, 2018 at 7:19 PM Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com> wrote:
>>
>>
>> >>> We have this ("strange") lines over the drivers:
>> >>>
>> >>> config BAR
>> >>> depends on FOO || FOO=n
>> >>>
>> >>> which guarantees that FOO will be not module when BAR is built-in.
>> >> That's what I normally use, but I could not figure this one out.
>> >> One problem is that SND_SOC_ALL_CODECS selects
>> >> SND_SOC_HDAC_HDA, and SND_SOC_ALL_CODECS itself
>> >> may be =m, causing the failure for
>> >> SND_SOC_INTEL_SKL_HDA_DSP_GENERIC_MACH=y.
>> >>
>> >> It might work with a separate dummy symbol:
>> >>
>> >> config SND_SOC_HDAC_HDA_FORCE
>> >>           tristate
>
>> >>           depends on SND_SOC_ALL_CODECS != n
>
> Forgot to mention that AFAIU above line is no-op in symbols which are
> hidden.
>

It's not. In this case, it will prevent SND_SOC_HDAC_HDA_FORCE
from being turned on by the 'default ...' line. In other cases, it can
generate a warning if you have a hidden symbol that is selected
by some other symbol while the dependency is missing.

      Arnd
