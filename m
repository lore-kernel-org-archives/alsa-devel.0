From: <Codrin.Ciubotariu@microchip.com>
Subject: Re: [PATCH 2/2] ASoC: codecs: ad193x: Reset DAC Control 1 register at
 probe
Date: Wed, 26 Jun 2019 12:16:35 +0000
Message-ID: <60a36381-f2f3-18de-3f7c-4e51fc75445e@microchip.com>
References: <20190626104947.26547-1-codrin.ciubotariu@microchip.com>
 <20190626104947.26547-2-codrin.ciubotariu@microchip.com>
 <20190626112331.GB5316@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190626112331.GB5316@sirena.org.uk>
Content-Language: en-US
Content-ID: <56F9F74196D8B244A690BADBF5F0899C@namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, lars@metafoo.de, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

On 26.06.2019 14:23, Mark Brown wrote:
> On Wed, Jun 26, 2019 at 01:49:47PM +0300, Codrin Ciubotariu wrote:
>> Since the ad193x codecs have no software reset, we have to reinitialize =
the
>> registers after a hardware reset. For example, if we change the
>> device-tree between these resets, changing the audio format of the DAI l=
ink
>> from DSP_A with 8 TDM channels to I2S 2 channels, DAC Control 1 register
>> will remain configured for 8 channels. This patch resets this register a=
t
>> probe to its default value.
>=20
> Would it not be more robust/complete to have a set of register defaults
> and write the whole lot out rather than individually going through and
> adding writes for specific registers as needed?
>=20

It would indeed. I will make two patches, one that implements what you=20
suggested, for the registers that we touch only, and another one that=20
will add AD193X_DAC_CTRL1 to these defaults. You can drop this patch.

Thanks and best regards,
Codrin
