From: Jan Kiszka <jan.kiszka@web.de>
Subject: Re: [V2 PATCH] ALSA: hda - Enable mute/mic-mute LEDs for more Thinkpads
 with Conexant codec
Date: Thu, 03 Jul 2014 09:04:02 +0200
Message-ID: <53B50062.30200@web.de>
References: <1385534846-20829-1-git-send-email-hui.wang@canonical.com> <53AFF992.5030403@web.de> <53B0C596.6090007@canonical.com> <53B1078B.4090101@web.de> <53B219DF.6090807@canonical.com> <53B26575.1000003@web.de> <53B27ED7.4070401@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="wIRoUibvDoE2B02u7dbWPTjdw07uiX4bj"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <53B27ED7.4070401@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hui Wang <hui.wang@canonical.com>
Cc: Hui Wang <jason77.wang@gmail.com>, tiwai@suse.de, alsa-devel@alsa-project.org, alex.hung@canonical.com, yk@canonical.com, david.henningsson@canonical.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wIRoUibvDoE2B02u7dbWPTjdw07uiX4bj
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2014-07-01 11:26, Hui Wang wrote:
> On 07/01/2014 03:38 PM, Jan Kiszka wrote:
>> On 2014-07-01 04:15, Hui Wang wrote:
>>> On 06/30/2014 02:45 PM, Jan Kiszka wrote:
>>>> On 2014-06-30 04:04, Hui Wang wrote:
>>>>> On 06/29/2014 07:33 PM, Jan Kiszka wrote:
>>>>>> On 2013-11-27 07:47, Hui Wang wrote:
>>>>>>> Most Thinkpad Edge series laptops use conexant codec, so far
>>>>>>> although
> <snip>
>>>>>>>
>>>> Is there anything I can debug or any information I can collect from =
my
>>>> box to examine this?
>>> What is the linux distribution on your machine? And use showkey to ca=
tch
>>> the keycode of that button.
>> I'm running OpenSUSE 13.1. The reported keycode of the power button is=

>> 116.
> It seems the keycode is correct, it is power keycode rather the mute
> keycode.
>=20
> Could you please do some debug, let us find which line of code is the
> root cause for this problem. for example:
>=20
> after running the line, the problem shows up:
>=20
> 1.     if (ACPI_SUCCESS(acpi_get_devices("LEN0068", acpi_check_cb,
> &found, NULL)) && found) // in the sound/pci/hda/thinkpad_helper.c,
> is_thinkpad()

This evaluates to true

>=20
> 2.     return ACPI_SUCCESS(acpi_get_devices("IBM0068", acpi_check_cb,
> &found, NULL)) && found; // same as above
>=20
> 3.         if (led_set_func(TPACPI_LED_MUTE, false) >=3D 0) { //in the
> sound/pci/hda/thinkpad_helper.c, hda_fixup_thinkpad_acpi()

=2E..and this

>=20
> 4. if (led_set_func(TPACPI_LED_MICMUTE, false) >=3D 0) { // same as abo=
ve
>=20

=2E..and this as well. spec->num_adc_nids is 1.

Jan



--wIRoUibvDoE2B02u7dbWPTjdw07uiX4bj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlO1AGIACgkQitSsb3rl5xQCvQCgyHPB2f7hTX5X9OPbMhnudaBz
6iUAniHhhGy+m9CM12QO7+ROVDKvfF2W
=mx87
-----END PGP SIGNATURE-----

--wIRoUibvDoE2B02u7dbWPTjdw07uiX4bj--
