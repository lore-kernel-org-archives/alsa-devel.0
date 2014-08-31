From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [RFC][PATCH] ASoC: simple-card: Merge single and muti DAI link
 code.
Date: Sun, 31 Aug 2014 18:27:25 +0200
Message-ID: <20140831182725.3135db4f@armhf>
References: <1409294797-21948-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1409294797-21948-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: broonie@kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Jyri Sarha <jsarha@ti.com>, Nicolin Chen <nicoleotsuka@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 29 Aug 2014 14:46:37 +0800
Xiubo Li <Li.Xiubo@freescale.com> wrote:

> This patch merge single DAI link and muti-DAI links code together,
> and simply the simple-card driver code.
>=20
> And also do some other improvement:
>=20
> Since from the DAI format micro SND_SOC_DAIFMT_CBx_CFx, the 'CBx'
> mean Codec's bit clock is as master/slave and the 'CFx' mean Codec's
> frame clock is as master/slave.
>=20
> So these same DAI formats should be informed to CPU and CODE DAIs at
> the same time. For the Codec driver will set the bit clock and frame
> clock as the DAI formats said, but for the CPU driver, if the the
> bit clock or frame clock is as Codec master, so it should be set CPU
> DAI device as bit clock or frame clock as slave, and vice versa.
>=20
> The old code will cause confusion, and we should be clear that the
> letter 'C' here mean to Codec.
>=20
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Cc: Jean-Francois Moine <moinejf@free.fr>
> Cc: Jyri Sarha <jsarha@ti.com>
> Cc: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>=20
> Hi,
>=20
> This patch will break the old DT, so i just send one RFC version, and
> will add the old DT patches in next version if this patch can work
> well.
>=20
> Any comments and advices are welcome.

Hi Xiubo,

My DT is

	sound {
		compatible =3D "simple-audio-card";
		simple-audio-card,name =3D "Cubox Audio";

		simple-audio-card,dai-link@0 {		/* I2S - HDMI */
			format =3D "i2s";
			cpu {
				sound-dai =3D <&audio1 0>;
			};
			codec {
				sound-dai =3D <&hdmi 0>;
			};
		};
	...

I was getting 0x1001 as the format (codec clk & FRM master and i2s').

With your patch, I get 0x4000 (clk master & frame slave and no format).

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
