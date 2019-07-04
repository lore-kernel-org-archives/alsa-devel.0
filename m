From: Hui Wang <hui.wang@canonical.com>
Subject: Re: audio lost from speaker after reboot from windows on the device
 ALC295
Date: Fri, 5 Jul 2019 07:27:00 +0800
Message-ID: <c37fa9bd-071c-6c10-55a6-933a4937fa87@canonical.com>
References: <CD6925E8781EFD4D8E11882D20FC406D52AB58B6@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CD6925E8781EFD4D8E11882D20FC406D52AB58B6@SHSMSX104.ccr.corp.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "He, Bo" <bo.he@intel.com>, "kailang@realtek.com" <kailang@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>, "jian-hong@endlessm.com" <jian-hong@endlessm.com>, "drake@endlessm.com" <drake@endlessm.com>, "chiu@endlessm.com" <chiu@endlessm.com>
List-Id: alsa-devel@alsa-project.org

Maybe your machine has an external amplifier which needs to be set by 
software before it can work.

On 2019/7/4 下午8:02, He, Bo wrote:
> Hi, patch_realtek.c maintainer:
> 	I see one issue that reboot from windows and boot to ubuntu, the audio lost from speaker, I suspect there are some bugs in patch_realtek.c drivers,  the device is ALC295 and the device id is 0x10ec0295.
>
> I have done the below experiments:
> 1. reboot from windows to windows, the audio is persist .
> 2. reboot from windows to ubuntu, the audio lost from speaker, but can hear if I hotplug one earphone.
> 3. if the issue reproduce after reboot from windows, reboot the ubuntu can't restore the audio, I suspect it's warm reset.
> 4. if I write the port 0xcf9 with 0xe to do cold reset, the audio can restore.
> 5. if I do suspend/resume, the audio can restore, I suspect do cold boot and suspend will trigger the platform reset to reset the ALC295.
> 6. if I do double function reset (write the verb 0x7ff in alc_init), the audio is still can't restore.
> snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_CODEC_RESET, 0); /* Function reset */
> snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_CODEC_RESET, 0); /* double Function reset */
> 7. the issue is first found on kernel 4.19.50, I still see the issue with the latest kernel 5.2-rc2, is it possible windows change some default registers, but ALC295 don't initialize the register?
>
