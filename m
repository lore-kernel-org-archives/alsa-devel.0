From: Antonio Ospite <ao2@ao2.it>
Subject: Intel SST on a Bay Trail tablet
Date: Mon, 23 Feb 2015 18:39:13 +0100
Message-ID: <20150223183913.fb262011d6300425da7f34be@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp209.alice.it (smtp209.alice.it [82.57.200.105])
 by alsa0.perex.cz (Postfix) with ESMTP id 763E626067D
 for <alsa-devel@alsa-project.org>; Mon, 23 Feb 2015 18:39:16 +0100 (CET)
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
Cc: Vinod Koul <vinod.koul@intel.com>, Ramesh Babu K V <Ramesh.Babu@intel.com>, Omair Mohammed Abdullah <omair.m.abdullah@intel.com>, Harsha Priya <priya.harsha@intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi,

I am trying to get the Intel SST driver working on a Teclast X98 Air 3G
[1], it's a Bay Trail tablet. The tests below have been made with
4.0.0-rc1 and the firmware files from
https://git.kernel.org/cgit/linux/kernel/git/firmware/linux-firmware.git/tree/intel

The DSDT on this device is quite broken, and I am patching it to get
stuff working.

The audio device works just fine under Android, I don't know if that's
because the Android kernel is ignoring the DSDT and is hard-coding
some platform data.

Anyhow, with the untouched DSDT[2] I was getting this message in
dmesg[3]:

[   11.344095] platform byt-rt5640: Driver byt-rt5640 requests probe deferral
[   11.404831] resource sanity check: requesting [mem 0x91000000-0x911fffff], which spans more than ADMA0F28:00 [mem 0x91000000-0x91000fff]
[   11.404833] ------------[ cut here ]------------
[   11.404849] WARNING: CPU: 0 PID: 213 at arch/x86/mm/ioremap.c:197 __ioremap_caller+0x22c/0x350()
...

I guessed this was because the DSDT defined an ADMA0F28 device with
a memory resource overlapping with the LPMA device.

So I removed the overlapping resources (ADMA0F28 and SSPX0000) in the
DSDT and then the driver attempted to boot the audio device but failed
with this message in dmesg[4]:

[   11.602291] baytrail-pcm-audio baytrail-pcm-audio: ipc: error DSP boot timeout ...

Then I noticed that the Interrupt resources of the LPMA device were out
of order in the DSDT, so I put the Interrupt 0x18 as the first one[5]
and now the driver can boot the device and upload the firmware to it[6]:

[   11.433460] baytrail-pcm-audio baytrail-pcm-audio: FW version: 04.05.13.a0
[   11.433468] baytrail-pcm-audio baytrail-pcm-audio: Build type: a0
[   11.433473] baytrail-pcm-audio baytrail-pcm-audio: Build date: Apr  2 2014 14:14:39
[   11.448257] byt-rt5640 byt-rt5640: rt5640-aif1 <-> baytrail-pcm-audio mapping ok ...

But still no sound.

I can see the mixer controls in alsamixer and I tried to initialize them
copying from the alsactl output from the Android kernel[7], but no,
still no sound.

I do not know if that matters, but the driver still emits this message:

[   11.398304] baytrail-pcm-audio baytrail-pcm-audio: error: invalid DMA engine 0
[   11.398314] baytrail-pcm-audio baytrail-pcm-audio: sst_dma_new failed -22 ...

I noticed that on the Android kernel[8] the DMA channels for the
ADMA0F28 device are actually configured, the intel_mid_dma driver sets
up 4 channels for it along with 2 x 6 channels for the INTL9C60 device.

On the mainline kernel only the INTL9C60 device gets configured, by the
dw_dmac driver and with 2 x 8 channels.

I do not know much about these details tho.

Also, the codec driver on the Android kernel (byt_rt5642) seems to use
one GPIO as an interrupt[9]:
    390:      0      1      0      0  VLV-GPIO-gpio  byt-codec-int

Which is pin 4 on GPO2, but the codec driver in the mainline kernel
does not seem to be using this; however AFAICS in sound/soc/codecs/rt5640.c
a gpio pin in only used for suspend/resume, so it is not strictly needed
if it's already in the correct state, right?

Last question, what is the difference between having the device detected
by sound/soc/intel/sst-acpi.c (like in my case) opposed to
sound/soc/intel/sst/sst_acpi.c? I can see the 80860F28 id in both the
files but they seem to load different firmwares.

Any idea of what is missing?
It's the DSDT which still needs adjusting, or are some changes needed
(also) in the kernel driver?

Thanks,
   Antonio

[1] http://ao2.it/110
[2] http://ao2.it/tmp/sst-baytrail-on-Teclast-X98-Air-3G/dsdt_sst_original.dsl
[3] http://ao2.it/tmp/sst-baytrail-on-Teclast-X98-Air-3G/dmesg_mainline_sst_original_DSDT.log
[4] http://ao2.it/tmp/sst-baytrail-on-Teclast-X98-Air-3G/dmesg_mainline_sst_without_ADMA0F28.log
[5] http://ao2.it/tmp/sst-baytrail-on-Teclast-X98-Air-3G/dsdt_sst_without_ADMA0F28_reorder_Interrupts.dsl
[6] http://ao2.it/tmp/sst-baytrail-on-Teclast-X98-Air-3G/dmesg_mainline_sst_without_ADMA0F28_reorder_Interrupts.log
[7] http://ao2.it/tmp/sst-baytrail-on-Teclast-X98-Air-3G/android_asound.state
[8] http://ao2.it/tmp/sst-baytrail-on-Teclast-X98-Air-3G/dmesg_Android_Teclast_X98_Air_3G.log
[9] http://ao2.it/tmp/sst-baytrail-on-Teclast-X98-Air-3G/android_proc_interrupts.log

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
