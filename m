From: "Austin, Brian" <Brian.Austin@cirrus.com>
Subject: Re: [PATCH v3] ASoC: Add support for cs42l73 codec
Date: Mon, 17 Oct 2011 19:11:39 +0000
Message-ID: <EC6506B9-53FC-40AF-8931-32F07341FD05@cirrus.com>
References: <1317917945-32580-1-git-send-email-brian.austin@cirrus.com>
	<20111006185746.GA17685@opensource.wolfsonmicro.com>
	<10520301-F8F9-4096-91F8-141F22CEA68C@cirrus.com>
	<20111007103359.GG19080@opensource.wolfsonmicro.com>
	<1317985636.1573.2272.camel@vkoul-udesk3>
	<20111007114239.GB24534@sirena.org.uk>
	<F41D058E-D2A8-4046-B391-1452889ED54C@cirrus.com>
	<1317997753.1573.2285.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3763051128571313453=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from DB3EHSOBE003.bigfish.com (db3ehsobe003.messaging.microsoft.com
	[213.199.154.141])
	by alsa0.perex.cz (Postfix) with ESMTP id 09EE3103810
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Oct 2011 21:12:43 +0200 (CEST)
In-Reply-To: <1317997753.1573.2285.camel@vkoul-udesk3>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: "<alsa-devel@alsa-project.org>" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "<lrg@ti.com>" <lrg@ti.com>, "<ramesh.babu@intel.com>" <ramesh.babu@intel.com>, "<joe@nucleusys.com>" <joe@nucleusys.com>
List-Id: alsa-devel@alsa-project.org

--===============3763051128571313453==
Content-Language: en-US
Content-Type: multipart/signed;
	boundary="Apple-Mail=_D73A379E-7165-4E1A-B403-C2D8D2296A42";
	protocol="application/pkcs7-signature"; micalg=sha1

--Apple-Mail=_D73A379E-7165-4E1A-B403-C2D8D2296A42
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


On Oct 7, 2011, at 9:29 AM, Vinod Koul wrote:

> On Fri, 2011-10-07 at 14:05 +0000, Austin, Brian wrote:
>> On Oct 7, 2011, at 6:42 AM, Mark Brown wrote:
>>> On Fri, Oct 07, 2011 at 04:37:16PM +0530, Vinod Koul wrote:
>>>=20
>>>> See below:
>>>=20
>>>> +static const struct snd_kcontrol_new dac1_output_mixer[] =3D {
>>>> +       SOC_DAPM_SINGLE("Headphone Switch", CS42L73_PWRCTL3, 0, 1, =
1),
>>>> +       SOC_DAPM_SINGLE("LineOut Switch", CS42L73_PWRCTL3, 1, 1, =
1),
>>>> +};
>>>=20
>>>> +static const struct snd_kcontrol_new dac2_output_mixer[] =3D {
>>>> +       SOC_DAPM_SINGLE("Speakerphone Switch", CS42L73_PWRCTL3, 2, =
1,
>>>> 1),
>>>> +       SOC_DAPM_SINGLE("Speakerphone LineOut Switch", =
CS42L73_PWRCTL3,
>>>> +                       4, 1, 1),
>>>> +       SOC_DAPM_SINGLE("EarSpeaker Switch", CS42L73_PWRCTL3, 3, 1, =
1),
>>>> +};
>>>=20
>>>> I think naming should be slightly better :)
>>>=20
>>> I'm not sure, it might be more than the naming.  The fact that we're =
in
>>> PWRCTL registers could be confusing hardware design, or the =
structure of
>>> the hardware may not actually reflect what the driver is doing.
>>>=20
>>=20
>> The way to enable the output is to enable the output pin.  I have no =
control in SW=20
>> over the DAC's. The pins are power controlled of course. I know it =
looks strange,=20
>> but without using a machine driver to enable/disable the pins for a =
certain route,=20
>> this seems to be the best solution.
>>=20
>> I am of course open to other ideas :)
> What i saw in the spec is that this codec has three PCM ports and each
> one can be input to the DACs. The DAC output goes to output pins and =
in
> some cases shared (like DAC2 for ep/spkr).
> For output you have amp switches at end, so we can control where =
output
> is going as well.
> So we can have is APCM -> Mixer's -> DAC -> out switches -> pins
> All this is codec domain so why should machine driver be bothered =
about
> this stuff. Anything external to codec should be handled in machine
> driver, otherwise we end up creating same code in all machine drivers
> which use this codec.
>=20
> --=20
> ~Vinod
>=20
>=20
I have changed the DAPM widgets for the Amp's to be Switches.  They are =
on or off based on the mixer control.
so now it looks as follows.

static const struct snd_kcontrol_new hp_amp_ctl =3D=20
        SOC_DAPM_SINGLE("Switch", CS42L73_PWRCTL3, 0, 1, 1);
       =20
