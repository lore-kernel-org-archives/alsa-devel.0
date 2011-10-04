From: "Austin, Brian" <Brian.Austin@cirrus.com>
Subject: Re: [PATCH v2] ASoC: Add support for cs42l73 codec
Date: Tue, 4 Oct 2011 17:53:10 +0000
Message-ID: <B2795634-3EDA-4EEC-9107-ED8B1D3AD374@cirrus.com>
References: <1317400912-5789-1-git-send-email-brian.austin@cirrus.com>
	<20111002184033.GD2857@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9214559004118670573=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 2BAB1103831
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Oct 2011 19:54:58 +0200 (CEST)
In-Reply-To: <20111002184033.GD2857@opensource.wolfsonmicro.com>
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
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "<alsa-devel@alsa-project.org>" <alsa-devel@alsa-project.org>, "<vinod.koul@linux.intel.com>" <vinod.koul@linux.intel.com>, "<lrg@ti.com>" <lrg@ti.com>, "<ramesh.babu@intel.com>" <ramesh.babu@intel.com>, "<joe@nucleusys.com>" <joe@nucleusys.com>
List-Id: alsa-devel@alsa-project.org

--===============9214559004118670573==
Content-Language: en-US
Content-Type: multipart/signed;
	boundary="Apple-Mail=_89648963-052A-498F-A4DD-627E1758FD97";
	protocol="application/pkcs7-signature"; micalg=sha1

--Apple-Mail=_89648963-052A-498F-A4DD-627E1758FD97
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Oct 2, 2011, at 1:40 PM, Mark Brown wrote:
> On Fri, Sep 30, 2011 at 11:41:52AM -0500, Brian Austin wrote:
>> This patch adds support for the Cirrus Logic CS42L73
>> low power stereo codec.
>=20
> A few comments here beyond those others made (though I may be
> replicating some of what they said) but overall this is shaping up
> well - hopefully next version we can get this merged.
>=20
> Folks: when replying to patches (or mails in general) you should =
delete
> unneeded context.  This makes it much easier to find the text you =
wrote,
> all the stuff about cutting text improving bandwidth usage applies =
just
> as much to the humans reading your mail as to the computers moving it.
>=20
>> This patch has cleared checkpatch.pl with no warnings or errors.
>> Code changes requested were implemented.
>> ASoC API changes requested were implemented.
>=20
> Stuff like this should go after the ---.
>=20
>> + * cs42l73.c  --  CS42L73 ALSA Soc Audio driver
>> + *
>> + * Copyright 2011 Cirrus Logic, Inc.
>> + *
>> + * Authors: Georgi Vlaev, Nucleus Systems Ltd, =
<office@nucleusys.com>
>=20
> Who's not CCed on the patch, and who hasn't signed it off?

Wrong email in the file.=20

>=20
>> +	SOC_DOUBLE("Input Path Digital Switch", CS42L73_ADCIPC, 0, 4, 1, =
1),
>=20
> s/Input Path/Capture/

got it
>=20
>> +	SOC_DOUBLE("Invert ADC Signal Polarity Switch", CS42L73_ADCIPC, =
1, 5, 1,
>> +			0),
>=20
> ADC Signal Polarity Switch.
>=20
>> +	SOC_DOUBLE("ADC Boost Switch", CS42L73_ADCIPC, 2, 6, 1, 0),
>=20
> This should be a Volume control with TLV information assuming it does
> what it sounds like and makes the signal louder.

This is just 0dB or 25dB so now it's just an enum if that's OK.

