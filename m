From: Jan Kiszka <jan.kiszka@web.de>
Subject: Re: [alsa-devel] [V2 PATCH] ALSA: hda - Enable mute/mic-mute LEDs
 for more Thinkpads with Conexant codec
Date: Thu, 25 Jun 2015 13:02:44 +0200
Message-ID: <558BDFD4.9060301@web.de>
References: <1385534846-20829-1-git-send-email-hui.wang@canonical.com>	<53AFF992.5030403@web.de>	<53B0C596.6090007@canonical.com>	<53B1078B.4090101@web.de>	<53B219DF.6090807@canonical.com>	<53B26575.1000003@web.de>	<53B27ED7.4070401@canonical.com>	<53B50062.30200@web.de>	<53B51B63.8060809@canonical.com>	<53B51CF3.8090102@web.de>	<53B52146.9050300@canonical.com>	<55603F22.8070103@web.de> <CAN8cciZYZ4setSj7dgPqQUVrBrr98tSvofLrD_0zvyQqkWfd2Q@mail.gmail.com> <5560A93E.7060607@web.de> <558A4216.8010401@web.de> <558A6E80.7010003@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="xQXeMThDWE7q28gpoIgwVUJrQ22x1XJDA"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <558A6E80.7010003@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hui Wang <hui.wang@canonical.com>, Raymond Yau <superquad.vortex2@gmail.com>, alex.hung@canonical.com, Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Hui Wang <jason77.wang@gmail.com>, tiwai@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, yk@canonical.com, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xQXeMThDWE7q28gpoIgwVUJrQ22x1XJDA
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2015-06-24 10:46, Hui Wang wrote:
> On 06/24/2015 01:37 PM, Jan Kiszka wrote:
>> On 2015-05-23 18:22, Jan Kiszka wrote:
>>> On 2015-05-23 18:06, Raymond Yau wrote:
>>>> 2015-5-23 =E4=B8=8B=E5=8D=884:50 =E6=96=BC "Jan Kiszka" <jan.kiszka@=
web.de> =E5=AF=AB=E9=81=93=EF=BC=9A
>>>>>>>>>>>>>>>> Most Thinkpad Edge series laptops use conexant codec, so=

>>>>>>>>>>>>>>>> far
>>>>>>>>>>>>>>>> although
>>>>>>>>>> <snip>
>>>>>>>>>>>>> Is there anything I can debug or any information I can coll=
ect
>>>>>>>>>>>>> from my
>>>>>>>>>>>>> box to examine this?
>>>>>>>>>>>> What is the linux distribution on your machine? And use
>>>>>>>>>>>> showkey to
>>>>>>>>>>>> catch
>>>>>>>>>>>> the keycode of that button.
>>>>>>>>>>> I'm running OpenSUSE 13.1. The reported keycode of the power
>>>>>>>>>>> button is
>>>>>>>>>>> 116.
>>>>>>>>>> It seems the keycode is correct, it is power keycode rather
>>>>>>>>>> the mute
>>>>>>>>>> keycode.
>>>>>>>>>>
>>>>>>>>>> Could you please do some debug, let us find which line of code=
 is
>>>> the
>>>>>>>>>> root cause for this problem. for example:
>>>>>>>>>>
>>>>>>>>>> after running the line, the problem shows up:
>>>>>>>>>>
>>>>>>>>>> 1.     if (ACPI_SUCCESS(acpi_get_devices("LEN0068",
>>>>>>>>>> acpi_check_cb,
>>>>>>>>>> &found, NULL)) && found) // in the
>>>>>>>>>> sound/pci/hda/thinkpad_helper.c,
>>>>>>>>>> is_thinkpad()
>>>>>>>>> This evaluates to true
>>>>>>>>>
>>>>>>>>>> 2.     return ACPI_SUCCESS(acpi_get_devices("IBM0068",
>>>> acpi_check_cb,
>>>>>>>>>> &found, NULL)) && found; // same as above
>>>>>>>>>>
>>>>>>>>>> 3.         if (led_set_func(TPACPI_LED_MUTE, false) >=3D 0) {
>>>>>>>>>> //in the
>>>>>>>>>> sound/pci/hda/thinkpad_helper.c, hda_fixup_thinkpad_acpi()
>>>>>>>>> ...and this
>>>>>>>>>
>>>>>>>>>> 4. if (led_set_func(TPACPI_LED_MICMUTE, false) >=3D 0) { // sa=
me as
>>>>>>>>>> above
>>>>>>>>>>
>>>>>>>>> ...and this as well. spec->num_adc_nids is 1.
>>>>>>>> If we change the code like below, does the power button can work=

>>>>>>>> well?
>>>>>>>>
>>>>>>>> in the thinkpad_helper.c, hda_fixup_thinkpad_acpi()
>>>>>>>>
>>>>>>>>
>>>>>>>>           if (led_set_func(TPACPI_LED_MUTE, false) >=3D 0) {
>>>>>>>>               /*
>>>>>>>>               old_vmaster_hook =3D spec->vmaster_mute.hook;
>>>>>>>>               spec->vmaster_mute.hook =3D update_tpacpi_mute_led=
;
>>>>>>>>               removefunc =3D false;
>>>>>>>>              */
>>>>>>> Disabling only this block resolves the issue.
>>>>>> So Below two lines make the power button change to the reset butto=
n.
>>>>>>
>>>>>> drivers/platform/x86/thinkpad_acpi.c  mute_led_on_off():
>>>>>>
>>>>>> acpi_get_handle(hkey_handle, "SSMS", &temp);
>>>>>> acpi_evalf(hkey_handle, &output, "SSMS", "dd", 1);
>>>>>>
>>>>>>
>>>>>> @alexhung,
>>>>>> Do you have any idea why this can affect the power button behavior=
?
>>>>>>
>>>>> I think we all lost track of this issue, but it unfortunately still=

>>>>> exists in the latest kernel, requiring custom builds here. How can =
we
>>>>> proceed?
>>>> http://mailman.alsa-project.org/pipermail/alsa-devel/2015-May/091561=
=2Ehtml
>>>>
>>>>
>>>> If you cannot find "SSMS" in  your T520 ACPI dump, this mean mute LE=
D
>>>> cannot be turn on/off similar to T510
>>> There is an entry (see attached disassembly), but this device has at
>>> least no physical LED to drive.
> Some hotkey leds are embedded on button.  Through the pictures I found
> on the internet (thinkpad t520), it looks like there is a led at the
> center of the mute button.

Again, I'm on a X121e, and that has only a single physical LED for
signaling the power state. The mute button is behind key combination of
the keyboard.

Jan



--xQXeMThDWE7q28gpoIgwVUJrQ22x1XJDA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlWL39QACgkQitSsb3rl5xTdtACg2GujAqUtrn2L//EBylZVWhU/
Y0YAn1f/3h0noj18rlhzRRNxdg07vNWC
=Bv36
-----END PGP SIGNATURE-----

--xQXeMThDWE7q28gpoIgwVUJrQ22x1XJDA--
