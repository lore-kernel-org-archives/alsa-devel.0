From: Joschi Brauchle <joschi.brauchle@tum.de>
Subject: Re: No sound on Thinkpad T440s in Docking Station
Date: Wed, 07 May 2014 11:28:25 +0200
Message-ID: <5369FCB9.4020205@tum.de>
References: <5360BAD0.3060808@tum.de>	<s5h61lqix9b.wl%tiwai@suse.de>	<53612D54.10302@tum.de>	<s5h7g64skkx.wl%tiwai@suse.de>	<5363544A.8040508@tum.de>	<s5hzjj0r3ob.wl%tiwai@suse.de>	<53635F17.4050202@tum.de>	<536364EA.5030203@tum.de>	<5363A4DB.4040404@tum.de>	<s5h1tw7w87g.wl%tiwai@suse.de>	<5368E878.90704@tum.de>	<5368FDBD.2030400@tum.de>
 <s5hzjiuud7m.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3311255922566228329=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from postout1.mail.lrz.de (postout1.mail.lrz.de [129.187.255.137])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A62426109C
 for <alsa-devel@alsa-project.org>; Wed,  7 May 2014 11:28:52 +0200 (CEST)
In-Reply-To: <s5hzjiuud7m.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a cryptographically signed message in MIME format.

--===============3311255922566228329==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha1; boundary="------------ms000804090504090402010004"

This is a cryptographically signed message in MIME format.

--------------ms000804090504090402010004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

