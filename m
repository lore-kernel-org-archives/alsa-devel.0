From: Jan Kiszka <jan.kiszka@web.de>
Subject: Re: [V2 PATCH] ALSA: hda - Enable mute/mic-mute LEDs
 for more Thinkpads with Conexant codec
Date: Sat, 23 May 2015 10:49:38 +0200
Message-ID: <55603F22.8070103@web.de>
References: <1385534846-20829-1-git-send-email-hui.wang@canonical.com>
 <53AFF992.5030403@web.de> <53B0C596.6090007@canonical.com>
 <53B1078B.4090101@web.de> <53B219DF.6090807@canonical.com>
 <53B26575.1000003@web.de> <53B27ED7.4070401@canonical.com>
 <53B50062.30200@web.de> <53B51B63.8060809@canonical.com>
 <53B51CF3.8090102@web.de> <53B52146.9050300@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2134506629451394946=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by alsa0.perex.cz (Postfix) with ESMTP id 07878260492
 for <alsa-devel@alsa-project.org>; Sat, 23 May 2015 10:49:52 +0200 (CEST)
In-Reply-To: <53B52146.9050300@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hui Wang <hui.wang@canonical.com>, alex.hung@canonical.com
Cc: alsa-devel@alsa-project.org, Hui Wang <jason77.wang@gmail.com>, tiwai@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, yk@canonical.com, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============2134506629451394946==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="8gp8rpUK97a6usAwqansCLuQ1BG3n6Dce"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8gp8rpUK97a6usAwqansCLuQ1BG3n6Dce
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 2014-07-03 11:24, Hui Wang wrote:
> On 07/03/2014 05:05 PM, Jan Kiszka wrote:
>> On 2014-07-03 10:59, Hui Wang wrote:
>>> On 07/03/2014 03:04 PM, Jan Kiszka wrote:
>>>> On 2014-07-01 11:26, Hui Wang wrote:
>>>>> On 07/01/2014 03:38 PM, Jan Kiszka wrote:
>>>>>> On 2014-07-01 04:15, Hui Wang wrote:
>>>>>>> On 06/30/2014 02:45 PM, Jan Kiszka wrote:
>>>>>>>> On 2014-06-30 04:04, Hui Wang wrote:
>>>>>>>>> On 06/29/2014 07:33 PM, Jan Kiszka wrote:
>>>>>>>>>> On 2013-11-27 07:47, Hui Wang wrote:
>>>>>>>>>>> Most Thinkpad Edge series laptops use conexant codec, so far
>>>>>>>>>>> although
>>>>> <snip>
>>>>>>>> Is there anything I can debug or any information I can collect
>>>>>>>> from my
>>>>>>>> box to examine this?
>>>>>>> What is the linux distribution on your machine? And use showkey t=
o
>>>>>>> catch
>>>>>>> the keycode of that button.
>>>>>> I'm running OpenSUSE 13.1. The reported keycode of the power
>>>>>> button is
>>>>>> 116.
>>>>> It seems the keycode is correct, it is power keycode rather the mut=
e
>>>>> keycode.
>>>>>
>>>>> Could you please do some debug, let us find which line of code is t=
he
>>>>> root cause for this problem. for example:
>>>>>
>>>>> after running the line, the problem shows up:
>>>>>
>>>>> 1.     if (ACPI_SUCCESS(acpi_get_devices("LEN0068", acpi_check_cb,
>>>>> &found, NULL)) && found) // in the sound/pci/hda/thinkpad_helper.c,=

>>>>> is_thinkpad()
>>>> This evaluates to true
>>>>
>>>>> 2.     return ACPI_SUCCESS(acpi_get_devices("IBM0068", acpi_check_c=
b,
>>>>> &found, NULL)) && found; // same as above
>>>>>
>>>>> 3.         if (led_set_func(TPACPI_LED_MUTE, false) >=3D 0) { //in =
the
>>>>> sound/pci/hda/thinkpad_helper.c, hda_fixup_thinkpad_acpi()
>>>> ...and this
>>>>
>>>>> 4. if (led_set_func(TPACPI_LED_MICMUTE, false) >=3D 0) { // same as=

>>>>> above
>>>>>
>>>> ...and this as well. spec->num_adc_nids is 1.
>>>
>>> If we change the code like below, does the power button can work well=
?
>>>
>>> in the thinkpad_helper.c, hda_fixup_thinkpad_acpi()
>>>
>>>
>>>          if (led_set_func(TPACPI_LED_MUTE, false) >=3D 0) {
>>>              /*
>>>              old_vmaster_hook =3D spec->vmaster_mute.hook;
>>>              spec->vmaster_mute.hook =3D update_tpacpi_mute_led;
>>>              removefunc =3D false;
>>>             */
>> Disabling only this block resolves the issue.
>=20
> So Below two lines make the power button change to the reset button.
>=20
> drivers/platform/x86/thinkpad_acpi.c  mute_led_on_off():
>=20
> acpi_get_handle(hkey_handle, "SSMS", &temp);
> acpi_evalf(hkey_handle, &output, "SSMS", "dd", 1);
>=20
>=20
> @alexhung,
> Do you have any idea why this can affect the power button behavior?
>=20

I think we all lost track of this issue, but it unfortunately still
exists in the latest kernel, requiring custom builds here. How can we
proceed?

Thanks,
Jan



--8gp8rpUK97a6usAwqansCLuQ1BG3n6Dce
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVgPykACgkQitSsb3rl5xRbgwCggEYlmpSdXlaUMiivXk9cI2ID
kEkAn2OnOtYO6Zouu19U8ZACRVR7S34d
=BeBK
-----END PGP SIGNATURE-----

--8gp8rpUK97a6usAwqansCLuQ1BG3n6Dce--

--===============2134506629451394946==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2134506629451394946==--
