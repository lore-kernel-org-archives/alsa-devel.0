From: "Austin, Brian" <Brian.Austin@cirrus.com>
Subject: Re: [PATCH] ASoC: Add support for Cirrus Logic CS42L73
 Codec
Date: Fri, 16 Sep 2011 14:26:11 +0000
Message-ID: <C093081D-DDB0-4D5F-A6BB-D651FE90A305@cirrus.com>
References: <1316097648-28066-1-git-send-email-brian.austin@cirrus.com>
	<20110916101720.GA25354@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5091679435011764921=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TX2EHSOBE006.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) by alsa0.perex.cz (Postfix) with ESMTP id 5B6EF2455E
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Sep 2011 16:26:29 +0200 (CEST)
In-Reply-To: <20110916101720.GA25354@sirena.org.uk>
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
Cc: "<alsa-devel@alsa-project.org>" <alsa-devel@alsa-project.org>, "<vinod.koul@linux.intel.com>" <vinod.koul@linux.intel.com>, "<joe@nucleusys.com>" <joe@nucleusys.com>, "<lrg@ti.com>" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

--===============5091679435011764921==
Content-Language: en-US
Content-Type: multipart/signed;
	boundary="Apple-Mail=_516727C0-6A67-4519-AF58-FACC930C807B";
	protocol="application/pkcs7-signature"; micalg=sha1

