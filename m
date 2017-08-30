From: Lambdadroid <lambdadroid@gmail.com>
Subject: Unable to play MP3 using TinyCompress and bytcr-rt5640
Date: Wed, 30 Aug 2017 14:08:48 +0200
Message-ID: <CAOmiHe+qmw34f_-yTqj6zy96bLXyGntd4qLAiQ8Aimmh5+rH=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f196.google.com (mail-qt0-f196.google.com
 [209.85.216.196])
 by alsa0.perex.cz (Postfix) with ESMTP id D8AC5266C5E
 for <alsa-devel@alsa-project.org>; Wed, 30 Aug 2017 14:08:50 +0200 (CEST)
Received: by mail-qt0-f196.google.com with SMTP id u11so4944200qtu.2
 for <alsa-devel@alsa-project.org>; Wed, 30 Aug 2017 05:08:50 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: vinod.koul@intel.com
List-Id: alsa-devel@alsa-project.org

Hi,

I'm attempting to use TinyCompress to play a MP3 file on a Baytrail
tablet (using bytcr-rt5640 on Linux 4.13-rc7) with ALSA's
Compress-Offload API. After finding the right quirks and setting up
the UCM files normal audio output is working, but I'm unable to play a
MP3 file using the `cplay` tool included with TinyCompress.

Note that `cplay` appears to be broken as of commit 50c2b03 "cplay:
check the values of fread". fread returns the number of items that
were read but the commit assumes it returns the number of bytes. I've
simply changed the check to `read != 1` to fix it.

When I play a MP3 file after fixing that I get a cryptic SST firmware
error in dmesg and there is nothing playing on the speakers:

[   29.080173] intel_sst_acpi 80860F28:00: FW Version 01.0c.00.01
[   39.575366] intel_sst_acpi 80860F28:00: FW sent async error msg:
[   39.578059] (null)00040009 00000000
[   39.578068] (null)00040009 00000000
[   53.872092] intel_sst_acpi 80860F28:00: FW sent async error msg:
[   53.874999] (null)0002000b 00000000
[   53.875006] (null)0002000b 00000000

I've tried various different MP3 files with different bit rates but
this happens for all of them. Is this an indication that it's not
supported on my device or is something else wrong?

Other related dmesg messages (but these look all fine to me):

[   14.085226] intel_sst_acpi 80860F28:00: Detected Baytrail-CR platform
[   14.085422] intel_sst_acpi 80860F28:00: LPE base: 0x51000000 size:0x200000
[   14.085425] intel_sst_acpi 80860F28:00: IRAM base: 0x510c0000
[   14.085475] intel_sst_acpi 80860F28:00: DRAM base: 0x51100000
[   14.085484] intel_sst_acpi 80860F28:00: SHIM base: 0x51140000
[   14.085492] intel_sst_acpi 80860F28:00: Mailbox base: 0x51144000
[   14.085499] intel_sst_acpi 80860F28:00: DDR base: 0x20000000
[   14.085730] intel_sst_acpi 80860F28:00: Got drv data max stream 25
[   14.976784] bytcr_rt5640 bytcr_rt5640: Overriding quirk 0x640002 => 0x510000
[   14.976788] bytcr_rt5640 bytcr_rt5640: quirk DMIC1_MAP enabled
[   14.976791] bytcr_rt5640 bytcr_rt5640: quirk DMIC enabled
[   14.976793] bytcr_rt5640 bytcr_rt5640: quirk SSP0_AIF1 enabled
[   14.976795] bytcr_rt5640 bytcr_rt5640: quirk MCLK_EN enabled
[   14.980650] bytcr_rt5640 bytcr_rt5640: snd-soc-dummy-dai <->
media-cpu-dai mapping ok
[   14.980710] bytcr_rt5640 bytcr_rt5640: snd-soc-dummy-dai <->
deepbuffer-cpu-dai mapping ok
[   14.980740] compress asoc: snd-soc-dummy-dai <-> compress-cpu-dai mapping ok
[   14.981233] bytcr_rt5640 bytcr_rt5640: rt5640-aif1 <-> ssp0-port mapping ok

The full dmesg and alsa-info.txt is quite big so I've uploaded it to
gist. I hope that's okay.
https://gist.github.com/lambdadroid/d46675e54720292ed7718c74247753b5

Thanks in advance!
Lambdadroid