static const struct snd_kcontrol_new lo_amp_ctl =3D      =20
        SOC_DAPM_SINGLE("Switch", CS42L73_PWRCTL3, 1, 1, 1);

static const struct snd_kcontrol_new spk_amp_ctl =3D=20
        SOC_DAPM_SINGLE("Switch", CS42L73_PWRCTL3, 2, 1, 1);
       =20
static const struct snd_kcontrol_new spklo_amp_ctl =3D=20
        SOC_DAPM_SINGLE("Switch", CS42L73_PWRCTL3, 4, 1, 1);
       =20
static const struct snd_kcontrol_new ear_amp_ctl =3D=20
        SOC_DAPM_SINGLE("Switch", CS42L73_PWRCTL3, 3, 1, 1);


SND_SOC_DAPM_SWITCH("HP Amp", CS42L73_PWRCTL3, 0, 1, &hp_amp_ctl),
SND_SOC_DAPM_SWITCH("LO Amp", CS42L73_PWRCTL3, 1, 1, &lo_amp_ctl),
SND_SOC_DAPM_SWITCH("SPK Amp", CS42L73_PWRCTL3, 2, 1, &spk_amp_ctl),
SND_SOC_DAPM_SWITCH("EAR Amp", CS42L73_PWRCTL3, 3, 1, &ear_amp_ctl),
SND_SOC_DAPM_SWITCH("SPKLO Amp", CS42L73_PWRCTL3, 4, 1, &spklo_amp_ctl),

{"HP Amp", "Switch", "DAC1"},
{"LO Amp", "Switch", "DAC1"},
{"SPK Amp", "Switch", "DAC2"},
{"SPKLO Amp", "Switch", "DAC2"},
{"EAR Amp", "Switch", "DAC2"},

This allows me to route the streams from any PCM to any output. IF this =
is OK I would like to resubmit.

Thanks,
Brian


