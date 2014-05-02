From: Joschi Brauchle <joschi.brauchle@tum.de>
Subject: Re: No sound on Thinkpad T440s in Docking Station
Date: Fri, 02 May 2014 15:59:55 +0200
Message-ID: <5363A4DB.4040404@tum.de>
References: <5360BAD0.3060808@tum.de>	<s5h61lqix9b.wl%tiwai@suse.de>	<53612D54.10302@tum.de>	<s5h7g64skkx.wl%tiwai@suse.de>	<5363544A.8040508@tum.de>
 <s5hzjj0r3ob.wl%tiwai@suse.de> <53635F17.4050202@tum.de>
 <536364EA.5030203@tum.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4749496083473698635=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from postout1.mail.lrz.de (postout1.mail.lrz.de [129.187.255.137])
 by alsa0.perex.cz (Postfix) with ESMTP id F34FD2616C9
 for <alsa-devel@alsa-project.org>; Fri,  2 May 2014 16:00:24 +0200 (CEST)
Received: from lxmhs51.srv.lrz.de (localhost [127.0.0.1])
 by postout1.mail.lrz.de (Postfix) with ESMTP id 3gKw8S5l76zyT5
 for <alsa-devel@alsa-project.org>; Fri,  2 May 2014 16:00:24 +0200 (CEST)
Received: from postout1.mail.lrz.de ([127.0.0.1])
 by lxmhs51.srv.lrz.de (lxmhs51.srv.lrz.de [127.0.0.1]) (amavisd-new,
 port 20024)
 with LMTP id jRNoBgRyEIXX for <alsa-devel@alsa-project.org>;
 Fri,  2 May 2014 16:00:24 +0200 (CEST)
