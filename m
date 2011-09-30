From: "Austin, Brian" <Brian.Austin@cirrus.com>
Subject: Re: [PATCH v2] ASoC: Add support for cs42l73 codec
Date: Fri, 30 Sep 2011 19:19:56 +0000
Message-ID: <F3ABE72F-913B-4A61-9B1D-F8031F701CF4@cirrus.com>
References: <1317400912-5789-1-git-send-email-brian.austin@cirrus.com>
	<4E860F7E.909@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3858740293786893449=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from AM1EHSOBE001.bigfish.com (am1ehsobe001.messaging.microsoft.com
	[213.199.154.204])
	by alsa0.perex.cz (Postfix) with ESMTP id E196E1037EE
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Sep 2011 21:21:25 +0200 (CEST)
In-Reply-To: <4E860F7E.909@metafoo.de>
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
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "lrg@ti.com" <lrg@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Vinod Koul <vinod.koul@linux.intel.com>, Georgi Vlaev <joe@nucleusys.com>
List-Id: alsa-devel@alsa-project.org

--===============3858740293786893449==
Content-Language: en-US
Content-Type: multipart/signed;
	boundary="Apple-Mail=_55EA763F-0B02-4376-A0FA-0A0D88AE2E01";
	protocol="application/pkcs7-signature"; micalg=sha1

