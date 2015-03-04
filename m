From: Antonio Ospite <ao2@ao2.it>
Subject: Re: Intel SST on a Bay Trail tablet
Date: Wed, 4 Mar 2015 17:02:18 +0100
Message-ID: <20150304170218.7b397993ce670902800109f1@ao2.it>
References: <20150223183913.fb262011d6300425da7f34be@ao2.it>
 <20150303151621.c6fc3cfa308aed62484b87a0@ao2.it>
 <54F5CB3D.7020100@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp206.alice.it (smtp206.alice.it [82.57.200.102])
 by alsa0.perex.cz (Postfix) with ESMTP id 906732650DB
 for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2015 17:02:35 +0100 (CET)
In-Reply-To: <54F5CB3D.7020100@linux.intel.com>
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
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Ramesh Babu K V <Ramesh.Babu@intel.com>, Omair Mohammed Abdullah <omair.m.abdullah@intel.com>, Harsha Priya <priya.harsha@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 03 Mar 2015 16:54:53 +0200
Jarkko Nikula <jarkko.nikula@linux.intel.com> wrote:

> Hi
> 
> On 03/03/2015 04:16 PM, Antonio Ospite wrote:
> > On Mon, 23 Feb 2015 18:39:13 +0100
> > Antonio Ospite <ao2@ao2.it> wrote:
> >
> >> Hi,
> >>
> >> I am trying to get the Intel SST driver working on a Teclast X98 Air 3G
> >> [1], it's a Bay Trail tablet. The tests below have been made with
> >> 4.0.0-rc1 and the firmware files from
> >> https://git.kernel.org/cgit/linux/kernel/git/firmware/linux-firmware.git/tree/intel
> >>
> >
> > Hi, has anyone had a chance to take a look at my previous message?
> >
> I forgot to answer...

Do you confirm that the ADMA0F28 and SSPX0000 devices I mentioned in the
original mail are not necessary in the DSDT?

> Some earlier notes including Teclast X98 Air 3G 
> and patch attempts are collected here:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=86581
>

I took a look, I fixed the interrupt issue reported there in the DSDT
rather than in the kernel, and I confirm I get AudioDSP interrupts when
playing.

> Unfortunately bug is not solved since it looks these newer Baytrail 
> Windows 8.1 based machines use different SSP port than previous ones and 
> Linux DSP firmware is hardcoded for SSP2.
>

So the current guess is that DSP is indeed sending the data, but on the
wrong port and hence the codec chip is not receiving it, isn't it?

Can Intel provide another firmware?

> What's interesting does that Android FW use other than SSP2 or does 
> Teclast have some extra amplifier.
>

I tried the chromium firmwares too but with no much luck:
https://chromium.googlesource.com/chromiumos/third_party/linux-firmware/+/refs/heads/stabilize-5339.B/intel/

I cannot use the android firmware because it seems to be in a different
format (ELF instead of a structured blob with a SST header), I uploaded
the android blobs here:
http://ao2.it/tmp/sst-baytrail-on-Teclast-X98-Air-3G/android_firmware/

Any hint about how to convert them to a form usable by the mainline
driver?

Or any suggestions about how can I get more info from the running Android
system?

> > [...]
> >> Last question, what is the difference between having the device detected
> >> by sound/soc/intel/sst-acpi.c (like in my case) opposed to
> >> sound/soc/intel/sst/sst_acpi.c? I can see the 80860F28 id in both the
> >> files but they seem to load different firmwares.
> >>
> 
> Different firmware, driver stack and machine driver despite the same LPE 
> ACPI ID and codec ACPI ID. (We really should have some additional DMI 
> quirks that does the selection because of the same ACPI IDs).
>

Just curios, is a unification of the drivers possible/planned?

If I remove snd-soc-sst-acpi.ko I can get the other driver to load
(i.e. snd_intel_sst_acpi, no _soc_ in the name):

[    9.940954] bytt100_rt5640 bytt100_rt5640: snd-soc-dummy-dai <-> media-cpu-dai mapping ok
[    9.941015] compress asoc: snd-soc-dummy-dai <-> compress-cpu-dai mapping ok
[    9.941090] bytt100_rt5640 bytt100_rt5640: rt5640-aif1 <-> ssp2-port mapping ok
[    9.941249] bytt100_rt5640 bytt100_rt5640: Connecting non-supply widget to supply widget is not supported (Int Mic -> LDO2)
[    9.941254] bytt100_rt5640 bytt100_rt5640: ASoC: no dapm match for Int Mic --> (null) --> LDO2
[    9.941259] bytt100_rt5640 bytt100_rt5640: ASoC: Failed to add route Int Mic -> direct -> LDO2
[   10.826466] sst-mfld-platform sst-mfld-platform: Slot control: codec_out tx interleaver slot 0 doesn't have DAPM widget!!!
[   10.826988] sst-mfld-platform sst-mfld-platform: Slot control: codec_out tx interleaver slot 1 doesn't have DAPM widget!!!
[   10.827496] sst-mfld-platform sst-mfld-platform: Slot control: codec_out tx interleaver slot 2 doesn't have DAPM widget!!!
[   10.828008] sst-mfld-platform sst-mfld-platform: Slot control: codec_out tx interleaver slot 3 doesn't have DAPM widget!!!
[   10.828501] sst-mfld-platform sst-mfld-platform: Slot control: codec_in rx deinterleaver codec_in0_0 doesn't have DAPM widget!!!
[   10.829022] sst-mfld-platform sst-mfld-platform: Slot control: codec_in rx deinterleaver codec_in0_1 doesn't have DAPM widget!!!
[   10.829550] sst-mfld-platform sst-mfld-platform: Slot control: codec_in rx deinterleaver codec_in1_0 doesn't have DAPM widget!!!
[   10.830212] sst-mfld-platform sst-mfld-platform: Slot control: codec_in rx deinterleaver codec_in1_1 doesn't have DAPM widget!!!

but then I couldn't use the card:

[   57.970464]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port

Full dmesg here:
http://ao2.it/tmp/sst-baytrail-on-Teclast-X98-Air-3G/dmesg_mainline_snd_intel_sst_acpi.log

But this is just to see what would happen, I am supposed to use the
snd-soc-sst-acpi.ko driver, right?

> >
> > Another thing I noticed is that the Android driver for the rt5640 codec
> > defines some controls which are not in the mainline driver:
> >
> >    OUT MIXR BST3 Switch
> >    OUT MIXL BST3 Switch
> >    RECMIXR BST3 Switch
> >    RECMIXL BST3 Switch
> >    IN1 Mode Control
> >    IN2 Mode Control
> >
> I'm not sure but these might be FW implemented DSP controls? Vinod, do 
> you know?

I could add these myself and other small things (e.g. jack insertion
detection) to the codec driver once I got audio output working, but I
really do not know how to deal with the SST driver.

Thanks,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