Received: from [192.168.109.246] (zzz-dyn-pat-199.lnt.ei.tum.de
 [129.187.109.199])
 (using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by postout1.mail.lrz.de (Postfix) with ESMTPSA id 3gKw8S1W56zySx
 for <alsa-devel@alsa-project.org>; Fri,  2 May 2014 16:00:24 +0200 (CEST)
In-Reply-To: <536364EA.5030203@tum.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a cryptographically signed message in MIME format.

--===============4749496083473698635==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha1; boundary="------------ms020204020102030802030107"

This is a cryptographically signed message in MIME format.

--------------ms020204020102030802030107
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable



On 05/02/2014 11:27 AM, Joschi Brauchle wrote:
> On 05/02/2014 11:02 AM, Joschi Brauchle wrote:
>>
>>
>> On 05/02/2014 10:21 AM, Takashi Iwai wrote:
>>> At Fri, 02 May 2014 10:16:10 +0200,
>>> Joschi Brauchle wrote:
>>>>
>>>> On 05/02/2014 09:31 AM, Takashi Iwai wrote:
>>>>> At Wed, 30 Apr 2014 19:05:24 +0200,
>>>>> Joschi Brauchle wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 04/30/2014 06:43 PM, Takashi Iwai wrote:
>>>>>>> At Wed, 30 Apr 2014 10:56:48 +0200,
>>>>>>> Joschi Brauchle wrote:
>>>>>>>>
>>>>>>>> Dear all,
>>>>>>>>
>>>>>>>> using openSUSE 13.1 on an Thinkpad T440s, I am not getting sound=

>>>>>>>> once
>>>>>>>> the laptop is docked to its docking station.
>>>>>>>>
>>>>>>>> I suspect an additional SND_PCI_QUIRK is needed for this model.
>>>>>>>> "pactl list" returns
>>>>>>>> ----------------
>>>>>>>> alsa.mixer_name =3D "Realtek ALC292"
>>>>>>>> alsa.components =3D "HDA:10ec0292,17aa220c,00100001"
>>>>>>>> ----------------
>>>>>>>> for the analog audio output sink in docked state.
>>>>>>>>
>>>>>>>> Hence I assume a new line *similar* to this
>>>>>>>> ----------------
>>>>>>>> SND_PCI_QUIRK(0x17aa, 0x220c, "Thinkpad T440s",
>>>>>>>> ALC269_FIXUP_LENOVO_DOCK),
>>>>>>>> ----------------
>>>>>>>> is needed?
>>>>>>>> What about the ALC292 instead of 269 Realtek chip...?
>>>>>>>
>>>>>>> It's a compatible chip, so the codec name doesn't matter.
>>>>>>> You can try it with model=3Dlenovo-dock option with the recent
>>>>>>> kernels.
>>>>>>> For Haswell, it's safer to pass twice
>>>>>>> (model=3Dlenovo-dock,lenovo-dock).
>>>>>>>
>>>>>>> Let us know if this works for you.
>>>>>>>
>>>>>>>
>>>>>>> Takashi
>>>>>>>
>>>>>>     Hi Takashi,
>>>>>>
>>>>>> so i have:
>>>>>> ------------------ /etc/modprobe.d/50-sound.conf -----------------=
--
>>>>>>
>>>>>> options snd-hda-intel model=3Dlenovo-dock,lenovo-dock
>>>>>> options snd slots=3Dsnd-hda-intel,snd-hda-intel
>>>>>> # 3hqH.vsazS+ZIdb9:Intel Corporation
>>>>>> alias snd-card-0 snd-hda-intel
>>>>>> # u1Nb.8dI5aUgInHB:Intel Corporation
>>>>>> alias snd-card-1 snd-hda-intel
>>>>>> ------------------
>>>>>> and rebooted, but still get no sound from the headphone jack on th=
e
>>>>>> dock, although the built-in speakers immediately mute when
>>>>>> plugging in
>>>>>> headphones.
>>>>>
>>>>> Give alsa-info.sh output with that state for further checking.
>>>>>
>>>>>
>>>>> Takashi
>>>>>
>>>>
>>>> Please find alsa-info attached while docking and with
>>>> "model=3Dlenovo-dock,lenovo-dock" option.
>>>
>>> Did you take alsa-info.sh output while you're plugging to the dock
>>> headphone jack?  With the setup, it's NID 0x1b, and "Dock Headphone
>>> Jack" control should be "true" when properly detected.
>>>
>>> Maybe you'd be better to figure out which dock pin corresponds to
>>> which at first.  hda-jack-retask should be your help.
>>>
>>>
>>> Takashi
>>>
>> Hi,
>>
>> yes, alsa-info.sh was created while the laptop was docked and headphon=
es
>> plugged in at the docking station headphone jack.
>>
>> I installed hda-jack-retask and played with it a little bit, but I'm
>> rather lost...
>>
>> What exactly whould I try to do with it?
>>
>> Thanks, Joschi
>>
>
> So if I override pin 0x16 with anything (i.e. type headphones) I do get=

> sound from the speakers connected to the docking station headphone jack=
!
>
> Joschi
>

Actually, someone else has already found the correct values for the T440p=
=2E
https://github.com/leoluk/thinkpad-stuff/wiki/Haswell-ThinkPad-problems#l=
inux-docking-station-audio-compatibility

I have modified the values to fit the T440s:
File: /lib/firmware/hda-jack-retask.fw
--------------------------------------
[codec]
0x10ec0292 0x17aa220c 0

[pincfg]
0x16 0x2121101f
0x19 0x21a11030
--------------------------------------
I tested the settings and can confirm that docking headphone + mic works =

correctly, but I am not sure what these values do/mean exactly.

Possibly they need to be corrected...

Joschi






--------------ms020204020102030802030107
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIO6jCC
BHQwggNcoAMCAQICCQCJkBEVWD6HmzANBgkqhkiG9w0BAQsFADBxMQswCQYDVQQGEwJERTEc
MBoGA1UEChMTRGV1dHNjaGUgVGVsZWtvbSBBRzEfMB0GA1UECxMWVC1UZWxlU2VjIFRydXN0
IENlbnRlcjEjMCEGA1UEAxMaRGV1dHNjaGUgVGVsZWtvbSBSb290IENBIDIwHhcNMTQwMjEx
MTMxMTQ1WhcNMTkwNzA5MjM1OTAwWjBaMQswCQYDVQQGEwJERTETMBEGA1UEChMKREZOLVZl
cmVpbjEQMA4GA1UECxMHREZOLVBLSTEkMCIGA1UEAxMbREZOLVZlcmVpbiBQQ0EgR2xvYmFs
IC0gRzAxMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA6ZvDZ4X5Da71jVTDllA1
PWLpbkztlNcAW5UidNQg6zSP1uzAMQQLmYHiphTSUqAoI4SLdIkEXlvg4njBeMsWyyg1OXst
kEXQ7aAAeny/Sg4bAMOG6VwrMRF7DPOCJEOMHDiLamgAmu7cT3ir0sYTm3at7t4m6O8Br3QP
wQmi9mvOvdPNFDBP9eXjpMhim4IaAycwDQJlYE3t0QkjKpY1WCfTdsZxtpAdxO3/NYZ9bzOz
2w/FEcKKg6GUXUFr2NIQ9Uz9ylGs2b3vkoO72uuLFlZWQ8/h1RM9ph8nMM1JVNvJEzSacXXF
bOqnC5j5IZ0nrz6jOTlIaoytyZn7wxLyvQIDAQABo4IBJDCCASAwDgYDVR0PAQH/BAQDAgEG
MB0GA1UdDgQWBBRJt8bP6D0ff+pEexMp9/EKcD7eZDAfBgNVHSMEGDAWgBQxw3kbuvVT1xfg
iXotF2wKsyudMzASBgNVHRMBAf8ECDAGAQH/AgECMD8GA1UdHwQ4MDYwNKAyoDCGLmh0dHA6
Ly9vY3NwMDMzNi50ZWxlc2VjLmRlL3JsL0RUX1JPT1RfQ0FfMi5jcmwweQYIKwYBBQUHAQEE
bTBrMCwGCCsGAQUFBzABhiBodHRwOi8vb2NzcDAzMzYudGVsZXNlYy5kZS9vY3NwcjA7Bggr
BgEFBQcwAoYvaHR0cDovL29jc3AwMzM2LnRlbGVzZWMuZGUvY3J0L0RUX1JPT1RfQ0FfMi5j
ZXIwDQYJKoZIhvcNAQELBQADggEBACwvqeBeQy8FcNxRlXVdgI47DMFjWFSBMIOcXalRh8m2
1w8runhIJGBCzPGi4jPhMh4ym1ETlXnGtazQJO0YFLwvKuovq7ITrEkdXgALBBhqmmXU6Ec1
vK7t33S22PGAUGWgxtojm41TR8psu0DJlV1OYHor5LtmQFWvtjPB6iMhbvxUnd0zQm5Ma9Xk
w/LqBrdaMmoyRXS2tW/+6v8cY6q7iNH4WK8gfo+///b3OHeLGrZQP609R3lGw1e0F2KHvZ6j
NiUHaCSqIvL2rynsN6UUma66AWCGdS1hFbp4loe1ks/hUJGeWToV7J5axob8KD5mutTZNa+t
PEkihYfub48wggTMMIIDtKADAgECAgQJ8QpjMA0GCSqGSIb3DQEBBQUAMFoxCzAJBgNVBAYT
AkRFMRMwEQYDVQQKEwpERk4tVmVyZWluMRAwDgYDVQQLEwdERk4tUEtJMSQwIgYDVQQDExtE
Rk4tVmVyZWluIFBDQSBHbG9iYWwgLSBHMDEwHhcNMDcwMjEzMTAwMzAxWhcNMTkwMjEyMDAw
MDAwWjBgMQswCQYDVQQGEwJERTEpMCcGA1UEChMgVGVjaG5pc2NoZSBVbml2ZXJzaXRhZXQg
TXVlbmNoZW4xJjAkBgNVBAMTHVplcnRpZml6aWVydW5nc3N0ZWxsZSBkZXIgVFVNMIIBIjAN
BgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAqO/o09gEXMn5kQtzol8T/lqBr/srstYxUEdm
+iF0lkZ3fWk31AR/NB6mHSSKqybVfmQeto+1Nz2MwfxIsBIEjjkmmk1JJhF/DqPpGMoDs9RK
1F9XR2rlwE8GXkWnEBjbeUDMzNj7oRASrf+FLwhrfMblDmxomxz70HZKjz6C9pXBmGtaF7s2
HK9WpgyIGlMT19tWJqHdSvlV0OlwZuxv8GpEPFGs4KNB01DpMJAd8hQQNNAxb9zOPXBuAvGu
nywHleXAw9ftzYOj7IHJZtyuSK10YR5qBxaoLWBzykP9/w8kihV5bhzLrQ+MdEh9gLQ0FW+D
0/S+K7AUTJYzXtusjwIDAQABo4IBkjCCAY4wDwYDVR0TAQH/BAUwAwEB/zALBgNVHQ8EBAMC
AQYwHQYDVR0OBBYEFJ2fI/AZG37HI10nKsylNjqmaeWJMB8GA1UdIwQYMBaAFEm3xs/oPR9/
6kR7Eyn38QpwPt5kMIGIBgNVHR8EgYAwfjA9oDugOYY3aHR0cDovL2NkcDEucGNhLmRmbi5k
ZS9nbG9iYWwtcm9vdC1jYS9wdWIvY3JsL2NhY3JsLmNybDA9oDugOYY3aHR0cDovL2NkcDIu
cGNhLmRmbi5kZS9nbG9iYWwtcm9vdC1jYS9wdWIvY3JsL2NhY3JsLmNybDCBogYIKwYBBQUH
AQEEgZUwgZIwRwYIKwYBBQUHMAKGO2h0dHA6Ly9jZHAxLnBjYS5kZm4uZGUvZ2xvYmFsLXJv
b3QtY2EvcHViL2NhY2VydC9jYWNlcnQuY3J0MEcGCCsGAQUFBzAChjtodHRwOi8vY2RwMi5w
Y2EuZGZuLmRlL2dsb2JhbC1yb290LWNhL3B1Yi9jYWNlcnQvY2FjZXJ0LmNydDANBgkqhkiG
9w0BAQUFAAOCAQEAg2g22cMLJTBw8Nzrx7+7k7999yz6vjHg55HEq1hd3d1ELK4KjEkCGF6l
KTahBzz1CFYU44HF5PsqiygKyf6G0u2CdkuPhH/I1fwx6bNg/XvQ5n+bhf2+ZGG3L6CH3SQJ
JmVpCBP0x9X7uDULpCB6VQNXw3rw13g+XUgwFaQCRlktxP38eCiXn0UaEUMXW4XHtK769gGU
7eD60ecjXxckEM6zZpsdFcjk+Zhy+0aKuxUx9ZyzSihk6idjDmm9Yj43x1q30M0i+BF2gKFM
4p289RGO2RjeQmS90B88qx/9kKPceF0SfRvpVlCoOPtUlEK8U4vS2pJzbBSsctHD/0y7aDCC
BZ4wggSGoAMCAQICBxZx6199LPQwDQYJKoZIhvcNAQEFBQAwYDELMAkGA1UEBhMCREUxKTAn
BgNVBAoTIFRlY2huaXNjaGUgVW5pdmVyc2l0YWV0IE11ZW5jaGVuMSYwJAYDVQQDEx1aZXJ0
aWZpemllcnVuZ3NzdGVsbGUgZGVyIFRVTTAeFw0xMzEwMDcwODE2MTZaFw0xNjEwMDYwODE2
MTZaMIHdMQswCQYDVQQGEwJERTEPMA0GA1UECBMGQmF5ZXJuMREwDwYDVQQHEwhNdWVuY2hl
bjEpMCcGA1UEChMgVGVjaG5pc2NoZSBVbml2ZXJzaXRhZXQgTXVlbmNoZW4xPjA8BgNVBAsT
NUZha3VsdGFldCBmdWVyIEVsZWt0cm90ZWNobmlrIHVuZCBJbmZvcm1hdGlvbnN0ZWNobmlr
MRgwFgYDVQQDEw9Kb3NjaGkgQnJhdWNobGUxJTAjBgkqhkiG9w0BCQEWFmpvc2NoaS5icmF1
Y2hsZUB0dW0uZGUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDDUTo3kvRFgmnS
RPxNZFPS0YKGEpDFHj90LrvM49ZdL95ZRW3yM7TDf1gmj+YGLecbIDvHBKB4ug4M6Sijndp9
TFFEWps+JKpKkezQjRx4/HNhXL7dlwyDsn1FixkRJjU+tAwWa+FMlLHMDA3rBohHKOhVmhNU
Hj9QL9CFoVuXhZlwjIio4urTCVGys8m5cmI1bwhGxjrHF/m4/jDYWiP3A+qgXiyxJpIdDM9W
HY9oGhbmIKYdNX+I9oP2aMIYxItsKUgXtVgswEwJKZ8aCi7RSUotDbi3Bv3jGRtrRAqjxrUY
xTTQejAwQFveljx7iyMczSEZXM8d+Mp/tnafvvi/AgMBAAGjggHdMIIB2TAvBgNVHSAEKDAm
MBEGDysGAQQBga0hgiwBAQQDADARBg8rBgEEAYGtIYIsAgEEAwAwCQYDVR0TBAIwADALBgNV
HQ8EBAMCBeAwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMB0GA1UdDgQWBBRIPYxb
H3otuuvtVp6HesCmsA/g6zAfBgNVHSMEGDAWgBSdnyPwGRt+xyNdJyrMpTY6pmnliTAhBgNV
HREEGjAYgRZqb3NjaGkuYnJhdWNobGVAdHVtLmRlMHcGA1UdHwRwMG4wNaAzoDGGL2h0dHA6
Ly9jZHAxLnBjYS5kZm4uZGUvdHVtLWNhL3B1Yi9jcmwvY2FjcmwuY3JsMDWgM6Axhi9odHRw
Oi8vY2RwMi5wY2EuZGZuLmRlL3R1bS1jYS9wdWIvY3JsL2NhY3JsLmNybDCBkgYIKwYBBQUH
AQEEgYUwgYIwPwYIKwYBBQUHMAKGM2h0dHA6Ly9jZHAxLnBjYS5kZm4uZGUvdHVtLWNhL3B1
Yi9jYWNlcnQvY2FjZXJ0LmNydDA/BggrBgEFBQcwAoYzaHR0cDovL2NkcDIucGNhLmRmbi5k
ZS90dW0tY2EvcHViL2NhY2VydC9jYWNlcnQuY3J0MA0GCSqGSIb3DQEBBQUAA4IBAQAr3wnm
z7doaFaoQ+5TDFubiPEyYsb5/oNs/mz/YCMe9aQZbBKBP27nTdQSOos/ui2CvQAVhYCt9/BN
a/aLo+t6HU5+EMeSbTnUus60WP7+UGM34LC4WiMbbXcEoM6ejf1wBGshtIOoF0uljXUMmft6
MRyEyPvE2qO3lNswfjSRQPoCkKEy4l2KWTi0Qj9+WQpvHgSjxto/E+K9ePIRciA05JKxkuMQ
b6s7RHmaSjrY6yEJL57T31ntotyMsTmnGuVnr7xeV/SFMnkEuFMckIJ/ltqd8Oskr4xDNoxw
S18rmMoWGrEkrqBGiaqW7szchvUClDe7tZZnWi6D3MsTRnNwMYIDWzCCA1cCAQEwazBgMQsw
CQYDVQQGEwJERTEpMCcGA1UEChMgVGVjaG5pc2NoZSBVbml2ZXJzaXRhZXQgTXVlbmNoZW4x
JjAkBgNVBAMTHVplcnRpZml6aWVydW5nc3N0ZWxsZSBkZXIgVFVNAgcWcetffSz0MAkGBSsO
AwIaBQCgggHFMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE0
MDUwMjEzNTk1NVowIwYJKoZIhvcNAQkEMRYEFPDLObLi2rTIOoYBZHfnLp5t/M5JMGwGCSqG
SIb3DQEJDzFfMF0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAOBggq
hkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwegYJ
KwYBBAGCNxAEMW0wazBgMQswCQYDVQQGEwJERTEpMCcGA1UEChMgVGVjaG5pc2NoZSBVbml2
ZXJzaXRhZXQgTXVlbmNoZW4xJjAkBgNVBAMTHVplcnRpZml6aWVydW5nc3N0ZWxsZSBkZXIg
VFVNAgcWcetffSz0MHwGCyqGSIb3DQEJEAILMW2gazBgMQswCQYDVQQGEwJERTEpMCcGA1UE
ChMgVGVjaG5pc2NoZSBVbml2ZXJzaXRhZXQgTXVlbmNoZW4xJjAkBgNVBAMTHVplcnRpZml6
aWVydW5nc3N0ZWxsZSBkZXIgVFVNAgcWcetffSz0MA0GCSqGSIb3DQEBAQUABIIBAIbpJL/M
1elT7+o07cOdlBMez7neSu/7tQPrdxPe5YTuUkkk1lQgHQzdgJdckVMt6fD7TC5hkqjO8Ir7
7fdCfKFIKm+782hrlvEXWRdo1M2Rvm2EOH1cgI9wZNKC1qst5Caw7mNPKxxO9d6lERKl9Hio
PyELyKBko/j9pNfT0sF0IeVMkJtV8rgbNbti8ZNmkc1v5N/lPzZOnx0RbZXN8hJTIbjfczdH
d2BJkE0YanxboGpoe0b/U2RmhM1Em0CjxlvRf6zPEtpJKQDQwzFDQYrDSBoXmRM2IkZ8UqFz
b6qNKDc86BhbN3cK6Rutw+KDbOXrub6W7i6OUIwJLA/TswsAAAAAAAA=
--------------ms020204020102030802030107--

--===============4749496083473698635==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4749496083473698635==--
