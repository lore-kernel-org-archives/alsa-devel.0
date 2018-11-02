From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ASoC: skl: always select SND_SOC_HDAC_HDA
Date: Fri, 2 Nov 2018 23:03:23 +0100
Message-ID: <CAK8P3a1FCVTuB+ydE6syMHYPWnUW0WTCFDuyMmm35VNnpTTGBw@mail.gmail.com>
References: <20181102112456.780127-1-arnd@arndb.de>
 <943d10e2-299c-4393-f2f5-4ac8bbe400c3@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com
 [209.85.222.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 892C7267692
 for <alsa-devel@alsa-project.org>; Fri,  2 Nov 2018 23:03:25 +0100 (CET)
Received: by mail-qk1-f194.google.com with SMTP id y16so4250134qki.7
 for <alsa-devel@alsa-project.org>; Fri, 02 Nov 2018 15:03:25 -0700 (PDT)
In-Reply-To: <943d10e2-299c-4393-f2f5-4ac8bbe400c3@linux.intel.com>
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
Cc: alsa-devel@alsa-project.org, Guneshwor Singh <guneshwor.o.singh@intel.com>, Sriram Periyasamy <sriramx.periyasamy@intel.com>, Jie Yang <yang.jie@linux.intel.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>, Rakesh Ughreja <rakesh.a.ughreja@intel.com>, Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>, Naveen Manohar <naveen.m@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 11/2/18, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com> wrote:
>
> On 11/2/18 6:24 AM, Arnd Bergmann wrote:
>> The skylake sound support is written to work both with or without
>> CONFIG_SND_SOC_HDAC_HDA, and uses an #ifdef to decide whether it should
>> link against that. However, this fails with SND_SOC_ALL_CODECS=m or
>> SND_SOC_INTEL_SKL_HDA_DSP_GENERIC_MACH=m when the Skylake support itself
>> is built-in, with this link error:
>>
>> sound/soc/intel/skylake/skl.o: In function `skl_probe':
>> skl.c:(.text+0x56c): undefined reference to `snd_soc_hdac_hda_get_ops'
>>
>> Using an explicit 'select' here simplifies the logic and prevents
>> it from happening, at the cost of always including the compile
>> time dependency.
>
> Thanks Arnd for the report. I don't quite agree with the proposal, this
> should be similar to HDAC_HDMI which is not selected by default, and
> there's no reason to force the support for HDAudio when the vast
> majority of Skylake+ devices which enable this driver don't have any
> HDaudio codec.

Sure, feel free to treat this patch as a bug report and come up with
a better fix.

> Also the code is skl.c is already conditional, so this function should
> not be required.
>
> Do you have a config that fails, I'd like to look at this further.

https://pastebin.com/4iYPGxkU is what first triggered this.

      Arnd
