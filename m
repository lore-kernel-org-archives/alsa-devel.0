From: Hui Wang <hui.wang@canonical.com>
Subject: Re: [alsa-devel] [V2 PATCH] ALSA: hda - Enable mute/mic-mute LEDs
 for more Thinkpads with Conexant codec
Date: Wed, 24 Jun 2015 16:46:56 +0800
Message-ID: <558A6E80.7010003@canonical.com>
References: <1385534846-20829-1-git-send-email-hui.wang@canonical.com>	<53AFF992.5030403@web.de>	<53B0C596.6090007@canonical.com>	<53B1078B.4090101@web.de>	<53B219DF.6090807@canonical.com>	<53B26575.1000003@web.de>	<53B27ED7.4070401@canonical.com>	<53B50062.30200@web.de>	<53B51B63.8060809@canonical.com>	<53B51CF3.8090102@web.de>	<53B52146.9050300@canonical.com>	<55603F22.8070103@web.de> <CAN8cciZYZ4setSj7dgPqQUVrBrr98tSvofLrD_0zvyQqkWfd2Q@mail.gmail.com> <5560A93E.7060607@web.de> <558A4216.8010401@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <558A4216.8010401@web.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@web.de>, Raymond Yau <superquad.vortex2@gmail.com>, alex.hung@canonical.com, Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Hui Wang <jason77.wang@gmail.com>, tiwai@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, yk@canonical.com, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

On 06/24/2015 01:37 PM, Jan Kiszka wrote:
> On 2015-05-23 18:22, Jan Kiszka wrote:
>> On 2015-05-23 18:06, Raymond Yau wrote:
>>> 2015-5-23 =E4=B8=8B=E5=8D=884:50 =E6=96=BC "Jan Kiszka" <jan.kiszka=
@web.de> =E5=AF=AB=E9=81=93=EF=BC=9A
>>>>>>>>>>>>>>> Most Thinkpad Edge series laptops use conexant codec, s=
o far
>>>>>>>>>>>>>>> although
>>>>>>>>> <snip>
>>>>>>>>>>>> Is there anything I can debug or any information I can col=
lect
>>>>>>>>>>>> from my
>>>>>>>>>>>> box to examine this?
>>>>>>>>>>> What is the linux distribution on your machine? And use sho=
wkey to
>>>>>>>>>>> catch
>>>>>>>>>>> the keycode of that button.
>>>>>>>>>> I'm running OpenSUSE 13.1. The reported keycode of the power
>>>>>>>>>> button is
>>>>>>>>>> 116.
>>>>>>>>> It seems the keycode is correct, it is power keycode rather t=
he mute
>>>>>>>>> keycode.
>>>>>>>>>
>>>>>>>>> Could you please do some debug, let us find which line of cod=
e is
>>> the
>>>>>>>>> root cause for this problem. for example:
>>>>>>>>>
>>>>>>>>> after running the line, the problem shows up:
>>>>>>>>>
>>>>>>>>> 1.     if (ACPI_SUCCESS(acpi_get_devices("LEN0068", acpi_chec=
k_cb,
>>>>>>>>> &found, NULL)) && found) // in the sound/pci/hda/thinkpad_hel=
per.c,
>>>>>>>>> is_thinkpad()
>>>>>>>> This evaluates to true
>>>>>>>>
>>>>>>>>> 2.     return ACPI_SUCCESS(acpi_get_devices("IBM0068",
>>> acpi_check_cb,
>>>>>>>>> &found, NULL)) && found; // same as above
>>>>>>>>>
>>>>>>>>> 3.         if (led_set_func(TPACPI_LED_MUTE, false) >=3D 0) {=
 //in the
>>>>>>>>> sound/pci/hda/thinkpad_helper.c, hda_fixup_thinkpad_acpi()
>>>>>>>> ...and this
>>>>>>>>
>>>>>>>>> 4. if (led_set_func(TPACPI_LED_MICMUTE, false) >=3D 0) { // s=
ame as
>>>>>>>>> above
>>>>>>>>>
>>>>>>>> ...and this as well. spec->num_adc_nids is 1.
>>>>>>> If we change the code like below, does the power button can wor=
k well?
>>>>>>>
>>>>>>> in the thinkpad_helper.c, hda_fixup_thinkpad_acpi()
>>>>>>>
>>>>>>>
>>>>>>>           if (led_set_func(TPACPI_LED_MUTE, false) >=3D 0) {
>>>>>>>               /*
>>>>>>>               old_vmaster_hook =3D spec->vmaster_mute.hook;
>>>>>>>               spec->vmaster_mute.hook =3D update_tpacpi_mute_le=
d;
>>>>>>>               removefunc =3D false;
>>>>>>>              */
>>>>>> Disabling only this block resolves the issue.
>>>>> So Below two lines make the power button change to the reset butt=
on.
>>>>>
>>>>> drivers/platform/x86/thinkpad_acpi.c  mute_led_on_off():
>>>>>
>>>>> acpi_get_handle(hkey_handle, "SSMS", &temp);
>>>>> acpi_evalf(hkey_handle, &output, "SSMS", "dd", 1);
>>>>>
>>>>>
>>>>> @alexhung,
>>>>> Do you have any idea why this can affect the power button behavio=
r?
>>>>>
>>>> I think we all lost track of this issue, but it unfortunately stil=
l
>>>> exists in the latest kernel, requiring custom builds here. How can=
 we
>>>> proceed?
>>> http://mailman.alsa-project.org/pipermail/alsa-devel/2015-May/09156=
1.html
>>>
>>> If you cannot find "SSMS" in  your T520 ACPI dump, this mean mute L=
ED
>>> cannot be turn on/off similar to T510
>> There is an entry (see attached disassembly), but this device has at
>> least no physical LED to drive.
Some hotkey leds are embedded on button.  Through the pictures I found=20
on the internet (thinkpad t520), it looks like there is a led at the=20
center of the mute button.


Jan

> Ping...
>
> Jan
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
