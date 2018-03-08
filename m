From: Kai Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH v2 3/3] ALSA: hda: Disabled unused audio
 controller for Dell platforms with Switchable Graphics
Date: Thu, 8 Mar 2018 18:38:45 +0800
Message-ID: <1A1B9259-DC5B-4C1A-96BD-7FCACDBFFBB3@canonical.com>
References: <20180308091023.9061-1-kai.heng.feng@canonical.com>
 <20180308091023.9061-3-kai.heng.feng@canonical.com>
 <20180308093848.GA24068@wunner.de>
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.15\))
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="yes"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id DE6622674D2
 for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2018 11:38:52 +0100 (CET)
Received: from mail-pl0-f72.google.com ([209.85.160.72])
 by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.76) (envelope-from <kai.heng.feng@canonical.com>)
 id 1etswm-0000Gc-4B
 for alsa-devel@alsa-project.org; Thu, 08 Mar 2018 10:38:52 +0000
Received: by mail-pl0-f72.google.com with SMTP id az5-v6so2667406plb.14
 for <alsa-devel@alsa-project.org>; Thu, 08 Mar 2018 02:38:52 -0800 (PST)
In-Reply-To: <20180308093848.GA24068@wunner.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lukas Wunner <lukas@wunner.de>
Cc: mjg59@srcf.ucam.org, alsa-devel@alsa-project.org, Mario Limonciello <mario.limonciello@dell.com>, tiwai@suse.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, pali.rohar@gmail.com, dvhart@infradead.org, platform-driver-x86@vger.kernel.org, andy@infradead.org
List-Id: alsa-devel@alsa-project.org



> On Mar 8, 2018, at 5:38 PM, Lukas Wunner <lukas@wunner.de> wrote:
>
> On Thu, Mar 08, 2018 at 05:10:23PM +0800, Kai-Heng Feng wrote:
>> Some Dell platforms (Preicsion 7510/7710/7520/7720) have a BIOS option
>> "Switchable Graphics" (SG).
>>
>> When SG is enabled, we have:
>> 00:02.0 VGA compatible controller: Intel Corporation Device 591b (rev 04)
>> 00:1f.3 Audio device: Intel Corporation CM238 HD Audio Controller (rev 31)
>> 01:00.0 VGA compatible controller: Advanced Micro Devices, Inc.   
>> [AMD/ATI] Ellesmere [Polaris10]
>> 01:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Ellesmere  
>> [Radeon RX 580]
>>
>> The Intel Audio outputs all the sound, including HDMI audio. The audio
>> controller comes with AMD graphics doesn't get used.
>>
>> When SG is disabled, we have:
>> 00:1f.3 Audio device: Intel Corporation CM238 HD Audio Controller (rev 31)
>> 01:00.0 VGA compatible controller: Advanced Micro Devices, Inc.   
>> [AMD/ATI] Ellesmere [Polaris10]
>> 01:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Ellesmere  
>> [Radeon RX 580]
>>
>> Now it's a typical discrete-only system. HDMI audio comes from AMD audio
>> controller, others from Intel audio controller.
>>
>> When SG is enabled, the unused AMD audio controller still exposes its
>> sysfs, so userspace still opens the control file and stream. If
>> userspace tries to output sound through the stream, it hangs when
>> runtime suspend kicks in:
>> [ 12.796265] snd_hda_intel 0000:01:00.1: Disabling via vga_switcheroo
>> [ 12.796367] snd_hda_intel 0000:01:00.1: Cannot lock devices!
>
> This should be fixed by the following series:
> https://lists.freedesktop.org/archives/dri-devel/2018-March/168012.html
>
> Please verify that by testing the series on the machine in question.
> I'm hoping to get those patches in for 4.17.  I suspect that your
> patch may not be necessary then.

I no longer see the warning message with your patch. Thanks!

