From: Hui Wang <hui.wang@canonical.com>
Subject: Re: [V2 PATCH] ALSA: hda - Enable mute/mic-mute LEDs for more Thinkpads
 with Conexant codec
Date: Thu, 03 Jul 2014 16:59:15 +0800
Message-ID: <53B51B63.8060809@canonical.com>
References: <1385534846-20829-1-git-send-email-hui.wang@canonical.com> <53AFF992.5030403@web.de> <53B0C596.6090007@canonical.com> <53B1078B.4090101@web.de> <53B219DF.6090807@canonical.com> <53B26575.1000003@web.de> <53B27ED7.4070401@canonical.com> <53B50062.30200@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <53B50062.30200@web.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Hui Wang <jason77.wang@gmail.com>, tiwai@suse.de, alsa-devel@alsa-project.org, alex.hung@canonical.com, yk@canonical.com, david.henningsson@canonical.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 07/03/2014 03:04 PM, Jan Kiszka wrote:
> On 2014-07-01 11:26, Hui Wang wrote:
>> On 07/01/2014 03:38 PM, Jan Kiszka wrote:
>>> On 2014-07-01 04:15, Hui Wang wrote:
>>>> On 06/30/2014 02:45 PM, Jan Kiszka wrote:
>>>>> On 2014-06-30 04:04, Hui Wang wrote:
>>>>>> On 06/29/2014 07:33 PM, Jan Kiszka wrote:
>>>>>>> On 2013-11-27 07:47, Hui Wang wrote:
>>>>>>>> Most Thinkpad Edge series laptops use conexant codec, so far
>>>>>>>> although
>> <snip>
>>>>> Is there anything I can debug or any information I can collect from my
>>>>> box to examine this?
>>>> What is the linux distribution on your machine? And use showkey to catch
>>>> the keycode of that button.
>>> I'm running OpenSUSE 13.1. The reported keycode of the power button is
>>> 116.
>> It seems the keycode is correct, it is power keycode rather the mute
>> keycode.
>>
>> Could you please do some debug, let us find which line of code is the
>> root cause for this problem. for example:
>>
>> after running the line, the problem shows up:
>>
>> 1.     if (ACPI_SUCCESS(acpi_get_devices("LEN0068", acpi_check_cb,
>> &found, NULL)) && found) // in the sound/pci/hda/thinkpad_helper.c,
>> is_thinkpad()
> This evaluates to true
>
>> 2.     return ACPI_SUCCESS(acpi_get_devices("IBM0068", acpi_check_cb,
>> &found, NULL)) && found; // same as above
>>
>> 3.         if (led_set_func(TPACPI_LED_MUTE, false) >= 0) { //in the
>> sound/pci/hda/thinkpad_helper.c, hda_fixup_thinkpad_acpi()
> ...and this
>
>> 4. if (led_set_func(TPACPI_LED_MICMUTE, false) >= 0) { // same as above
>>
> ...and this as well. spec->num_adc_nids is 1.


If we change the code like below, does the power button can work well?

in the thinkpad_helper.c, hda_fixup_thinkpad_acpi()


         if (led_set_func(TPACPI_LED_MUTE, false) >= 0) {
             /*
             old_vmaster_hook = spec->vmaster_mute.hook;
             spec->vmaster_mute.hook = update_tpacpi_mute_led;
             removefunc = false;
            */
         }
         if (led_set_func(TPACPI_LED_MICMUTE, false) >= 0) {
           /*
             if (spec->num_adc_nids > 1)
                 codec_dbg(codec,
                       "Skipping micmute LED control due to several ADCs");
             else {
                 spec->cap_sync_hook = update_tpacpi_micmute_led;
                 removefunc = false;
             }
           */
         }


If power button can work well, please uncomment one section of the code 
to find which section code introduce this problem.

Regards,
Hui.
>
> Jan
>
>
