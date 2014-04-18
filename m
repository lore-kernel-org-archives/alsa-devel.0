From: "Austin, Brian" <Brian.Austin@cirrus.com>
Subject: Re: [PATCH] ASoC: cs42l51: Fix SOC_DOUBLE_R_SX_TLV
 shift values for ADC, PCM, and Analog kcontrols
Date: Fri, 18 Apr 2014 12:22:27 +0000
Message-ID: <93EDF7CC-8175-485C-BA9C-DE10BEC9DEC6@cirrus.com>
References: <1395243602-18012-1-git-send-email-brian.austin@cirrus.com>
 <20140417162625.21d072e7@skate>	<alpine.DEB.2.02.1404171007510.9674@heelrod>
 <20140418112355.4c1fe3ac@skate>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0556608886371221240=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0088.outbound.protection.outlook.com [65.55.169.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 792DC2651A0
 for <alsa-devel@alsa-project.org>; Fri, 18 Apr 2014 14:22:38 +0200 (CEST)
In-Reply-To: <20140418112355.4c1fe3ac@skate>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Handrigan,
 Paul" <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org

--===============0556608886371221240==
Content-Language: en-US
Content-Type: multipart/signed;
	boundary="Apple-Mail=_FC1AA084-5156-4967-A512-7B7A729DFC03";
	protocol="application/pgp-signature"; micalg=pgp-sha512

--Apple-Mail=_FC1AA084-5156-4967-A512-7B7A729DFC03
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252


On Apr 18, 2014, at 4:23 AM, Thomas Petazzoni =
<thomas.petazzoni@free-electrons.com> wrote:

> Dear Brian Austin,
>=20
> On Thu, 17 Apr 2014 10:08:23 -0500, Brian Austin wrote:
>=20
>> can you try this quick check please?
>>=20
>>  static const struct snd_kcontrol_new cs42l51_snd_controls[] =3D {
>>         SOC_DOUBLE_R_SX_TLV("PCM Playback Volume",
>>                         CS42L51_PCMA_VOL, CS42L51_PCMB_VOL,
>> -                       0, 0x19, 0x7F, adc_pcm_tlv),
>> +                       0, 0x19, 0x80, adc_pcm_tlv),
>>         SOC_DOUBLE_R("PCM Playback Switch",
>>                         CS42L51_PCMA_VOL, CS42L51_PCMB_VOL, 7, 1, 1),
>>         SOC_DOUBLE_R_SX_TLV("Analog Playback Volume",
>>                         CS42L51_AOUTA_VOL, CS42L51_AOUTB_VOL,
>> -                       0, 0x34, 0xE4, aout_tlv),
>> +                       0, 0x34, 0xE5, aout_tlv),
>>         SOC_DOUBLE_R_SX_TLV("ADC Mixer Volume",
>>                         CS42L51_ADCA_VOL, CS42L51_ADCB_VOL,
>> -                       0, 0x19, 0x7F, adc_pcm_tlv),
>> +                       0, 0x19, 0x80, adc_pcm_tlv),
>>         SOC_DOUBLE_R("ADC Mixer Switch",
>>                         CS42L51_ADCA_VOL, CS42L51_ADCB_VOL, 7, 1, 1),
>>         SOC_SINGLE("Playback Deemphasis Switch", CS42L51_DAC_CTL, 3, =
1,=20
>> 0),
>=20
> Unfortunately, it still doesn't work: at boot time the PCM and ADC
> mixer values are 100 which looks OK, but the Analog value is 170, =
which
> doesn't look ok. And inspecting the values set at the register level
> for the PCM control seems to reveal that things are still not working
> correctly (read on below).
>=20
> But this time around, I've collected a lot of debugging informations,
> which hopefully will help understand the problem. My understanding is
> that:
>=20
> 	SOC_DOUBLE_R_SX_TLV("Analog Playback Volume",
> 			CS42L51_AOUTA_VOL, CS42L51_AOUTB_VOL,
> 			0, 0x34, 0xE5, aout_tlv),
>=20
> cannot work, because it assumes that the range -102.0 dB to 12.0 dB
> described in the datasheet is represented by using register values =
from
> 0x34 to 0xE5. Which misses the fact that when going from -102.0 dB to =
0
> dB, the register value goes from 0x34 to 0, and then when going from 0
> to 12.0 dB, the register value should go from 0 to 0xE5.
>=20
>=20
Ok, Thanks for the output.
Something is for sure broken, but I could have sworn I checked this. =
I=92ll hook up my L51 board today and see what the deal is.

Thanks,
Brian


--Apple-Mail=_FC1AA084-5156-4967-A512-7B7A729DFC03
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQEcBAEBCgAGBQJTURkEAAoJEHdXZdGWfiO7KnQH/20omFU+QcHkRI+YpQG8VHkD
R1scl50BX3OwnR17ucq77eygkAyitrv+uh0wYFOs3LX6Iz44tXcZhFZaffjMQXRK
oy5nTZ6F1B564Nd5+UdUGazG5YYmh9X+4GxycJvuiIHscdvSOrruzPgXtgU79gkd
HiS+rAqAoH72aV4Yt7f2LPrZyaQIcNihQF91Z+CIl+5F/+SijVuXvpTBKS/xwLP6
5/1AnczvnN/QRViNxGyY4vV87ir5Zt9SEHfte0PqO+Uf4VuINQlGPhmccGlW9EGF
N6maudbROBr440CuYzD99tL4niJaS5Uj+55lpCPPX10+91WLTz51vDOmw2m9pg8=
=WKuz
-----END PGP SIGNATURE-----

--Apple-Mail=_FC1AA084-5156-4967-A512-7B7A729DFC03--

--===============0556608886371221240==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0556608886371221240==--
