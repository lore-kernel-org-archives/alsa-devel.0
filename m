From: shuah <shuah@kernel.org>
Subject: Re: [PATCH v9 0/4] Media Device Allocator API
Date: Wed, 23 Jan 2019 18:35:20 -0700
Message-ID: <2ebe7776-d24d-79d5-bd38-efba4221b7c2@kernel.org>
References: <cover.1545154777.git.shuah@kernel.org>
 <606f731d-11f9-e2d7-aee4-b20abadc4d41@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <606f731d-11f9-e2d7-aee4-b20abadc4d41@xs4all.nl>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Hans Verkuil <hverkuil@xs4all.nl>, mchehab@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, shuah <shuah@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 1/21/19 7:46 AM, Hans Verkuil wrote:
> Hi Shuah,
> 
> On 12/18/2018 06:59 PM, shuah@kernel.org wrote:
>> From: Shuah Khan <shuah@kernel.org>
>>
>> Media Device Allocator API to allows multiple drivers share a media device.
>> This API solves a very common use-case for media devices where one physical
>> device (an USB stick) provides both audio and video. When such media device
>> exposes a standard USB Audio class, a proprietary Video class, two or more
>> independent drivers will share a single physical USB bridge. In such cases,
>> it is necessary to coordinate access to the shared resource.
>>
>> Using this API, drivers can allocate a media device with the shared struct
>> device as the key. Once the media device is allocated by a driver, other
>> drivers can get a reference to it. The media device is released when all
>> the references are released.
>>
>> - Tested sharing resources with kaffeine, vlc, xawtv, tvtime, and
>>    arecord. When analog is streaming, digital and audio user-space
>>    applications detect that the tuner is busy and exit. When digital
>>    is streaming, analog and audio applications detect that the tuner is
>>    busy and exit. When arecord is owns the tuner, digital and analog
>>    detect that the tuner is busy and exit.
>> - Tested media device allocator API with bind/unbind testing on
>>    snd-usb-audio and au0828 drivers to make sure /dev/mediaX is released
>>    only when the last driver is unbound.
>> - This patch series is tested on 4.20-rc6
>> - Addressed review comments from Hans on the RFC v8 (rebased on 4.19)
>> - Updated change log to describe the use-case more clearly.
>> - No changes to 0001,0002 code since the v7 referenced below.
>> - 0003 is a new patch to enable ALSA defines that have been
>>    disabled for kernel between 4.9 and 4.19.
>> - Minor merge conflict resolution in 0004.
>> - Added SPDX to new files.
>>
>> References:
>> https://lkml.org/lkml/2018/11/2/169
>> https://www.mail-archive.com/linux-media@vger.kernel.org/msg105854.html
> 
> When I connect my au0828 to my laptop with your v9 patch series applied I get
> these warnings:
> 
> [   45.416047] xhci_hcd 0000:39:00.0: xHCI Host Controller
> [   45.417882] xhci_hcd 0000:39:00.0: new USB bus registered, assigned bus number 3
> [   45.419292] xhci_hcd 0000:39:00.0: hcc params 0x200077c1 hci version 0x110 quirks 0x0000000200009810
> [   45.420835] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.00
> [   45.420893] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [   45.420899] usb usb3: Product: xHCI Host Controller
> [   45.420905] usb usb3: Manufacturer: Linux 5.0.0-rc1-zen xhci-hcd
> [   45.420911] usb usb3: SerialNumber: 0000:39:00.0
> [   45.424290] hub 3-0:1.0: USB hub found
> [   45.425274] hub 3-0:1.0: 2 ports detected
> [   45.431061] xhci_hcd 0000:39:00.0: xHCI Host Controller
> [   45.432436] xhci_hcd 0000:39:00.0: new USB bus registered, assigned bus number 4
> [   45.432448] xhci_hcd 0000:39:00.0: Host supports USB 3.1 Enhanced SuperSpeed
> [   45.433299] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.00
> [   45.433354] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [   45.433360] usb usb4: Product: xHCI Host Controller
> [   45.433365] usb usb4: Manufacturer: Linux 5.0.0-rc1-zen xhci-hcd
> [   45.433370] usb usb4: SerialNumber: 0000:39:00.0
> [   45.436134] hub 4-0:1.0: USB hub found
> [   45.436576] hub 4-0:1.0: 2 ports detected
> [   45.750940] usb 3-1: new high-speed USB device number 2 using xhci_hcd
> [   45.899927] usb 3-1: New USB device found, idVendor=2040, idProduct=721e, bcdDevice= 0.05
> [   45.899949] usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=10
> [   45.899960] usb 3-1: Product: WinTV Aero-A
> [   45.899970] usb 3-1: Manufacturer: Hauppauge
> [   45.899979] usb 3-1: SerialNumber: 4033622430
> [   46.053476] au0828: au0828 driver loaded
> [   46.053726] WARNING: CPU: 1 PID: 1824 at kernel/module.c:262 module_assert_mutex+0x20/0x30
> [   46.053818] Modules linked in: au0828(+) tveeprom dvb_core v4l2_common rfcomm bnep snd_hda_codec_hdmi snd_hda_codec_realtek
> snd_hda_codec_generic uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_common videodev media btusb btintel bluetooth
> snd_soc_skl snd_soc_skl_ipc snd_soc_sst_ipc snd_soc_sst_dsp snd_soc_acpi_intel_match snd_soc_acpi snd_hda_ext_core x86_pkg_temp_thermal
> snd_soc_core snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel iwlmvm snd_hda_codec snd_hda_core snd_hwdep snd_pcm snd_timer snd iwlwifi
> i915 intel_gtt battery ac pcc_cpufreq thermal
> [   46.053853] CPU: 1 PID: 1824 Comm: systemd-udevd Not tainted 5.0.0-rc1-zen #85
> [   46.053856] Hardware name: ASUSTeK COMPUTER INC. UX490UA/UX490UA, BIOS UX490UA.312 04/09/2018
> [   46.053862] RIP: 0010:module_assert_mutex+0x20/0x30
> [   46.053867] Code: 5d c3 e8 f3 68 f5 ff 0f 1f 00 8b 05 d2 5a 7c 01 85 c0 75 01 c3 be ff ff ff ff 48 c7 c7 80 bc 86 82 e8 e4 27 fb ff 85 c0
> 75 ea <0f> 0b c3 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 53 48 89 fb e8 c7
> [   46.053871] RSP: 0018:ffffc90002aa3ac8 EFLAGS: 00010246
> [   46.053876] RAX: 0000000000000000 RBX: ffffffffa0573abf RCX: 0000000000000000
> [   46.053880] RDX: 0000000000000000 RSI: ffffffff8286bc80 RDI: ffff8882a517d570
> [   46.053883] RBP: ffff8882880e6000 R08: 0000000000000000 R09: ffff8882b1f5d000
> [   46.053886] R10: 0000000000000001 R11: 0000000000000003 R12: ffffffffa0573abf
> [   46.053890] R13: ffff8882880e60a0 R14: ffff8882880e6000 R15: ffffffffa0577200
> [   46.053894] FS:  00007f0ac7d318c0(0000) GS:ffff8882b6a80000(0000) knlGS:0000000000000000
> [   46.053898] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   46.053902] CR2: 0000560d354ed800 CR3: 00000002880f9003 CR4: 00000000003606e0
> [   46.053905] Call Trace:
> [   46.053910]  find_module+0x9/0x20
> 
> My .config is available upon request.
> 

Thanks for the config.

Thanks for finding this. find_module() should be called with
module_mutex since 4.15. The media allocator patch was written
before that.

I didn't realize I don't have CONFIG_DEBUG_MUTEXES=y when I switched
to a new system.

I reproduced the problem and re-worked patch 1 and patch 4 in this
series. I will resend the v10 for just those two patches tomorrow.

Please let me know if you want me to send the entire series.

thanks,
-- Shuah
