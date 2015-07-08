From: Tyler Yeomans <tyeo098@gmail.com>
Subject: Re: Intel Baytrail Linux Audio
Date: Wed, 08 Jul 2015 10:30:41 -0400
Message-ID: <559D3411.6060306@gmail.com>
References: <8D3F6266AEB6384E807C6FFC6FE195E30B49AE39@BGSMSX101.gar.corp.intel.com>	<20150703143608.7afb34c985d82982e929484e@ao2.it>	<20150703130658.GA1689228@phare.normalesup.org>	<559A90CE.2030105@gmail.com>	<20150707031950.GD11002@localhost>	<559BDB7F.9010105@gmail.com>	<20150707170821.GL11002@localhost>	<559C3F4A.5030307@gmail.com>	<20150708033604.GM11002@localhost>
 <20150708102308.91b7258f243e354b1365a47e@ao2.it>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010705040709030506000100"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f174.google.com (mail-qk0-f174.google.com
 [209.85.220.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 52F632615F7
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2015 16:30:37 +0200 (CEST)
Received: by qkbp125 with SMTP id p125so163986212qkb.2
 for <alsa-devel@alsa-project.org>; Wed, 08 Jul 2015 07:30:36 -0700 (PDT)
In-Reply-To: <20150708102308.91b7258f243e354b1365a47e@ao2.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Antonio Ospite <ao2@ao2.it>, Vinod Koul <vinod.koul@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Nicolas George <george@nsup.org>, "Nikula, Jarkko" <jarkko.nikula@intel.com>, "Girdwood, Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------010705040709030506000100
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Vinod,

I have attached the dmesg that occurs after I play the sound test. 
(dynamic debug and FE-BE was set via SSH terminal)

Antonio,

While it is true that I had not played any sound when I had collected 
the interrupts from previous mail, after doing the test for Vinod above 
I again collected the interrupt count, unfortunately as you can see it 
is the same...

root@mykro:~# cat /proc/interrupts | grep intel
    7:          0          0          0          0   IO-APIC 
28-fasteoi   intel_sst_driver

Additionally, you were correct about the sorting of interrupts, as my 
dissembled DSDT table shows:
(from Device(LPEA) section)
       Interrupt (ResourceConsumer, Level, ActiveLow, Exclusive, ,, )
                 {
                     0x0000001D,
                 }
                 Interrupt (ResourceConsumer, Level, ActiveLow, 
Exclusive, ,, )
                 {
                     0x00000018,
                 }
                 Interrupt (ResourceConsumer, Level, ActiveLow, 
Exclusive, ,, )
                 {
                     0x00000019,
                 }
                 Interrupt (ResourceConsumer, Level, ActiveLow, 
Exclusive, ,, )
                 {
                     0x0000001A,
                 }
                 Interrupt (ResourceConsumer, Level, ActiveLow, 
Exclusive, ,, )
                 {
                     0x0000001B,
                 }
                 Interrupt (ResourceConsumer, Level, ActiveLow, 
Exclusive, ,, )
                 {
                     0x0000001C,
                 }

For now I can research into overriding the DSDT so the interrupts are in 
order.

Thanks-

Tyler

On 07/08/2015 04:23 AM, Antonio Ospite wrote:
> On Wed, 8 Jul 2015 09:06:04 +0530
> Vinod Koul <vinod.koul@intel.com> wrote:
>
>> On Tue, Jul 07, 2015 at 05:06:18PM -0400, Tyler Yeomans wrote:
> [...]
>>> Additionally, the interrupts report as follows... none:
>>> $ cat /proc/interrupts | grep sst
>>>     7:          0          0          0          0   IO-APIC
>>> 28-fasteoi   intel_sst_driver
>> So this makes me suspect interrupts, we should have seen something here
>>
> Tyler, maybe it's trivial but I will spell it out anyway: before any
> interrupt gets fired, something needs to be played (e.g. speaker-test).
>
>> Liam, do you know how whats different in BYT devices from interrupts. I
>> recall Jarkko saying some issues with the way interrupts are exposed..?
>>
> The details are here:
> https://bugzilla.kernel.org/show_bug.cgi?id=86581
>
> A summary is below:
>
> Some devices declare interrupts in their DSDT in an order different from
> what the mainline linux driver expects, in particular the DSP-host
> interrupt is sometimes declared first while the driver expects it at
> index 5.
>
> To check that, dump the DSDT table (look up the details), and look for
> "Device (LPEA)", then check the order of the "Interrupt" definitions.
>
> Some devices define 0x0000001D as the first one, and this does not work
> with the the mainline driver which expects the interrupts sorted
> numerically (i.e. 0x0000001D is the sixth one starting from 0x00000018
> and after 0x0000001C).
>
> The problem can be fixed in two ways:
>    - Override your DSDT with one which reorders the interrupts
>      (that's what I did).
>    - Apply https://bugzilla.kernel.org/attachment.cgi?id=155341 to the
>      driver to use the "right" index as per the original device DSDT.
>      NOTE: the file paths changed in recent kernels so you may need to
>      apply the change manually.
>
> A final note, you also need to set the right codec controls to get
> audio; setting the FE-BE path is necessary to make playback "work" but
> it may not be enough to actually get sound, so make sure you run the
> full script Vinod provided in
> http://mailman.alsa-project.org/pipermail/alsa-devel/2015-June/094080.html
>
> Ciao,
>     Antonio
>


--------------010705040709030506000100
Content-Type: text/plain; charset=UTF-8;
 name="dmesg.txt.3"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg.txt.3"

[63363.677513] [drm:fw_domains_get [i915]] *ERROR* render: timed out waiting for forcewake ack request.
[63664.170402] sst-mfld-platform sst-mfld-platform: rx slot - slot 0 map = 0x1
[63664.170434] sst-mfld-platform sst-mfld-platform: rx slot - slot 1 map = 0x2
[63664.170462] sst-mfld-platform sst-mfld-platform: rx slot - slot 2 map = 0x4
[63664.170498] sst-mfld-platform sst-mfld-platform: rx slot - slot 3 map = 0x8
[63664.170667] sst-mfld-platform sst-mfld-platform: tx channel - codec_out0_0 map = 0x1
[63664.170697] sst-mfld-platform sst-mfld-platform: tx channel - codec_out0_1 map = 0x2
[63664.170727] sst-mfld-platform sst-mfld-platform: tx channel - codec_out1_0 map = 0x4
[63664.170763] sst-mfld-platform sst-mfld-platform: tx channel - codec_out1_1 map = 0x8
[63665.622301] sst-mfld-platform sst-mfld-platform: rx slot - slot 0 map = 0x1
[63665.622329] sst-mfld-platform sst-mfld-platform: rx slot - slot 1 map = 0x2
[63665.622354] sst-mfld-platform sst-mfld-platform: rx slot - slot 2 map = 0x4
[63665.622385] sst-mfld-platform sst-mfld-platform: rx slot - slot 3 map = 0x8
[63665.622531] sst-mfld-platform sst-mfld-platform: tx channel - codec_out0_0 map = 0x1
[63665.622558] sst-mfld-platform sst-mfld-platform: tx channel - codec_out0_1 map = 0x2
[63665.622584] sst-mfld-platform sst-mfld-platform: tx channel - codec_out1_0 map = 0x4
[63665.622615] sst-mfld-platform sst-mfld-platform: tx channel - codec_out1_1 map = 0x8
[63718.847709] sst-mfld-platform sst-mfld-platform: enable=1, usage=0
[63718.847808] writing to lpe: 00000000: 01 01 01 01 00 00 08 00 ff ff ff ff 55 00 00 00  ............U...
[63719.798810] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[63719.798820] intel_sst_acpi 80860F28:00: fw returned err -16
[63719.798830] sst-mfld-platform sst-mfld-platform: Enter: enable=1 port_name=ssp2-port
[63719.798835] sst-mfld-platform sst-mfld-platform: ssp_id: 3
[63719.798840] writing to lpe: 00000000: 01 01 01 01 00 00 1a 00 ff ff ff ff 75 00 12 00  ............u...
[63719.798844] writing to lpe: 00000010: 03 00 03 00 18 09 0f ff 0f ff 03 00 01 01 01 00  ................
[63719.798847] writing to lpe: 00000020: 00 00                                            ..
[63720.734175] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[63720.734184] intel_sst_acpi 80860F28:00: fw returned err -16
[63720.735173] intel_sst_acpi 80860F28:00: Alloc for str 1 pipe 0x90
[63721.654965] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[63721.654975] intel_sst_acpi 80860F28:00: FW alloc failed ret -16
[63721.654980] intel_sst_acpi 80860F28:00: sst_get_stream returned err -5
[63721.654986] sst-mfld-platform sst-mfld-platform: ASoC: cpu DAI prepare error: -5
[63721.654991]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port failed
[63721.655476] sst-mfld-platform sst-mfld-platform: enter, dai-name=media-cpu-dai dir=0
[63721.655484] sst-mfld-platform sst-mfld-platform: Stream name=Headset Playback
[63721.655616] sst-mfld-platform sst-mfld-platform: enter, dai-name=media-cpu-dai dir=0
[63721.655621] sst-mfld-platform sst-mfld-platform: Stream name=Headset Playback
[63721.656267]  Baytrail Audio Port: sst_platform_pcm_trigger called
[63721.656275]  Baytrail Audio Port: sst: Trigger Start
[63721.656281]  SSP2-Codec: sst_platform_pcm_trigger called
[63721.656296]  Baytrail Audio Port: sst: error code = -22
[63721.656306] bytt100_rt5640 bytt100_rt5640: BUG: , pos = -22, buffer size = 203830, period size = 1199
[63721.656340]  Baytrail Audio Port: sst: error code = -22
[63721.656347] bytt100_rt5640 bytt100_rt5640: BUG: , pos = -22, buffer size = 203830, period size = 1199
[63721.656581]  Baytrail Audio Port: sst: error code = -22
[63721.656589] bytt100_rt5640 bytt100_rt5640: BUG: , pos = -22, buffer size = 203830, period size = 1199
[63721.656611]  Baytrail Audio Port: sst: error code = -22
[63721.656618] bytt100_rt5640 bytt100_rt5640: BUG: , pos = -22, buffer size = 203830, period size = 1199
[63721.656635]  Baytrail Audio Port: sst: error code = -22
[63721.656642] bytt100_rt5640 bytt100_rt5640: BUG: , pos = -22, buffer size = 203830, period size = 1199
[63721.656674]  Baytrail Audio Port: sst: error code = -22
[63721.656682] bytt100_rt5640 bytt100_rt5640: BUG: , pos = -22, buffer size = 203830, period size = 1199
[63721.656771]  Baytrail Audio Port: sst: error code = -22
[63721.656779] bytt100_rt5640 bytt100_rt5640: BUG: , pos = -22, buffer size = 203830, period size = 1199
[63721.656797]  Baytrail Audio Port: sst: error code = -22
[63721.656804] bytt100_rt5640 bytt100_rt5640: BUG: , pos = -22, buffer size = 203830, period size = 1199
[63721.657829]  Baytrail Audio Port: sst: error code = -22
[63721.657841] bytt100_rt5640 bytt100_rt5640: BUG: , pos = -22, buffer size = 203830, period size = 1199
[63721.657869]  Baytrail Audio Port: sst: error code = -22
[63721.657930]  Baytrail Audio Port: sst: error code = -22
[63721.657952]  Baytrail Audio Port: sst: error code = -22
[63721.658112]  Baytrail Audio Port: sst: error code = -22
[63721.658134]  Baytrail Audio Port: sst: error code = -22
[63721.658191]  Baytrail Audio Port: sst: error code = -22
[63721.658204]  Baytrail Audio Port: sst: error code = -22
[63721.658378]  Baytrail Audio Port: sst: error code = -22
[63721.658398]  Baytrail Audio Port: sst: error code = -22
[63721.658493]  Baytrail Audio Port: sst: error code = -22
[63721.658508]  Baytrail Audio Port: sst: error code = -22
[63721.658570]  Baytrail Audio Port: sst: error code = -22
[63721.658583]  Baytrail Audio Port: sst: error code = -22
[63721.663963]  Baytrail Audio Port: sst: error code = -22
[63721.663994]  Baytrail Audio Port: sst: error code = -22
[63721.664040]  Baytrail Audio Port: sst: error code = -22
[63721.664062]  Baytrail Audio Port: sst: error code = -22
[63721.672666]  Baytrail Audio Port: sst: error code = -22
[63721.672696]  Baytrail Audio Port: sst: error code = -22
[63721.672711]  Baytrail Audio Port: sst: error code = -22
[63721.672747]  Baytrail Audio Port: sst: error code = -22
[63721.672762]  Baytrail Audio Port: sst: error code = -22
[63721.672799]  Baytrail Audio Port: sst: error code = -22
[63721.672817]  Baytrail Audio Port: sst: error code = -22
[63721.672826]  Baytrail Audio Port: sst: error code = -22
[63721.672845]  Baytrail Audio Port: sst: error code = -22
[63721.674200]  Baytrail Audio Port: sst: error code = -22
[63721.674221]  Baytrail Audio Port: sst: error code = -22
[63721.675333]  Baytrail Audio Port: sst: error code = -22
[63721.675368]  Baytrail Audio Port: sst: error code = -22
[63721.675432]  Baytrail Audio Port: sst: error code = -22
[63721.675456]  Baytrail Audio Port: sst: error code = -22
[63721.675643]  Baytrail Audio Port: sst: error code = -22
[63721.675657]  Baytrail Audio Port: sst: error code = -22
[63721.675707]  Baytrail Audio Port: sst: error code = -22
[63721.675719]  Baytrail Audio Port: sst: error code = -22
[63721.675822]  Baytrail Audio Port: sst: error code = -22
[63721.675840]  Baytrail Audio Port: sst: error code = -22
[63742.035348]  Baytrail Audio Port: sst: error code = -22
[63742.035359] snd_pcm_update_hw_ptr0: 38 callbacks suppressed
[63742.035367] bytt100_rt5640 bytt100_rt5640: BUG: , pos = -22, buffer size = 203830, period size = 1199
[63742.035455]  Baytrail Audio Port: sst: error code = -22
[63742.035462] bytt100_rt5640 bytt100_rt5640: BUG: , pos = -22, buffer size = 203830, period size = 1199
[63742.035469]  Baytrail Audio Port: sst: error code = -22
[63742.035474] bytt100_rt5640 bytt100_rt5640: BUG: , pos = -22, buffer size = 203830, period size = 1199
[63742.035488]  Baytrail Audio Port: sst: error code = -22
[63742.035494] bytt100_rt5640 bytt100_rt5640: BUG: , pos = -22, buffer size = 203830, period size = 1199
[63742.035728]  Baytrail Audio Port: sst: error code = -22
[63742.035739] bytt100_rt5640 bytt100_rt5640: BUG: , pos = -22, buffer size = 203830, period size = 1199
[63742.035754]  Baytrail Audio Port: sst: error code = -22
[63742.035759] bytt100_rt5640 bytt100_rt5640: BUG: , pos = -22, buffer size = 203830, period size = 1199
[63742.035873]  Baytrail Audio Port: sst: error code = -22
[63742.035882] bytt100_rt5640 bytt100_rt5640: BUG: , pos = -22, buffer size = 203830, period size = 1199
[63742.035894]  Baytrail Audio Port: sst: error code = -22
[63742.035900] bytt100_rt5640 bytt100_rt5640: BUG: , pos = -22, buffer size = 203830, period size = 1199
[63742.036812]  Baytrail Audio Port: sst: error code = -22
[63742.036825] bytt100_rt5640 bytt100_rt5640: BUG: , pos = -22, buffer size = 203830, period size = 1199
[63742.036843]  Baytrail Audio Port: sst: error code = -22
[63742.036849] bytt100_rt5640 bytt100_rt5640: BUG: , pos = -22, buffer size = 203830, period size = 1199
[63742.037341]  Baytrail Audio Port: sst: error code = -22
[63742.037368]  Baytrail Audio Port: sst: error code = -22
[63742.037711]  Baytrail Audio Port: sst: error code = -22
[63742.037729]  Baytrail Audio Port: sst: error code = -22
[63742.037790]  Baytrail Audio Port: sst: error code = -22
[63742.037802]  Baytrail Audio Port: sst: error code = -22
[63742.039975]  Baytrail Audio Port: sst: error code = -22
[63742.040000]  Baytrail Audio Port: sst: error code = -22
[63742.040079]  Baytrail Audio Port: sst: error code = -22
[63742.040093]  Baytrail Audio Port: sst: error code = -22
[63744.061152]  Baytrail Audio Port: sst: error code = -22
[63744.061163] snd_pcm_update_hw_ptr0: 10 callbacks suppressed
[63744.061170] bytt100_rt5640 bytt100_rt5640: BUG: , pos = -22, buffer size = 203830, period size = 1199
[63744.061189]  Baytrail Audio Port: sst_platform_pcm_trigger called
[63744.061193]  Baytrail Audio Port: sst: in stop
[63744.061199]  SSP2-Codec: sst_platform_pcm_trigger called
[63744.061329] sst-mfld-platform sst-mfld-platform: Enter: enable=0 port_name=ssp2-port
[63744.061335] sst-mfld-platform sst-mfld-platform: ssp_id: 3
[63744.061341] writing to lpe: 00000000: 01 01 01 01 00 00 1a 00 ff ff ff ff 75 00 12 00  ............u...
[63744.061345] writing to lpe: 00000010: 03 00 00 00 18 09 0f ff 0f ff 03 00 01 01 01 00  ................
[63744.061348] writing to lpe: 00000020: 00 00                                            ..
[63744.419622] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[63744.419632] intel_sst_acpi 80860F28:00: fw returned err -16
[63744.419641] sst-mfld-platform sst-mfld-platform: enable=0, usage=1
[63744.419647] writing to lpe: 00000000: 01 01 01 01 00 00 08 00 ff ff ff ff 0e 00 00 00  ................
[63744.761892] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[63744.761902] intel_sst_acpi 80860F28:00: fw returned err -16
[63744.761921] sst-mfld-platform sst-mfld-platform: enter, dai-name=media-cpu-dai dir=0
[63744.761927] sst-mfld-platform sst-mfld-platform: Stream name=Headset Playback
[63744.761934] intel_sst_acpi 80860F28:00: free stream returned err -19

--------------010705040709030506000100
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------010705040709030506000100--
