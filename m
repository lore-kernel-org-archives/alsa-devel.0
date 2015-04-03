From: Antonio Ospite <ao2@ao2.it>
Subject: Re: Intel SST on a Bay Trail tablet
Date: Fri, 3 Apr 2015 15:34:14 +0200
Message-ID: <20150403153414.b8de8df914664d7d7967120c@ao2.it>
References: <20150223183913.fb262011d6300425da7f34be@ao2.it>
 <20150303151621.c6fc3cfa308aed62484b87a0@ao2.it>
 <54F5CB3D.7020100@linux.intel.com>
 <20150304170218.7b397993ce670902800109f1@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp209.alice.it (smtp209.alice.it [82.57.200.105])
 by alsa0.perex.cz (Postfix) with ESMTP id 08850265879
 for <alsa-devel@alsa-project.org>; Fri,  3 Apr 2015 15:34:17 +0200 (CEST)
In-Reply-To: <20150304170218.7b397993ce670902800109f1@ao2.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Ramesh Babu K V <Ramesh.Babu@intel.com>, Omair Mohammed Abdullah <omair.m.abdullah@intel.com>, "Subhransu S. Prusty <subhransu.s.prusty@intel.com>"@alsa-project.org, Harsha Priya <priya.harsha@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 4 Mar 2015 17:02:18 +0100
Antonio Ospite <ao2@ao2.it> wrote:

> On Tue, 03 Mar 2015 16:54:53 +0200
> Jarkko Nikula <jarkko.nikula@linux.intel.com> wrote:
> 
[...]
> > > [...]
> > >> Last question, what is the difference between having the device detected
> > >> by sound/soc/intel/sst-acpi.c (like in my case) opposed to
> > >> sound/soc/intel/sst/sst_acpi.c? I can see the 80860F28 id in both the
> > >> files but they seem to load different firmwares.
> > >>
> > 
> > Different firmware, driver stack and machine driver despite the same LPE 
> > ACPI ID and codec ACPI ID. (We really should have some additional DMI 
> > quirks that does the selection because of the same ACPI IDs).
> >
> 
> Just curios, is a unification of the drivers possible/planned?
>

Hi again, I am back on this after having read something more, the full
thread is still here for those willing to catch up:
http://thread.gmane.org/gmane.linux.alsa.devel/134554

Since the firmware which comes with Andoid is more similar to the
upstream fw_sst_0f28.bin than is to fw_sst_0f28.bin-48kHz_i2s_master I
decided to give another try to bytcr_dpcm_rt5640.c instead of insisting
with byt-rt5640.c

The log is still as below, but I got one step further, keep reading.

> [    9.940954] bytt100_rt5640 bytt100_rt5640: snd-soc-dummy-dai <-> media-cpu-dai mapping ok
> [    9.941015] compress asoc: snd-soc-dummy-dai <-> compress-cpu-dai mapping ok
> [    9.941090] bytt100_rt5640 bytt100_rt5640: rt5640-aif1 <-> ssp2-port mapping ok
> [    9.941249] bytt100_rt5640 bytt100_rt5640: Connecting non-supply widget to supply widget is not supported (Int Mic -> LDO2)
> [    9.941254] bytt100_rt5640 bytt100_rt5640: ASoC: no dapm match for Int Mic --> (null) --> LDO2
> [    9.941259] bytt100_rt5640 bytt100_rt5640: ASoC: Failed to add route Int Mic -> direct -> LDO2
> [   10.826466] sst-mfld-platform sst-mfld-platform: Slot control: codec_out tx interleaver slot 0 doesn't have DAPM widget!!!
> [   10.826988] sst-mfld-platform sst-mfld-platform: Slot control: codec_out tx interleaver slot 1 doesn't have DAPM widget!!!
> [   10.827496] sst-mfld-platform sst-mfld-platform: Slot control: codec_out tx interleaver slot 2 doesn't have DAPM widget!!!
> [   10.828008] sst-mfld-platform sst-mfld-platform: Slot control: codec_out tx interleaver slot 3 doesn't have DAPM widget!!!
> [   10.828501] sst-mfld-platform sst-mfld-platform: Slot control: codec_in rx deinterleaver codec_in0_0 doesn't have DAPM widget!!!
> [   10.829022] sst-mfld-platform sst-mfld-platform: Slot control: codec_in rx deinterleaver codec_in0_1 doesn't have DAPM widget!!!
> [   10.829550] sst-mfld-platform sst-mfld-platform: Slot control: codec_in rx deinterleaver codec_in1_0 doesn't have DAPM widget!!!
> [   10.830212] sst-mfld-platform sst-mfld-platform: Slot control: codec_in rx deinterleaver codec_in1_1 doesn't have DAPM widget!!!
> 
> but then I couldn't use the card:
> 
> [   57.970464]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
> 
> Full dmesg here:
> http://ao2.it/tmp/sst-baytrail-on-Teclast-X98-Air-3G/dmesg_mainline_snd_intel_sst_acpi.log
> 

I realized than I needed to set up the path between the FrontEnd DAI
and the BackEnd one, and in fact the error below goes away and I can
_start_ some playback after switching on these controls:
	codec_out1 mix 0 pcm0_in Switch
	media0_out mix 0 media1_in Switch
which AFAICS constitute the playback path.

However there is still no sound, and the playback stalls, and the
interrupt count suddenly stops for the intel_sst_driver IRQ
(in /proc/interrupts).

By looking at /sys/kernel/debug under Android it looks like the
codec is connected to SSP2, and not SSP0 as we imagined before:
/sys/kernel/debug/asoc/baytrailaudio/sst-platform/dapm/ssp2 playback
/sys/kernel/debug/asoc/baytrailaudio/sst-platform/dapm/ssp2 Capture

So now I'd like to make sure the mixer settings are OK before looking
elsewhere again.

Vinod, Subhransu, or anyone else, can you share some working alsa state
files for the baytrailcraudio device in linux mainline?

JFTR I am running a 64bit kernel, is this OK on BayTrail?
I guess it is, but I just wanted to mention this to be sure.

Thanks,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