--Apple-Mail=_55EA763F-0B02-4376-A0FA-0A0D88AE2E01
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Sep 30, 2011, at 1:50 PM, Lars-Peter Clausen wrote:
> On 09/30/2011 06:41 PM, Brian Austin wrote:
>> This patch adds support for the Cirrus Logic CS42L73
>> low power stereo codec.
>>=20
>> This patch has cleared checkpatch.pl with no warnings or errors.
>> Code changes requested were implemented.
>> ASoC API changes requested were implemented.
>>=20
>> Signed-off-by: Brian Austin <brian.austin@cirrus.com>
>> ---
>> [...]
>> +struct  cs42l73_private {
>=20
> extra space
>=20
>> [...]
>> +
>> +static const struct snd_soc_dapm_route cs42l73_audio_map[] =3D {
>> +	{"HPOUTA", NULL, "HP Amp Left"},
>> +	{"HPOUTB", NULL, "HP Amp Right"},
>> +	{"LINEOUTA", NULL, "LO Amp Left"},
>> +	{"LINEOUTB", NULL, "LO Amp Right"},
>> +	{"SPKOUT", NULL, "SPK Amp"},
>> +	{"EAROUT", NULL, "EAR Amp"},
>> +	{"SPKLINEOUT", NULL, "SPKLO Amp"},
>> +
>> +	{"HP Amp Left", "DAC", "DAC Left"},
>> +	{"HP Amp Right", "DAC", "DAC Right"},
>> +	{"LO Amp Left", "DAC", "DAC Left"},
>> +	{"LO Amp Right", "DAC", "DAC Right"},
>> +	{"SPK Amp", "DAC", "DAC Left"},
>> +	{"SPKLO Amp", "DAC", "DAC Right"},
>> +	{"EAR Amp", "DAC", "DAC Right"},
>=20
> I suppose this won't work as expected. The control element of the path =
will
> only have an effect if the sink is a mixer or a mux.
>=20
>> +
>> +	{"PGA Mux Left", NULL, "LINEINA"},
>> +	{"PGA Mux Right", NULL, "LINEINB"},
>> +	{"PGA Mux Left", NULL, "MIC1"},
>> +	{"PGA Mux Right", NULL, "MIC2"},
>=20
> You probably want connect the inputs of the mux depending on its =
setting.
>=20
> e.g. {"PGA Mux Left", "Line A", "LINEINA"},
>=20
> [...]
>> +
>> +struct cs42l73_mclk_div cs42l73_mclk_coeffs[] =3D {
>=20
> static
>=20
>> [...]
>> +
>> +struct cs42l73_mclkx_div cs42l73_mclkx_coeffs[] =3D {
>=20
> static
>=20
>> [...]
>> +int cs42l73_get_mclkx_coeff(int mclkx)
>=20
> static
>=20
>> [...]
>> +int cs42l73_get_mclk_coeff(int mclk, int srate)
>=20
> static
>=20
>=20
>> +
>> +static int cs42l73_set_mclk(struct snd_soc_dai *dai)
>> +{
>> +	struct snd_soc_codec *codec =3D dai->codec;
>> +	struct cs42l73_private *priv =3D =
snd_soc_codec_get_drvdata(codec);
>> +
>> +	int mclkx_coeff;
>> +	u32 mclk =3D 0;
>> +	u8 dmmcc =3D 0;
>> +
>> +	/* MCLKX -> MCLK */
>> +	mclkx_coeff =3D cs42l73_get_mclkx_coeff(priv->sysclk);
>> +
>=20
> here you use priv->sysclk ...
>=20
>> +
>> +static int cs42l73_set_sysclk(struct snd_soc_dai *dai,
>> +			      int clk_id, unsigned int freq, int dir)
>> +{
>> +	struct snd_soc_codec *codec =3D dai->codec;
>> +	struct cs42l73_private *priv =3D =
snd_soc_codec_get_drvdata(codec);
>> +
>> +	if (clk_id !=3D CS42L73_CLKID_MCLK1 && clk_id !=3D =
CS42L73_CLKID_MCLK2) {
>> +		dev_err(codec->dev, "Invalid clk_id %u\n", clk_id);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if ((cs42l73_get_mclkx_coeff(freq) < 0)) {
>> +		dev_err(codec->dev, "Invalid sysclk %u\n", freq);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if ((cs42l73_set_mclk(dai)) < 0) {
>> +		dev_err(codec->dev, "Unable to set MCLK for dai %s\n",
>> +			dai->name);
>> +		return -EINVAL;
>> +	}
>> +
>> +	priv->sysclk =3D freq;
>> +	priv->mclksel =3D clk_id;
>> +
>=20
> ... but here you only set it after having called cs42l73_set_mclk. Is =
this
> correct? Maybe pass it in as a parameter to cs42l73_set_mclk
>=20
>> +	return 0;
>> +}
>> +
>> +static int cs42l73_set_dai_fmt(struct snd_soc_dai *codec_dai, =
unsigned int fmt)
>> +{
>> +	struct snd_soc_codec *codec =3D codec_dai->codec;
>> +	struct cs42l73_private *priv =3D =
snd_soc_codec_get_drvdata(codec);
>> +	int id =3D codec_dai->id;
>> +	int inv, format;
>=20
> unsigned int
>=20
>> +	u8 spc, mmcc;
>> +
>> [...]
>> +
>=20
>> +static int cs42l73_set_bias_level(struct snd_soc_codec *codec,
>> +				  enum snd_soc_bias_level level)
>> +{
>> +	int ret;
>> +
>> +	switch (level) {
>> +	case SND_SOC_BIAS_ON:
>> +		snd_soc_update_bits(codec, CS42L73_DMMCC, MCLKDIS, 0);
>> +		snd_soc_update_bits(codec, CS42L73_PWRCTL1, PDN, 0);
>> +		break;
>> +
>> +	case SND_SOC_BIAS_PREPARE:
>> +		break;
>> +
>> +	case SND_SOC_BIAS_STANDBY:
>> +		if (codec->dapm.bias_level =3D=3D SND_SOC_BIAS_OFF) {
>> +				ret =3D snd_soc_cache_sync(codec);
>=20
> indention
>=20
>> [...]
>> +
>> +static struct snd_soc_dai_ops cs42l73_ops =3D {
>=20
> const
>=20
>> +	.startup =3D cs42l73_pcm_startup,
>> +	.hw_params =3D cs42l73_pcm_hw_params,
>> +	.set_fmt =3D cs42l73_set_dai_fmt,
>> +	.set_sysclk =3D cs42l73_set_sysclk,
>> +	.set_tristate =3D cs42l73_set_tristate,
>> +};
>> +
>> +struct snd_soc_dai_driver cs42l73_dai[] =3D {
>=20
> static
>=20
>> +	{
>> +	 .name =3D "cs42l73-xsp",
>> +	 .id =3D CS42L73_XSP,
>> +	 .playback =3D {
>> +		      .stream_name =3D "XSP Playback",
>> +		      .channels_min =3D 1,
>> +		      .channels_max =3D 2,
>> +		      .rates =3D CS42L73_RATES,
>> +		      .formats =3D CS42L73_FORMATS,},
>> +
>> +	 .capture =3D {
>> +		     .stream_name =3D "XSP Capture",
>> +		     .channels_min =3D 1,
>> +		     .channels_max =3D 2,
>> +		     .rates =3D CS42L73_RATES,
>> +		     .formats =3D CS42L73_FORMATS,},
>> +
>> +	 .ops =3D &cs42l73_ops,
>> +	 .symmetric_rates =3D 1,
>> +	 },
>=20
> Indention looks a bit odd here
>=20
>> [...]
>> +static int cs42l73_probe(struct snd_soc_codec *codec)
>> +{
>> +	int ret;
>> +	unsigned int devid =3D 0;
>> +	struct cs42l73_private *cs42l73 =3D =
snd_soc_codec_get_drvdata(codec);
>> +
>> +	codec->control_data =3D cs42l73->control_data;
>> +	codec->hw_write =3D (hw_write_t)i2c_master_send;
>=20
> You don't need to initialize control_data and hw_write.
> snd_soc_codec_set_cache_io will do this for you. This also means that =
you can
> remove the control_data field from your driver private data struct.
>=20
>> +
>> +	ret =3D snd_soc_codec_set_cache_io(codec, 8, 8, =
cs42l73->control_type);
>=20
> If you CODEC only has a I2C interface you can use SND_SOC_I2C here =
directly
> instead of cs42l73->control_type
>=20
>> [...]
>> +
>> +	snd_soc_add_controls(codec, cs42l73_snd_controls,
>> +			     ARRAY_SIZE(cs42l73_snd_controls));
>=20
> Just put the controls in your codec driver struct instead of manually =
adding them.
>=20
>> +
>> +	return ret;
>> +}
>> +
>> +static int cs42l73_remove(struct snd_soc_codec *codec)
>> +{
>> +	cs42l73_set_bias_level(codec, SND_SOC_BIAS_OFF);
>> +	return 0;
>> +}
>> +
>> +struct snd_soc_codec_driver soc_codec_dev_cs42l73 =3D {
>=20
> static
>=20
>> +	.probe =3D cs42l73_probe,
>> +	.remove =3D cs42l73_remove,
>> +	.suspend =3D cs42l73_suspend,
>> +	.resume =3D cs42l73_resume,
>> +	.set_bias_level =3D cs42l73_set_bias_level,
>> +	.reg_cache_size =3D ARRAY_SIZE(cs42l73_reg),
>> +	.reg_cache_default =3D cs42l73_reg,
>> +	.reg_word_size =3D sizeof(u8),
>> +	.dapm_widgets =3D cs42l73_dapm_widgets,
>> +	.num_dapm_widgets =3D ARRAY_SIZE(cs42l73_dapm_widgets),
>> +	.dapm_routes =3D cs42l73_audio_map,
>> +	.num_dapm_routes =3D ARRAY_SIZE(cs42l73_audio_map),
>> +};
>> +
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>=20

Thanks for the feedback.  This is good.  The DAPM Routing works with a =
machine driver, but i will have to=20
make it work inside the codec I guess.

Thanks,
Brian=

--Apple-Mail=_55EA763F-0B02-4376-A0FA-0A0D88AE2E01
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
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTExMDkzMDE5MjAwOFowIwYJ
KoZIhvcNAQkEMRYEFKgwryNp2lXSlC/ha7jwrYiNxS+TMHUGCSsGAQQBgjcQBDFoMGYwWDETMBEG
CgmSJomT8ixkARkWA2NvbTEWMBQGCgmSJomT8ixkARkWBmNpcnJ1czESMBAGCgmSJomT8ixkARkW
AmFkMRUwEwYDVQQDEwxhZC1DQVNVQjEtQ0ECCjk4E4kAAQAAEuwwdwYLKoZIhvcNAQkQAgsxaKBm
MFgxEzARBgoJkiaJk/IsZAEZFgNjb20xFjAUBgoJkiaJk/IsZAEZFgZjaXJydXMxEjAQBgoJkiaJ
k/IsZAEZFgJhZDEVMBMGA1UEAxMMYWQtQ0FTVUIxLUNBAgo5OBOJAAEAABLsMA0GCSqGSIb3DQEB
AQUABIIBAGMADPK9FWOlYzwdaor/PFS1LuqNxiHM3FtYAZ+clByfSDm5wKJHA7nipbzv3v0Xtd6R
SEnn+t5XZSnH57xkBD7ETdOOJ7CFgUqZJcX//yrSa37MKp/QZE5OcQOTQ+m7jFE+HCUFIwx68l/l
V5Agq9fJ/w/GKN6CG6jYidPGrnM2w4ORx1dkGLT5SpIXwzXuNz7LPjQuahn6TW1psTVdb9TM0iGP
43ZWTsVJNQd4FwsWzZz6+VUAFGi76H3jFYs44nvC5DND2fz7S/Zhz59dKVYS3t66JZb2DwsH+QwZ
7bEeFGUayZAplF7gEoWbeiVm2Fw1sSFiRBNwCYfknkSrTrIAAAAAAAA=

--Apple-Mail=_55EA763F-0B02-4376-A0FA-0A0D88AE2E01--

--===============3858740293786893449==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3858740293786893449==--
