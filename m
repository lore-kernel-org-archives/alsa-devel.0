From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: writing an alsa driver
Date: Thu, 3 Mar 2016 16:57:45 +0530
Message-ID: <20160303112745.GJ11154@localhost>
References: <1433156768.2642.21.camel@loki> <20150608084951.GA7512@dellaz>
 <loom.20150613T153708-781@post.gmane.org>
 <20150615164623.GA693@asus> <1434387868.2434.50.camel@loki>
 <20150623090932.GA6856@dellaz> <20150624102157.GL19530@localhost>
 <20150624182120.GA481@asus> <20150625032407.GQ19530@localhost>
 <20160303111110.GA13202@acervm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 35BE626519F
 for <alsa-devel@alsa-project.org>; Thu,  3 Mar 2016 12:23:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20160303111110.GA13202@acervm>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michele Curti <michele.curti@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Luka Karinja <luka.karinja@gmail.com>, Takashi Iwai <tiwai@suse.de>, ao2@ao2.it, alsa-devel@alsa-project.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "Nikula,
 Jarkko" <jarkko.nikula@intel.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 03, 2016 at 12:11:10PM +0100, Michele Curti wrote:
> Hi Vinod,
> 
> On Thu, Jun 25, 2015 at 08:54:07AM +0530, Vinod Koul wrote:
> > > [    2.700468] sst-mfld-platform sst-mfld-platform: Slot control: codec_in rx deinterleaver codec_in1_1 doesn't have DAPM widget!!!
> > this is unexpected, I will check on this
> > 
> > > ...
> > > [    7.970937] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
> > > [    7.970964] intel_sst_acpi 80860F28:00: fw returned err -16
> > Yes this is a problem, which FW are you using

Have you tried the recent kernels, Pierre did a bunch of update and got many
things working.

As for timeout, that simply means we have send a message to DSP which failed
to get a response. Perhpas the message had some bad element of FW had a
bug/crashed...

> > 
> 
> I have a question regarding the FW timeout, but since it has been a long
> time since last email, let me summarize the thread..
> 
> I tried to get sound working on an Asus X205TA laptop so, as far as I
> understood, 3 things are needed in the ASoC world:
> 1. codec driver
> 2. platform driver
> 3. machine driver
> 
> 1. codec driver (patch 0001 at [1])
> 
> It seems that the codec is a Relatek RT5648, and in kernel there is no
> driver for it, but since it has the same product Id of the RT5645
> (0x6308) I simply added an I2C and an ACPI match to the RT5645 codec
> driver.
> 
> 2. platform driver (patch 0002 at [1])
> 
> Used the sst-mfld-platform one (under sound/soc/intel/atom/sst), changing
> the .acpi_ipc_irq_index from 5 to 0 because the DSP interrupt order in
> the ACPI DSDT table of this laptop is different from the "normal" (see
> line 3745 of dsdt.dsl at [2]).
> 
> $ cat /proc/interrupts | grep sst
>             CPU0       CPU1       CPU2       CPU3       
>    1:         24          0          0          0   IO-APIC   29-fasteoi   intel_sst_driver
> 
> Used the SSP0 version of the ADSP firmware (found at [3]), beacuse the
> mainline FW uses the SSP2 port but this laptop has an atom Z3735F which
> has only two SSP ports.
> 
> 3. machine driver (patch 0003 at [1])
> 
> It's a copy-paste of sound/soc/intel/boards/bytcr_rt5651.c, but using
> SSP0 instead of SSP2 and rt5645 instead of rt5651.
> 
> 
> 
> So, applying the three patches to the mainline linux kernel the sound
> card shows up (aplay -l finds it) and at boot I got these errors:
> 
> [    4.378238] sst-mfld-platform sst-mfld-platform: Slot control: codec_out tx interleaver slot 0 doesn't have DAPM widget!!!
> [    4.381301] sst-mfld-platform sst-mfld-platform: Slot control: codec_out tx interleaver slot 1 doesn't have DAPM widget!!!
> [    4.384307] sst-mfld-platform sst-mfld-platform: Slot control: codec_out tx interleaver slot 2 doesn't have DAPM widget!!!
> [    4.387276] sst-mfld-platform sst-mfld-platform: Slot control: codec_out tx interleaver slot 3 doesn't have DAPM widget!!!
> [    4.390229] sst-mfld-platform sst-mfld-platform: Slot control: codec_in rx deinterleaver codec_in0_0 doesn't have DAPM widget!!!
> [    4.390249] sst-mfld-platform sst-mfld-platform: Slot control: codec_in rx deinterleaver codec_in0_1 doesn't have DAPM widget!!!
> [    4.390268] sst-mfld-platform sst-mfld-platform: Slot control: codec_in rx deinterleaver codec_in1_0 doesn't have DAPM widget!!!
> [    4.390286] sst-mfld-platform sst-mfld-platform: Slot control: codec_in rx deinterleaver codec_in1_1 doesn't have DAPM widget!!!
> 
> About a minute of these errors:
> 
> [   62.894026] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
> [   62.903888] intel_sst_acpi 80860F28:00: fw returned err -16
> 
> And, when I play some audio, these ones:
> 
> [  102.350606]  Audio Port: ASoC: no backend DAIs enabled for Audio Port
> 
> Full dmesg at [4].
> 
> 
> And, finally, the question: it is possible that the firmware timeout is
> due to a missing alsa audio path and not to a fw problem?
> 
> Thanks,
> Michele
> 
> 
> [1] https://github.com/michelecurti/x205ta/tree/master/sound-patches
> [2] https://github.com/michelecurti/x205ta/tree/master/acpi-tables
> [3] https://git.kernel.org/cgit/linux/kernel/git/vkoul/firmware.git/commit/?h=byt
> [4] http://pastebin.com/XAQZUvkM
> 

-- 
~Vinod
