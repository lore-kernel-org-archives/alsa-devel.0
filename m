From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Intel Cherry Trail and NAU8824 codec
Date: Wed, 11 May 2016 16:10:35 -0500
Message-ID: <51832191-85a3-13b8-4f93-107c770d7f5b@linux.intel.com>
References: <CAOhsuUd1sFuQvwXAumhHrqe4+uTDeWWMC+YmtdT_0eNDwh3NSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 98175266CD3
 for <alsa-devel@alsa-project.org>; Wed, 11 May 2016 23:10:47 +0200 (CEST)
In-Reply-To: <CAOhsuUd1sFuQvwXAumhHrqe4+uTDeWWMC+YmtdT_0eNDwh3NSQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: TheKit <nekit1000@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 5/9/16 9:41 AM, TheKit wrote:
> Hello,
>
> I'm trying to get sound working in Linux on Cube iWork8 Ultimate
> tablet. It has Windows/Android dualboot, but no kernel sources for
> Android, unfortunately. From dmesg I see that NAU8824 codec is used,
> which I can't find any drivers for, except proposed patch that wasn't
> merged: https://lkml.org/lkml/2015/3/4/765
>
> But, as I understand, additional code (like
> https://github.com/kirananto/ZENFONE2/blob/master/sound/soc/intel/board/cht_bl_dpcm_rt5672.c)
> is needed to bridge it with Cherry Trail SoC. Any suggestions how to
> go about this?

It's usually the same process:
1. find the codec driver sources, port them to the last kernel version
2. add ACPI support to the codec driver based on the contents of the 
DSDT table (same HID needed to probe)
3. add a machine driver based on existing examples and reference it from 
sst_acpi
4. add an asound.state or UCM file that provides the relevant register 
values

The kernel sources should be available from the manufacturer if they 
understand what GPL means.
>
> Relevant lines of dmesg from stock Android kernel (where sound works):
> <6>[    8.665477] nau8824_i2c_probe enter
> <3>[    8.666609] snd_intel_sst: sst_platform_get_resources_edk
> <3>[    8.672489] snd_intel_sst: LPE base: 0x91600000
> size:0x200000snd_intel_sst: IRAM base: 0x916c0000
> <3>[    8.682557] snd_intel_sst: DRAM base: 0x91700000snd_intel_sst:
> SHIM base: 0x91740000
> <3>[    8.691298] snd_intel_sst: Mailbox base:
> 0x91744000snd_intel_sst: DDR base: 0x20000000
> <6>[    8.700428] snd_intel_sst: Enter: sst_audio_platform_init
> <6>[    8.700646] snd_intel_sst: audio:set_cht_platform_config
> <6>[    8.700900] snd_soc_sst_platform: sst_platform_probe is deferred
> <6>[    8.700918] platform sst-platform: Driver sst-platform requests
> probe deferral
> <3>[    8.700927] snd_intel_sst: board_name:Cherry Trail CR
> <6>[    8.706611] snd_intel_sst: Registering machine device cht_nau88l24
> <3>[    8.707127] snd_intel_sst: Requesting FW fw_sst_22a8.bin now...
> <4>[    8.713815] intel_sst_acpi 808622A8:00: Direct firmware load
> failed with error -2
> <4>[    8.724734] intel_sst_acpi 808622A8:00: Falling back to user helper
> <6>[    8.789741] platform cht_nau88l24: Driver cht_nau88l24 requests
> probe deferral
> <6>[    8.789967] cht_cr_nau88l24: Cherrytrail Machine Driver
> cht_nau8824 registerd
> <6>[    9.077571] snd_soc_sst_platform: sst_platform_probe is deferred
> <3>[   10.856689] sst-platform sst-platform: ASoC: no sink widget
> found for Audio Capture
> <3>[   10.856693] sst-platform sst-platform: ASoC: Failed to add route
> media3_out -> direct -> Audio Capture
> <6>[   10.873799] nau8824_codec_probe enter
> <6>[   11.062658] cht_nau88l24 cht_nau88l24: snd-soc-dummy-dai <->
> Headset-cpu-dai mapping ok
> <6>[   11.062754] cht_nau88l24 cht_nau88l24: snd-soc-dummy-dai <->
> Deepbuffer-cpu-dai mapping ok
> <6>[   11.062902] cht_nau88l24 cht_nau88l24: snd-soc-dummy-dai <->
> Voip-cpu-dai mapping ok
> <6>[   11.063035] cht_cr_nau88l24: cht_hs_detection:Check hs insertion
>  after 500 msec
> <6>[   11.063035] cht_nau88l24 cht_nau88l24: snd-soc-dummy-dai <->
> Lowlatency-cpu-dai mapping ok
> <6>[   11.063383] cht_nau88l24 cht_nau88l24: snd-soc-dummy-dai <->
> Probe-cpu-dai mapping ok
> <6>[   11.063596] cht_nau88l24 cht_nau88l24: nau8824-aif1 <->
> ssp2-port mapping ok
> <6>[   11.063638] cht_nau88l24 cht_nau88l24: snd-soc-dummy-dai <->
> snd-soc-dummy-dai mapping ok
> <6>[   11.063674] cht_nau88l24 cht_nau88l24: snd-soc-dummy-dai <->
> snd-soc-dummy-dai mapping ok
> <3>[   11.063742] cht_nau88l24 cht_nau88l24: ASoC: Failed to add
> Headset Mic Switch: -16
> <6>[   11.095628] input: cherrytrailaud Headset Jack as
> /devices/platform/cht_nau88l24/sound/card1/input9
> <6>[   11.096265] cht_cr_nau88l24: snd_cht_mc_probe successful
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