>
>
>> Since the discrete audio controller isn't useful when SG enabled, we
>> should just disable the device.
>
> I don't quite follow, when SG is enabled but hda_intel doesn't bind
> to the AMD audio device, how are you going to stream audio to
> external displays?  Are external DP/HDMI ports muxed to the integrated
> GPU when SG is enabled?

Yes. It's a muxed port.
The can directly output via integrated Intel GPU when SG is enabled.
The discrete audio controller never gets used when SG is enabled.

The unused discrete audio controller still gets opened by userspace:
# lsof /dev/snd/controlC1
COMMAND    PID USER   FD   TYPE DEVICE SIZE/OFF  NODE NAME
pulseaudi  965  gdm   18u   CHR  116,2      0t0 17913 /dev/snd/controlC1
pulseaudi 1423    u   17u   CHR  116,2      0t0 17913 /dev/snd/controlC1
pulseaudi 1423    u   24u   CHR  116,2      0t0 17913 /dev/snd/controlC1

Also pcms:
# ls /dev/snd/pcmC1*
/dev/snd/pcmC1D10p  /dev/snd/pcmC1D11p  /dev/snd/pcmC1D3p   
/dev/snd/pcmC1D7p  /dev/snd/pcmC1D8p  /dev/snd/pcmC1D9p

So I think my patch is still needed.

>
> Thanks,
>
> Lukas
>
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> v2: Mario suggested to squash the HDA part into the same series.
>>
>>  sound/pci/hda/hda_intel.c | 35 +++++++++++++++++++++++++++++++++++
>>  1 file changed, 35 insertions(+)
>>
>> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
>> index 96143df19b21..8e3e8b88624a 100644
>> --- a/sound/pci/hda/hda_intel.c
>> +++ b/sound/pci/hda/hda_intel.c
>> @@ -49,6 +49,7 @@
>>  #include <linux/clocksource.h>
>>  #include <linux/time.h>
>>  #include <linux/completion.h>
>> +#include <linux/dell-common.h>
>>
>>  #ifdef CONFIG_X86
>>  /* for snoop control */
>> @@ -1620,6 +1621,35 @@ static void check_msi(struct azx *chip)
>>  	}
>>  }
>>
>> +#if IS_ENABLED(CONFIG_DELL_LAPTOP)
>> +static bool check_dell_switchable_gfx(struct pci_dev *pdev)
>> +{
>> +	static int (*dell_switchable_gfx_enabled_func)(bool *);
>> +	bool enabled;
>> +	int err;
>> +
>> +	if (pdev->vendor != PCI_VENDOR_ID_ATI ||
>> +	    pdev->subsystem_vendor != PCI_VENDOR_ID_DELL)
>> +		return false;
>> +
>> +	dell_switchable_gfx_enabled_func =
>> +		symbol_request(dell_switchable_gfx_enabled);
>> +	if (!dell_switchable_gfx_enabled_func)
>> +		return false;
>> +
>> +	err = dell_switchable_gfx_enabled_func(&enabled);
>> +
>> +	symbol_put(dell_switchable_gfx_enabled);
>> +
>> +	return !err ? enabled : false;
>> +}
>> +#else
>> +static bool check_dell_switchable_gfx(struct pci_dev *pdev)
>> +{
>> +	return false;
>> +}
>> +#endif
>> +
>>  /* check the snoop mode availability */
>>  static void azx_check_snoop_available(struct azx *chip)
>>  {
>> @@ -1702,6 +1732,11 @@ static int azx_create(struct snd_card *card,  
>> struct pci_dev *pci,
>>  	if (err < 0)
>>  		return err;
>>
>> +	if (check_dell_switchable_gfx(pci)) {
>> +		pci_disable_device(pci);
>> +		return -ENODEV;
>> +	}
>> +
>>  	hda = kzalloc(sizeof(*hda), GFP_KERNEL);
>>  	if (!hda) {
>>  		pci_disable_device(pci);
>> -- 
>> 2.15.1
>>
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
