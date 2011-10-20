From: "Austin, Brian" <Brian.Austin@cirrus.com>
Subject: Re: [PATCH v5] ASoC:Add support for cs42l73 codec
Date: Thu, 20 Oct 2011 13:54:06 +0000
Message-ID: <EE74D414-85CB-4382-B495-46842866C963@cirrus.com>
References: <1318952816-16983-1-git-send-email-brian.austin@cirrus.com>
	<1319013770.23438.184.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1737633151334255163=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TX2EHSOBE005.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) by alsa0.perex.cz (Postfix) with ESMTP id 55553247B7
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Oct 2011 15:54:44 +0200 (CEST)
In-Reply-To: <1319013770.23438.184.camel@vkoul-udesk3>
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
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: "<alsa-devel@alsa-project.org>" <alsa-devel@alsa-project.org>, "<broonie@opensource.wolfsonmicro.com>" <broonie@opensource.wolfsonmicro.com>, "<ramesh.babu@intel.com>" <ramesh.babu@intel.com>, "<joe@nucleusys.com>" <joe@nucleusys.com>, "<heelrod@heelrod.ad.cirrus.com>" <heelrod@heelrod.ad.cirrus.com>, "jeeja.kp" <jeeja.kp@intel.com>, "<lrg@ti.com>" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

--===============1737633151334255163==
Content-Language: en-US
Content-Type: multipart/signed;
	boundary="Apple-Mail=_F9A66C5F-CB17-433C-B43C-7615966E0C4D";
	protocol="application/pkcs7-signature"; micalg=sha1

--Apple-Mail=_F9A66C5F-CB17-433C-B43C-7615966E0C4D
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii


On Oct 19, 2011, at 3:42 AM, Vinod Koul wrote:

> On Tue, 2011-10-18 at 10:46 -0500, Brian Austin wrote:
>> +static const struct snd_soc_dapm_route cs42l73_audio_map[] = {
>> +
>> +       {"HPOUT", NULL, "HP Amp"},
>> +       {"LINEOUT", NULL, "LO Amp"},
>> +       {"SPKOUT", NULL, "SPK Amp"},
>> +       {"EAROUT", NULL, "EAR Amp"},
>> +       {"SPKLINEOUT", NULL, "SPKLO Amp"},
>> +
>> +       {"HP Amp", "Switch", "DAC1"},
>> +       {"LO Amp", "Switch", "DAC1"},
>> +       {"SPK Amp", "Switch", "DAC2"},
>> +       {"SPKLO Amp", "Switch", "DAC2"},
>> +       {"EAR Amp", "Switch", "DAC2"},
>> + 
> Since you have a mixer in codec before each of the amp, who is going to
> configure those? And how are they represented here?
> 
> -- 
> ~Vinod
> 
> 
The mixer in the codec is configured by the Attenuation mixer controls.
You then select the mono/stereo output with the xSP Output Mixer Select.
I didn't think we needed to represent that in the DAPM map.
--Apple-Mail=_F9A66C5F-CB17-433C-B43C-7615966E0C4D
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
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTExMTAyMDEzNTQzNlowIwYJ
KoZIhvcNAQkEMRYEFIzn5zhY8tLLRtjzNNsrW7jdXO/+MHUGCSsGAQQBgjcQBDFoMGYwWDETMBEG
CgmSJomT8ixkARkWA2NvbTEWMBQGCgmSJomT8ixkARkWBmNpcnJ1czESMBAGCgmSJomT8ixkARkW
AmFkMRUwEwYDVQQDEwxhZC1DQVNVQjEtQ0ECCjk4E4kAAQAAEuwwdwYLKoZIhvcNAQkQAgsxaKBm
MFgxEzARBgoJkiaJk/IsZAEZFgNjb20xFjAUBgoJkiaJk/IsZAEZFgZjaXJydXMxEjAQBgoJkiaJ
k/IsZAEZFgJhZDEVMBMGA1UEAxMMYWQtQ0FTVUIxLUNBAgo5OBOJAAEAABLsMA0GCSqGSIb3DQEB
AQUABIIBAJTD7noP9A0xnBa+gJxCBXDcOx/Ic4TRQn0JdI7f7UU5fOnQcwg5gjvGZVCM/J9sua+t
FmYUpB88XDnPd919VlBLK3WGC+rnnDfvDc6t3XjmHKH4Q/iW/fEj/NmQQQRY14Z7nl4CXvHuY3AD
fJXQ+bp/RiCTX/4fvxrvz+JZStmbAj1mb79eqYWr7HRUXIhvv9wkkFtwGHsfwsPq8zWnjRQU6dTS
szHMks6kjWuUHQmpgvE/QwMKmvCHkFvH214NgyO9N9QRkJAMyh+8BFsp8qyPBvFxw9HEfAcFUDou
By3926QmKYdxem+IjEdJaQ1IpAWB6HlyCvy3fA2D27/eO4AAAAAAAAA=

--Apple-Mail=_F9A66C5F-CB17-433C-B43C-7615966E0C4D--

--===============1737633151334255163==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1737633151334255163==--