On 05/06/2014 05:41 PM, Takashi Iwai wrote:
> At Tue, 06 May 2014 17:20:29 +0200,
> Joschi Brauchle wrote:
>>
>> Alright, I think I found the correct settings:
>>
>> [codec]
>> 0x10ec0292 0x17aa220c 0
>>
>> [pincfg]
>> 0x16 0x21211010
>> 0x19 0x21a11010
>>
>> If
>> a) no headphones plugged in anywhere, laptop speakers work
>> b) headphones only plugged in dock and not at laptop, dock headphones
>> work, laptop speakers silent
>> c) headphones plugged in laptop (and/or dock), only laptop headphones
>> work, laptop speakers and dock headphone silent
>>
>> If this is the intended behavior, these values work.
>
> Looks good.  Below is the revised patch I'm going to apply to the
> sound git tree.  Could you check whether it works as expected?
>
> Once confirmed, I can take it to openSUSE 13.1, too.
>
>
> thanks,
>
> Takashi
>
> ---
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: hda - Add dock pin setups for Thinkpad T440
>
> The headphone and mic jacks on Thinkpad T440 are assigned to pins NID
> 0x16 and 0x19, respectively.  These need to be set up manually by a
> fixup.
>
> Reported-by: Joschi Brauchle <joschi.brauchle@tum.de>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>   sound/pci/hda/patch_realtek.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realte=
k.c
> index b60de0dc40d3..40f9b5d712eb 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -4236,6 +4236,7 @@ enum {
>   	ALC255_FIXUP_HEADSET_MODE,
>   	ALC255_FIXUP_HEADSET_MODE_NO_HP_MIC,
>   	ALC293_FIXUP_DELL1_MIC_NO_PRESENCE,
> +	ALC292_FIXUP_TPT440_DOCK,
>   };
>
>   static const struct hda_fixup alc269_fixups[] =3D {
> @@ -4639,6 +4640,16 @@ static const struct hda_fixup alc269_fixups[] =3D=
 {
>   		.chained =3D true,
>   		.chain_id =3D ALC269_FIXUP_HEADSET_MODE
>   	},
> +	[ALC292_FIXUP_TPT440_DOCK] =3D {
> +		.type =3D HDA_FIXUP_PINS,
> +		.v.pins =3D (const struct hda_pintbl[]) {
> +			{ 0x16, 0x21211010 }, /* dock headphone */
> +			{ 0x19, 0x21a11010 }, /* dock mic */
> +			{ }
> +		},
> +		.chained =3D true,
> +		.chain_id =3D ALC269_FIXUP_LIMIT_INT_MIC_BOOST
> +	},
>   };
>
>   static const struct snd_pci_quirk alc269_fixup_tbl[] =3D {
> @@ -4803,7 +4814,8 @@ static const struct snd_pci_quirk alc269_fixup_tb=
l[] =3D {
>   	SND_PCI_QUIRK(0x17aa, 0x21fb, "Thinkpad T430s", ALC269_FIXUP_LENOVO_=
DOCK),
>   	SND_PCI_QUIRK(0x17aa, 0x2203, "Thinkpad X230 Tablet", ALC269_FIXUP_L=
ENOVO_DOCK),
>   	SND_PCI_QUIRK(0x17aa, 0x2208, "Thinkpad T431s", ALC269_FIXUP_LENOVO_=
DOCK),
> -	SND_PCI_QUIRK(0x17aa, 0x220c, "Thinkpad", ALC269_FIXUP_LIMIT_INT_MIC_=
BOOST),
> +	SND_PCI_QUIRK(0x17aa, 0x220c, "Thinkpad T440s", ALC292_FIXUP_TPT440_D=
OCK),
> +	SND_PCI_QUIRK(0x17aa, 0x220e, "Thinkpad T440p", ALC292_FIXUP_TPT440_D=
OCK),
>   	SND_PCI_QUIRK(0x17aa, 0x2212, "Thinkpad", ALC269_FIXUP_LIMIT_INT_MIC=
_BOOST),
>   	SND_PCI_QUIRK(0x17aa, 0x2214, "Thinkpad", ALC269_FIXUP_LIMIT_INT_MIC=
_BOOST),
>   	SND_PCI_QUIRK(0x17aa, 0x2215, "Thinkpad", ALC269_FIXUP_LIMIT_INT_MIC=
_BOOST),
> @@ -4881,6 +4893,7 @@ static const struct hda_model_fixup alc269_fixup_=
models[] =3D {
>   	{.id =3D ALC269_FIXUP_DELL2_MIC_NO_PRESENCE, .name =3D "dell-headset=
-dock"},
>   	{.id =3D ALC283_FIXUP_CHROME_BOOK, .name =3D "alc283-dac-wcaps"},
>   	{.id =3D ALC283_FIXUP_SENSE_COMBO_JACK, .name =3D "alc283-sense-comb=
o"},
> +	{.id =3D ALC292_FIXUP_TPT440_DOCK, .name =3D "tpt440-dock"},
>   	{}
>   };
>
>

I have rebuilt the snd-hda-* modules with the patch above (adapted to=20
3.11 kernel) and tested successfully! Sound is working fine while=20
docking now.

Thanks!


--------------ms000804090504090402010004
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
MDUwNzA5MjgyNVowIwYJKoZIhvcNAQkEMRYEFBnE8BFUrKbnAT/Wv3/B35HwjcwOMGwGCSqG
SIb3DQEJDzFfMF0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAOBggq
hkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwegYJ
KwYBBAGCNxAEMW0wazBgMQswCQYDVQQGEwJERTEpMCcGA1UEChMgVGVjaG5pc2NoZSBVbml2
ZXJzaXRhZXQgTXVlbmNoZW4xJjAkBgNVBAMTHVplcnRpZml6aWVydW5nc3N0ZWxsZSBkZXIg
VFVNAgcWcetffSz0MHwGCyqGSIb3DQEJEAILMW2gazBgMQswCQYDVQQGEwJERTEpMCcGA1UE
ChMgVGVjaG5pc2NoZSBVbml2ZXJzaXRhZXQgTXVlbmNoZW4xJjAkBgNVBAMTHVplcnRpZml6
aWVydW5nc3N0ZWxsZSBkZXIgVFVNAgcWcetffSz0MA0GCSqGSIb3DQEBAQUABIIBAKXZD02S
vqS3f8IeLqcVrflbXoMNAQyguo6qIwRoSg3AOCzRMyn9e1V6breuz7Io8mrE/jXNeDLfYkBO
m9uhbdgEDJqVcZJ/fNhs6jUN1dGRVuPIO1qruzRz0LoXmbtV7WHXw8+2f38KQNomFBri6/Df
2lSS4u4nciM+naDIVvOVxrkCKCPQwrS2uM59B3sL30F1K04GAPQ2ydJVIbZJ72Ry6nVLHH/7
7buawHobLb87byqP+U1cHuFEcAgMSpMxLAsOQmUe8i7zCeD/z8gMaPU7nwjIWlnWt7udxP0m
BKmA8961Nh2HBb4KYjazOOOYnrxbm3jc08/HhfLWRKrZ2XAAAAAAAAA=
--------------ms000804090504090402010004--

--===============3311255922566228329==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3311255922566228329==--