--Apple-Mail=_516727C0-6A67-4519-AF58-FACC930C807B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Sep 16, 2011, at 5:17 AM, Mark Brown wrote:
> On Thu, Sep 15, 2011 at 09:40:48AM -0500, Brian Austin wrote:
>> ---
>=20
> This patch can't be applied as you haven't signed it off.  Please =
follow
> the process in Documentation/SubmittingPatches, including the bit =
about
> always CCing maintainers on patches.
>=20
>> +#include <linux/i2c.h>
>> +#include <linux/platform_device.h>
>=20
> Platform device?
>=20
>> +struct  cs42l73_private {
>> +	enum snd_soc_control_type control_type;
>> +	void *control_data;
>> +	u8 reg_cache[CS42L73_CACHEREGNUM];
>=20
> Use the standard cache infrastructure, don't open code it.
>=20
>> +int cs42l73_write(struct snd_soc_codec *codec, unsigned reg, u_int =
val)
>> +{
>> +	u8 data[2];
>> +
>> +	if (reg > CS42L73_CACHEREGNUM)
>> +		return -EINVAL;
>=20
> Use the standard I/O infrastructure too.
>=20
>> +int cs42l73_get_volsw(struct snd_kcontrol *kcontrol,
>> +		      struct snd_ctl_elem_value *ucontrol)
>> +{
>> +	struct snd_soc_codec *codec =3D snd_kcontrol_chip(kcontrol);
>> +	struct soc_mixer_control *mc =3D
>> +	    (struct soc_mixer_control *)kcontrol->private_value;
>> +
>> +	unsigned int reg =3D mc->reg;
>> +	unsigned int shift =3D mc->shift;
>> +	unsigned int rshift =3D mc->rshift;
>> +	int max =3D mc->max;
>> +	int min =3D mc->min;
>> +	int mmax =3D (max > min) ? max:min;
>> +	unsigned int mask =3D (1 << fls(mmax)) - 1;
>> +
>> +	ucontrol->value.integer.value[0] =3D
>> +	    ((cs42l73_read(codec, reg) >> shift) - min) & mask;
>> +	if (shift !=3D rshift)
>> +		ucontrol->value.integer.value[1] =3D
>> +		    ((cs42l73_read(codec, reg) >> rshift) - min) & mask;
>=20
> Why is this open coded?  This doesn't look driver specific and...
>=20
>> +#define SOC_SINGLE_S8_C_TLV(xname, xreg, xshift, xmax, xmin, =
tlv_array) \
>> +{       .iface =3D SNDRV_CTL_ELEM_IFACE_MIXER, .name =3D xname, \
>=20
> ...the names given are obviously not driver specific names.
>=20
>> +/* ESL-ASP, ESL-XSP, SPK-ASP, SPK-XSP Mono Mixer Selects */
>> +static const struct soc_enum mono_mixer_enum[] =3D=20
>> +{
>> +	SOC_ENUM_SINGLE(CS42L73_MMIXCTL, 6,
>> +		ARRAY_SIZE (cs42l73_mono_mixer_text), =
cs42l73_mono_mixer_text),
>> +	SOC_ENUM_SINGLE(CS42L73_MMIXCTL, 4,
>> +		ARRAY_SIZE (cs42l73_mono_mixer_text), =
cs42l73_mono_mixer_text),
>> +	SOC_ENUM_SINGLE(CS42L73_MMIXCTL, 2,
>> +		ARRAY_SIZE (cs42l73_mono_mixer_text), =
cs42l73_mono_mixer_text),
>> +	SOC_ENUM_SINGLE(CS42L73_MMIXCTL, 0,
>> +		ARRAY_SIZE (cs42l73_mono_mixer_text), =
cs42l73_mono_mixer_text),
>> +};
>=20
> Don't use arrays of controls, use named variables.  Arrays are error
> prone when referencing.
>=20
>> +static const struct snd_kcontrol_new cs42l73_snd_controls[] =3D {
>> +/*=20
>> +    SOC_DOUBLE_R_S8_C (..., max, min)
>> +    min - min from CS datasheet
>> +    max - fls(max) - min + max from CS datasheet
>> +*/
>=20
> In general you've got rather a lot of comments pointing out very =
obvious
> things.
>=20
>> +/* Volume */
>=20
> Indentation here and throughout the table.
>=20
>> +	SND_SOC_DAPM_MICBIAS("MIC1 Bias", CS42L73_PWRCTL2, 6, 1),
>> +	SND_SOC_DAPM_INPUT("MIC2"),
>> +	SND_SOC_DAPM_MICBIAS("MIC2 Bias", CS42L73_PWRCTL2, 7, 1),
>=20
> Just use supply widgets.
>=20
>> +static int cs42l73_add_widgets(struct snd_soc_codec *codec)
>> +{
>> +	struct snd_soc_dapm_context *dapm =3D &codec->dapm;
>> +
>> +	snd_soc_dapm_new_controls(dapm, cs42l73_dapm_widgets,
>> +				  ARRAY_SIZE(cs42l73_dapm_widgets));
>> +	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
>=20
> Just initialize these using the driver structure.
>=20
>> +	/* MCLKX -> MCLK */
>> +	mclkx_coeff =3D cs42l74_get_mclkx_coeff(priv->sysclk);
>> +
>> +	if (mclkx_coeff < 0)=20
>> +		return -EINVAL;
>=20
> Better to pass through the error code you got.
>=20
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
>> +	if ((cs42l74_get_mclkx_coeff(freq) < 0)) {
>> +		dev_err(codec->dev, "Invalid sysclk %u\n", freq);
>> +		return -EINVAL;
>> +	}
>> +
>=20
> This ought to be a switch statement I think.
>=20
>> +	priv->sysclk =3D freq;
>> +	priv->mclksel =3D clk_id;
>> +
>> +	return cs42l73_set_mclk(dai);
>=20
> With this we could assign the variables and then fail.
>=20
>> +/*
>> +	cs42l73_set_dai_clkdiv()
>> +		Setup MCLKx, MMCC dividers.
>> +		The dividers are selected from the MCLKX and the=20
>> +		sample rate.=20
>> +*/
>=20
> Coding style.
>=20
>> +static int cs42l73_set_clkdiv(struct snd_soc_dai *codec_dai,
>> +                int div_id, int div)
>> +{
>> +        struct snd_soc_codec *codec =3D codec_dai->codec;
>> +	int id =3D codec_dai->id;
>> +        u8 reg;
>=20
> Indentation.
>=20
>> +        switch (div_id) {
>> +        case CS42L73_MCLKXDIV:
>> +		/* MCLKDIV */
>> +                reg =3D cs42l73_read(codec, CS42L73_DMMCC) & 0xf1;
>> +		cs42l73_write(codec, CS42L73_DMMCC,=20
>> +					reg | ((div & 0x07) << 1));
>=20
> Coding style and indentation are both bad here.  checkpatch should =
spot
> some of this.  You should use snd_soc_update_bits() too (and =
throughout
> the code), and the comment should be fairly obvious but actually =
doesn't
> agree with the constant.
>=20
> Also, why are users having to explicitly set this stuff, can't the
> driver work this out?
>=20
>> +static u32 cs42l73_asrc_rates[] =3D {
>> +	8000, 11025, 12000, 16000, 22050,
>> +	24000, 32000, 44100, 48000
>> +};
>> +
>> +static unsigned int cs42l73_get_xspfs_coeff(u32 rate)
>> +{
>> +	int i;
>> +	for (i =3D 0; i < ARRAY_SIZE(cs42l73_asrc_rates); i++) {
>> +		if (cs42l73_asrc_rates[i] =3D=3D rate)
>> +			return (i + 1);
>> +	}
>> +	return 0;		/* 0 =3D Don't know */
>> +}
>=20
> Shouldn't you return an error?
>=20
>> +
>> +static void cs42l73_update_asrc(struct snd_soc_codec *codec, int id, =
int srate)
>> +{
>> +	u8 spfs =3D 0;
>> +	u8 reg;
>> +=09
>> +	if (srate > 0)
>> +	  spfs =3D cs42l73_get_xspfs_coeff(srate);
>> +		 =20
>> +	switch (id) {
>> +	  case CS42L73_XSP:
>> +	    reg =3D cs42l73_read(codec, CS42L73_VXSPFS);
>=20
> Coding style.  There's a lot more issues than I've been pointing out, =
in
> general if your code doesn't visually resemble other Linux code =
there's
> an issue.
>=20
>> +	case SND_SOC_BIAS_STANDBY:
>> +	  /* Powerdown all ports, inputs and outputs */
>> +	  cs42l73_write(codec, CS42L73_DMMCC, dmmcc & ~ MCLKDIS);
>> +	 =20
>> + 	  cs42l73_write(codec, CS42L73_PWRCTL3,
>> +		      PDN_THMS | PDN_SPKLO | PDN_EAR |
>> +		      PDN_SPK | PDN_LO | PDN_HP);
>> +	 =20
>> +	  cs42l73_write(codec, CS42L73_PWRCTL2,
>> +		      PDN_MIC2_BIAS | PDN_MIC1_BIAS |
>> +		      PDN_VSP | PDN_ASP_SDOUT | PDN_ASP_SDIN |=20
>> +		      PDN_XSP_SDOUT | PDN_XSP_SDIN);
>> +	=20
>> +	  cs42l73_write(codec, CS42L73_PWRCTL1,
>> +		      PDN_ADCB | PDN_ADCA | PDN_DMICB |=20
>> +		      PDN_DMICA | PDN);
>> +	    break;
>=20
> This looks like it should all be managed by DAPM.
>=20
>> +static void cs42l73_shutdown(struct snd_pcm_substream *substream,
>> +                            struct snd_soc_dai *dai)
>> +{
>> +	struct snd_soc_codec *codec =3D dai->codec;
>> +	int id =3D dai->id;
>> +	struct cs42l73_private *priv =3D =
snd_soc_codec_get_drvdata(codec);
>> +	priv->config[id].srate =3D 0;
>> +	cs42l73_update_asrc(codec,id,0);
>> +}
>=20
> What happens with simultaneous playback and record?
>=20
>> +static int cs42l73_resume(struct snd_soc_codec *codec)
>> +{
>> +	int i;
>> +	u8 *cache =3D codec->reg_cache;
>> +=09
>> +	/* Sync reg_cache with the hardware */
>> +	for (i =3D CS42L73_PWRCTL1; i < ARRAY_SIZE(cs42l73_reg); i++) {
>> +		cs42l73_write(codec, i, cache[i]);
>> +	}
>=20
> There's standard infrastructure for this too.
>=20
>> +/* CS42L73_PWRCTL1 */
>> +#define PDN_ADCB	(1 << 7)
>> +#define PDN_DMICB	(1 << 6)=20
>> +#define PDN_ADCA        (1 << 5)
>> +#define PDN_DMICA       (1 << 4)
>> +#define PDN_LDO         (1 << 2)
>> +#define DISCHG_FILT     (1 << 1)
>> +#define PDN             (1 << 0)
>=20
> Namespacing here and elsewhere in the header.
>=20

Thanks for the quick feedback.  I will fix it up and resend. Sorry about =
the sloppy formatting.

Brian=

--Apple-Mail=_516727C0-6A67-4519-AF58-FACC930C807B
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
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTExMDkxNjE0MjYyM1owIwYJ
KoZIhvcNAQkEMRYEFNAyafGQ9Dcn9BEq5dVNgFkG50r6MHUGCSsGAQQBgjcQBDFoMGYwWDETMBEG
CgmSJomT8ixkARkWA2NvbTEWMBQGCgmSJomT8ixkARkWBmNpcnJ1czESMBAGCgmSJomT8ixkARkW
AmFkMRUwEwYDVQQDEwxhZC1DQVNVQjEtQ0ECCjk4E4kAAQAAEuwwdwYLKoZIhvcNAQkQAgsxaKBm
MFgxEzARBgoJkiaJk/IsZAEZFgNjb20xFjAUBgoJkiaJk/IsZAEZFgZjaXJydXMxEjAQBgoJkiaJ
k/IsZAEZFgJhZDEVMBMGA1UEAxMMYWQtQ0FTVUIxLUNBAgo5OBOJAAEAABLsMA0GCSqGSIb3DQEB
AQUABIIBAHqQBoNh4k5673QFvQCE4EdGDhI+NMaK18yUKz+RZ5EFeGAfkNPH7VvZIs+UrJ+x9Yaa
eMI1xUZ56hE6qBo+cXsd9lqaloYXgfAaLXXko02nkTO+5lirMMCksRYe5P7+h3YGn3Fq+F4TAssD
6KczYj8VUfLhw8EzhtjwIMujxxhesy1lE5pOVwmZJ2Ru1qNvxjgllpWhQGKp9jnOWfWTWk4bHNBQ
80UVzOL5/6MOlc3xfb8O3xKrofq5SrE/neX5PdGdVS1t/0PR3pSJXrE8ij5yLvxatwMnsdXtYBgE
3RrRJDq244slJ3y6ft/3xqbaT6Os+VgbGwAHPe5bVp1VxaUAAAAAAAA=

--Apple-Mail=_516727C0-6A67-4519-AF58-FACC930C807B--

--===============5091679435011764921==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5091679435011764921==--