--Apple-Mail=_D73A379E-7165-4E1A-B403-C2D8D2296A42
Content-Disposition: attachment; filename="smime.p7s"
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIMMTCCBYMw
ggRroAMCAQICCmESnAkAAAAAAAMwDQYJKoZIhvcNAQEFBQAwWDETMBEGCgmSJomT8ixkARkWA2Nv
bTEWMBQGCgmSJomT8ixkARkWBmNpcnJ1czESMBAGCgmSJomT8ixkARkWAmFkMRUwEwYDVQQDEwxh
ZC1DQVJPT1QtQ0EwHhcNMTEwNDEyMjAxNDQyWhcNMTYwNDEyMjAyNDQyWjBYMRMwEQYKCZImiZPy
LGQBGRYDY29tMRYwFAYKCZImiZPyLGQBGRYGY2lycnVzMRIwEAYKCZImiZPyLGQBGRYCYWQxFTAT
BgNVBAMTDGFkLUNBU1VCMS1DQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAIYQjJFn
kvtekksMo5EQZ1G6SeF5VoxF76IFFBoO5a2tSRlWkqVC1W+pnTXrQDgaqDqaXpBvtBm8SxTmdKfu
28vwZfanrzUfA+5oWi6+hHzohe52tXJLafVevfxjP3Cr+DSu0h1zHS9M+am3iKrc4D3JUMlGR4Bf
COoPwG8fMmw35M5iA5fURrw9xvsiiZDiblv4jRYjmuqqGuCNzOWaGrVMgeCIGGE95xFdoaNwwD5S
zCYwpQgujYf9ed2Ig5gOT5E+Bou48+PcGmouKV5PNEqmxLUPJ+851GALCtZaOmLldNrHDATtjeW+
a3U0DIWZIJ5GjNt0H0mLfH2+tgg3M4UCAwEAAaOCAk0wggJJMBIGCSsGAQQBgjcVAQQFAgMBAAEw
IwYJKwYBBAGCNxUCBBYEFKwWBOBnCgA5i/dX8QmYcM2UFkiQMB0GA1UdDgQWBBRBxVW0bFUVFUUv
Dcc0L1yGhCdoaDAZBgkrBgEEAYI3FAIEDB4KAFMAdQBiAEMAQTALBgNVHQ8EBAMCAYYwDwYDVR0T
AQH/BAUwAwEB/zAfBgNVHSMEGDAWgBTU30/gZySZRaDiMmMfeod1SRGIyzCBzgYDVR0fBIHGMIHD
MIHAoIG9oIG6hoG3bGRhcDovLy9DTj1hZC1DQVJPT1QtQ0EsQ049Q0FSb290LENOPUNEUCxDTj1Q
dWJsaWMlMjBLZXklMjBTZXJ2aWNlcyxDTj1TZXJ2aWNlcyxDTj1Db25maWd1cmF0aW9uLERDPWFk
LERDPWNpcnJ1cyxEQz1jb20/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdD9iYXNlP29iamVjdENs
YXNzPWNSTERpc3RyaWJ1dGlvblBvaW50MIHDBggrBgEFBQcBAQSBtjCBszCBsAYIKwYBBQUHMAKG
gaNsZGFwOi8vL0NOPWFkLUNBUk9PVC1DQSxDTj1BSUEsQ049UHVibGljJTIwS2V5JTIwU2Vydmlj
ZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1hZCxEQz1jaXJydXMsREM9Y29tP2NB
Q2VydGlmaWNhdGU/YmFzZT9vYmplY3RDbGFzcz1jZXJ0aWZpY2F0aW9uQXV0aG9yaXR5MA0GCSqG
SIb3DQEBBQUAA4IBAQAX/fhcoBXPZniRLReyvYHdGKrE9mzqm6UGbM4DtkdpiKnLgD24Abvj/oT4
7WUMpmnmDRoNb8486QMqdJHumuFWJS4nw9BkULBFfjGe/YUk8oRVtWYCmo/5qW3WiCmW/TYmXsCW
1LPgtE1J1bWg6ws0oTJJZZSnxVI/jhVuuofQrPdAv0AfVH4o8Fwx8sSC1nNFUbIlqQLzLklziqcy
b6x2tDqk3F+oHnHHt+IyiCsGq3/hclefyZrY2/8seJuLk+CrYVL4ZI2v+gkAi8vwr2tVtpc+EP6i
nj0qBWO/PdbSS09S6nzN8eNJ2gudKWB4TOhaEoIBCO+U9RB+XKnC7AbaMIIGpjCCBY6gAwIBAgIK
OTgTiQABAAAS7DANBgkqhkiG9w0BAQUFADBYMRMwEQYKCZImiZPyLGQBGRYDY29tMRYwFAYKCZIm
iZPyLGQBGRYGY2lycnVzMRIwEAYKCZImiZPyLGQBGRYCYWQxFTATBgNVBAMTDGFkLUNBU1VCMS1D
QTAeFw0xMTA3MjgxNTQ5MzZaFw0xMzA3MjcxNTQ5MzZaMIGnMRMwEQYKCZImiZPyLGQBGRYDY29t
MRYwFAYKCZImiZPyLGQBGRYGY2lycnVzMRIwEAYKCZImiZPyLGQBGRYCYWQxDzANBgNVBAsTBlBl
b3BsZTETMBEGA1UECxMKVEVSUkFDRSBCNTEWMBQGA1UEAxMNQXVzdGluLCBCcmlhbjEmMCQGCSqG
SIb3DQEJARYXQnJpYW4uQXVzdGluQGNpcnJ1cy5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAw
ggEKAoIBAQCy87TkTKo85pOsBlZ76Ifo/MeL5Ur09Phz7LTXFI7fkwLyw75OXFF0DpqvMOtqGefl
YVE9Ve0oL2FP3frTj1df3brATuHHs79LIa287k8dKaXfciAY1249ELAjfiWHsivR2daxtJ0zjyRj
GtgfppmeRA7uhm9VSQP4l0/YU7FTKu6P+FMgy7y7QJjtWIKNa+seCKhQoxhifPmYDzqhsPVz4EA7
nsXcyO1h0WVQ34gZfnuRuZagLilC8LSqsMGuMQzTy1mGcmYHiT4hvPtux64yr8ldxZs0HvXIHSRQ
xPREY8RwyTCLbKp5wZpPuVcpsmAWlSH9V87WG7H2azaJdwaDAgMBAAGjggMgMIIDHDAdBgNVHQ4E
FgQU9yzlSoU5qj4apOykJWMG5Em9XiQwHwYDVR0jBBgwFoAUQcVVtGxVFRVFLw3HNC9choQnaGgw
gdEGA1UdHwSByTCBxjCBw6CBwKCBvYaBumxkYXA6Ly8vQ049YWQtQ0FTVUIxLUNBKDEpLENOPUNB
U3ViMSxDTj1DRFAsQ049UHVibGljJTIwS2V5JTIwU2VydmljZXMsQ049U2VydmljZXMsQ049Q29u
ZmlndXJhdGlvbixEQz1hZCxEQz1jaXJydXMsREM9Y29tP2NlcnRpZmljYXRlUmV2b2NhdGlvbkxp
c3Q/YmFzZT9vYmplY3RDbGFzcz1jUkxEaXN0cmlidXRpb25Qb2ludDCBwwYIKwYBBQUHAQEEgbYw
gbMwgbAGCCsGAQUFBzAChoGjbGRhcDovLy9DTj1hZC1DQVNVQjEtQ0EsQ049QUlBLENOPVB1Ymxp
YyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9YWQsREM9
Y2lycnVzLERDPWNvbT9jQUNlcnRpZmljYXRlP2Jhc2U/b2JqZWN0Q2xhc3M9Y2VydGlmaWNhdGlv
bkF1dGhvcml0eTAOBgNVHQ8BAf8EBAMCBaAwPQYJKwYBBAGCNxUHBDAwLgYmKwYBBAGCNxUIgdgI
hLeiGoTpmQuF6Y84s6ZRAozknKxhjfHFoxoCAWQCAQUwKQYDVR0lBCIwIAYIKwYBBQUHAwIGCCsG
AQUFBwMEBgorBgEEAYI3CgMEMDUGCSsGAQQBgjcVCgQoMCYwCgYIKwYBBQUHAwIwCgYIKwYBBQUH
AwQwDAYKKwYBBAGCNwoDBDBJBgNVHREEQjBAoCUGCisGAQQBgjcUAgOgFwwVYmF1c3RpbkBhZC5j
aXJydXMuY29tgRdCcmlhbi5BdXN0aW5AY2lycnVzLmNvbTBEBgkqhkiG9w0BCQ8ENzA1MA4GCCqG
SIb3DQMCAgIAgDAOBggqhkiG9w0DBAICAIAwBwYFKw4DAgcwCgYIKoZIhvcNAwcwDQYJKoZIhvcN
AQEFBQADggEBADOxkZy4DcuL9BC1L9DmJ+swOQ6O3C130cDblE1UZoyXZ/9rgMX10OTPa6TK+1IC
RmuhsOnKOleYrQgIMgvcV8EXPV7s2Bm84S1FuzshaJ4qwSOSSuctOpmNvQA8pg0EAaOOJXa31mHM
JsBg3vOSFwCRP/XhdYBROqfGHwIVbOES0Kmba3F267YyqH6R6OcM8HXFoyGTLwr+w8Sq/puk8hkY
J02P+H9UDdo9gwho2OYw/OYJqwq0eFcDhNqmiR79xjWpioN42FNBXyEi/ZWpX+jjg745/VjX07oJ
yBm2B6WZSj7AJ/VBqjKjMcY6pLiwmXmpqoPsL9nAdW6WMrbU3wcxggLeMIIC2gIBATBmMFgxEzAR
BgoJkiaJk/IsZAEZFgNjb20xFjAUBgoJkiaJk/IsZAEZFgZjaXJydXMxEjAQBgoJkiaJk/IsZAEZ
FgJhZDEVMBMGA1UEAxMMYWQtQ0FTVUIxLUNBAgo5OBOJAAEAABLsMAkGBSsOAwIaBQCgggFNMBgG
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTExMTAxNzE5MTIwNVowIwYJ
KoZIhvcNAQkEMRYEFK1L/g8pewFk+s5ez0TltI6L1/CBMHUGCSsGAQQBgjcQBDFoMGYwWDETMBEG
CgmSJomT8ixkARkWA2NvbTEWMBQGCgmSJomT8ixkARkWBmNpcnJ1czESMBAGCgmSJomT8ixkARkW
AmFkMRUwEwYDVQQDEwxhZC1DQVNVQjEtQ0ECCjk4E4kAAQAAEuwwdwYLKoZIhvcNAQkQAgsxaKBm
MFgxEzARBgoJkiaJk/IsZAEZFgNjb20xFjAUBgoJkiaJk/IsZAEZFgZjaXJydXMxEjAQBgoJkiaJ
k/IsZAEZFgJhZDEVMBMGA1UEAxMMYWQtQ0FTVUIxLUNBAgo5OBOJAAEAABLsMA0GCSqGSIb3DQEB
AQUABIIBACuDMZqlVVsEQry3FMadD7iAc08jS3JfJPyCwiykgDWlcYFXI/VAsr5YEo+lxT3RIsZo
5bdmk6eSaR4ewe8maAnSsOLLFvBQtWkbTuJmCMpXH/SNhu9CqBNSJudfK2fFx+HteLnECWZWX3jo
jOiz3AjceVr1jXY7jNRyN496vkxXX4PHIsLdt0794Ud4cNEoCADLEbpuH+rfjuFxJErLIQYw7nkX
pC7xhAiDXnb24MxChbkxhH0i7qPLd8tlNrF1J+dUx6pzKIqxnkUXfIf0SVynMGO9p2zPc+0e6xdr
B633/sVTqrKJGyiMcWLMd5rVHa9hBlWroKERjHKhsPsRMgAAAAAAAAA=

--Apple-Mail=_D73A379E-7165-4E1A-B403-C2D8D2296A42--

--===============3763051128571313453==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3763051128571313453==--
