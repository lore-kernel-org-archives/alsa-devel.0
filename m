From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Add new TI TLV320AIC3204 CODEC driver
Date: Fri, 18 Jun 2010 12:01:02 +0100
Message-ID: <1276858862.3054.28.camel@odin>
References: <1276833465-31702-1-git-send-email-redhatter@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1276833465-31702-1-git-send-email-redhatter@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stuart Longland <redhatter@gentoo.org>
Cc: ALSA Development List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-06-18 at 13:57 +1000, Stuart Longland wrote:
> The TLV320AIC3204 is a low-power stereo audio CODEC capable of sample
> rates of up to 192kHz.  This driver implements basic functionality,
> using I=C2=B2C for the control channel.
>=20
> The audio interface supports many data bus formats, including I=C2=B2=
S
> master/slave, DSP, left/right justified and TDM.
>=20
> What works:
> 	- Playback at various bitrates up to 96kHz
> 	- Recording at various bitrates up to 96kHz
> 	- Mixer interface
> 	- PLL generation of CODEC clocks from MCLK
>=20
> What could work better:
> 	- DAPM
>=20
> What isn't tested:
> 	- Audio interfaces other than I=C2=B2S
> 	- PLL with clocks other than ~12MHz
> 	- Mono recording/playback
> 	- 192kHz recording/playback
>=20
> What isn't implemented:
> 	- SPI interface support
> 	- PLL without fractional divider (would allow <10MHz clocks)
> 	- Clock sources other than MCLK
> 	- Adaptive filtering
> 	- AGC
> 	- Headset detection, JACK framework
>=20
> Signed-off-by: Stuart Longland <redhatter@gentoo.org>

Just had a quick check and the register caching needs addressed.

I agree with your comments, I don't think we really want to cache all
16K of codec registers here as we will probably only ever use a handful
of them. I think a smaller lookup table containing only the registers
that we care about will do.

=46wiw, a generic ASoC lookup table would be best as this could be used=
 by
other codecs with large register maps too. The table should be ordered
(for quick lookup) and also contain a readable/writeable/volatile flag
for each register.

Thanks

Liam
--=20
=46reelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