>=20
>> +	SOC_SINGLE("Charge Pump Frequency Volume", CS42L73_CPFCHC, 4, =
15, 0),
>=20
> No Volume (clearly this isn't a volume control), this should probably =
be
> an enum listing the rates.
>=20

Now enumerated

>> +	SOC_SINGLE("HL Limiter Attack Rate Volume", CS42L73_LIMARATEHL, =
0, 0x3F,
>> +			0),
>> +	SOC_SINGLE("HL Limiter Release Rate Volume", CS42L73_LIMRRATEHL, =
0,
>> +			0x3F, 0),
>=20
> Similarly here, you probably want an enumaration showing the rates.
>=20

This is a range of values that are used to set the rate by setting the =
step period size.
It's values are 0 - 3F.  I'm hoping to leave it as an SOC_SINGLE control =
if possible

>> +	SOC_DOUBLE_R_TLV("XSP-IP Attenuation Volume",
>> +			CS42L73_XSPAIPAA, CS42L73_XSPBIPBA, 0, 0x3F, 1,
>> +			attn_tlv),
>=20
> Attenuation Volume makes no sense - they're approximate synonyms.  =
Just
> Volume.
>=20
>> +	if (clk_id !=3D CS42L73_CLKID_MCLK1 && clk_id !=3D =
CS42L73_CLKID_MCLK2) {
>> +		dev_err(codec->dev, "Invalid clk_id %u\n", clk_id);
>> +		return -EINVAL;
>> +	}
>=20
> A switch statement would be more idomatic.
>=20
>> +	if (spc & xSPDIF_PCM) {
>> +		spc &=3D (31 << 3);	/* Clear PCM mode, set MSB->LSB =
*/
>> +		if (format =3D=3D SND_SOC_DAIFMT_DSP_B
>> +		    && inv =3D=3D SND_SOC_DAIFMT_IB_IF)
>> +			spc |=3D (xPCM_MODE0 << 4);
>> +		else
>> +
>> +		    if (format =3D=3D SND_SOC_DAIFMT_DSP_B
>> +				&& inv =3D=3D SND_SOC_DAIFMT_IB_NF)
>> +			spc |=3D (xPCM_MODE1 << 4);
>> +		else
>> +
>> +		    if (format =3D=3D SND_SOC_DAIFMT_DSP_A
>> +				&& inv =3D=3D SND_SOC_DAIFMT_IB_IF)
>> +			spc |=3D (xPCM_MODE1 << 4);
>> +		else
>> +			return -EINVAL;
>=20
> I can't help but feel this would be clearer with a switch statement.

I'm trying to make this look better...

>=20
>> +static int cs42l73_set_tristate(struct snd_soc_dai *dai, int =
tristate)
>> +{
>> +	struct snd_soc_codec *codec =3D dai->codec;
>> +	int id =3D dai->id;
>> +
>> +	return snd_soc_update_bits(codec, CS42L73_SPC(id), 0x7F, =
tristate << 7);
>=20
> This is going to fail if someone passes a non-boolean value in - =
better
> make sure that tristate is actually 1 or 0.
>=20
>> +
>> +	 .ops =3D &cs42l73_ops,
>> +	 .symmetric_rates =3D 1,
>> +	 },
>> +	{
>=20
> Please use the kernel coding style for indentation.
>=20
>> +
>> +/* CS42L73_PWRCTL1 */
>> +#define PDN_ADCB	(1 << 7)
>> +#define PDN_DMICB	(1 << 6)
>> +#define PDN_ADCA        (1 << 5)
>> +#define PDN_DMICA       (1 << 4)
>> +#define PDN_LDO         (1 << 2)
>> +#define DISCHG_FILT     (1 << 1)
>> +#define PDN             (1 << 0)
>=20
> All the identifiers in the header need to be namespaced.
>=20



--Apple-Mail=_89648963-052A-498F-A4DD-627E1758FD97
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
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTExMTAwNDE3NTM0NVowIwYJ
KoZIhvcNAQkEMRYEFNDZdsHDVE2a9qYn8ySOXpWgT1D7MHUGCSsGAQQBgjcQBDFoMGYwWDETMBEG
CgmSJomT8ixkARkWA2NvbTEWMBQGCgmSJomT8ixkARkWBmNpcnJ1czESMBAGCgmSJomT8ixkARkW
AmFkMRUwEwYDVQQDEwxhZC1DQVNVQjEtQ0ECCjk4E4kAAQAAEuwwdwYLKoZIhvcNAQkQAgsxaKBm
MFgxEzARBgoJkiaJk/IsZAEZFgNjb20xFjAUBgoJkiaJk/IsZAEZFgZjaXJydXMxEjAQBgoJkiaJ
k/IsZAEZFgJhZDEVMBMGA1UEAxMMYWQtQ0FTVUIxLUNBAgo5OBOJAAEAABLsMA0GCSqGSIb3DQEB
AQUABIIBAFevhVu6Xs4Hl05YhFAZ3Qi5RXuf6Gmf0WYmGztE9U6DZWuy0x/yHyMcxvRDV5o5dGFR
90GzRq4iUpJpM5g1llWhkEbagBDBJpVtdAfmapXWAphQXX7uurXFsX/7VU3JUhlQro8Upb3Sk5yE
VSs8cz/wGkgmtc/zM8T9faag0Ex017IOnANhUjWDooLlk1Becb8h6UWY8kGg7DMhHrYxJyCeDFhM
/MfqogFOovnEty4QRfivYiHXPO9nzrV5xazkf88dztQxsSazG73eF+5MEdE9TT1wdVUyN5XNBx7H
A/6PflDs9itcmT45YWkwvH6jdgMSQ1xFrduIknMB/oOMp6IAAAAAAAA=

--Apple-Mail=_89648963-052A-498F-A4DD-627E1758FD97--

--===============9214559004118670573==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9214559004118670573==--
