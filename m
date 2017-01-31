From: Romain Perier <romain.perier@collabora.com>
Subject: Re: [PATCH v6 3/3] arm: dts: Add support for ES8388 to
 the Radxa Rock 2
Date: Tue, 31 Jan 2017 15:19:31 +0100
Message-ID: <e06b39ac-a72e-90d8-3e6b-c331719313fd@collabora.com>
References: <20170126132315.17955-1-romain.perier@collabora.com>
 <20170126132315.17955-4-romain.perier@collabora.com>
 <135092877.7rVIOCLxlb@phil>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by alsa0.perex.cz (Postfix) with ESMTP id A333726734C
 for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2017 15:19:35 +0100 (CET)
In-Reply-To: <135092877.7rVIOCLxlb@phil>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Heiko Stuebner <heiko@sntech.de>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-rockchip@lists.infradead.org, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Mark Brown <broonie@kernel.org>, Kumar Gala <galak@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

Hi Heiko,

Le 31/01/2017 =E0 14:23, Heiko Stuebner a =E9crit :
> Hi Romain,
>
> Am Donnerstag, 26. Januar 2017, 14:23:15 CET schrieb Romain Perier:
>> This commit adds the DT definition of the es8388 i2c device
>> found at address 0x10. It also adds the definition for connecting
>> the Rockchip I2S to the es8388 analog output.
>>
>> This commit is based on the initial work that was done by Sjoerd Simons
>> <sjoerd.simons@collabora.com> with some improvements.
>>
>> Signed-off-by: Romain Perier <romain.perier@collabora.com>
>> ---
>>
>> Changes in v6: None
>> Changes in v5: None
>> Changes in v4:
>>  - Updated to the new DT binding
>>  - Added the property 'rockchip,routing'
>>  - Renamed the node sound_es8388 to sound_i2s
>> Changes in v3: None
>> Changes in v2: None
>>
>>  arch/arm/boot/dts/rk3288-rock2-square.dts | 39
>> +++++++++++++++++++++++++++++++ 1 file changed, 39 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/rk3288-rock2-square.dts
>> b/arch/arm/boot/dts/rk3288-rock2-square.dts index dd3ad2e..6b176b8 100644
>> --- a/arch/arm/boot/dts/rk3288-rock2-square.dts
>> +++ b/arch/arm/boot/dts/rk3288-rock2-square.dts
>> @@ -86,6 +86,19 @@
>>  		#sound-dai-cells =3D <0>;
>>  	};
>>
>> +	sound_i2s {
>> +		compatible =3D "rockchip,rk3288-hdmi-analog";
>> +		rockchip,model =3D "I2S";
> Are you sure "I2S" is not to generic? Don't know enough about sound, but =

> remember this somehow matching against possible alsa ucm profiles.
>
> So this could maybe produce conflicts with such a generic name?

>From what I understood this is the name of the card that will be shown
by Alsa, including these displayed by aplay -L . The problem is this
driver will connect a cpu dai to multicodecs, one of these is an analog
output while the other one is a digital output... I am not sure that we
can really expose a different name.


>
>
>> +		rockchip,i2s-controller =3D <&i2s>;
>> +		rockchip,audio-codec =3D <&es8388>;
>> +		rockchip,routing =3D "Analog", "LOUT2",
>> +				   "Analog", "ROUT2";
>> +		rockchip,hp-en-gpios =3D <&gpio8 0 GPIO_ACTIVE_HIGH>;
>> +		rockchip,hp-det-gpios =3D <&gpio7 7 GPIO_ACTIVE_HIGH>;
>> +		pinctrl-names =3D "default";
>> +		pinctrl-0 =3D <&headphone>;
>> +	};
>> +
>>  	sdio_pwrseq: sdio-pwrseq {
>>  		compatible =3D "mmc-pwrseq-simple";
>>  		clocks =3D <&hym8563>;
>> @@ -173,10 +186,29 @@
>>  	};
>>  };
>>
>> +&i2c2 {
>> +	status =3D "okay";
>> +
>> +	es8388: es8388@10 {
>> +		compatible =3D "everest,es8388", "everest,es8328";
>> +		reg =3D <0x10>;
>> +		AVDD-supply =3D <&vcca_codec>;
>> +		DVDD-supply =3D <&vcca_codec>;
> According to the schematics I have, this comes from
> 	vccio_codec
> and thus from vcc_io
>
> So please give the regulator node simply a second phandle, like
> 	vcc_io: vccio_codec: REG2 {

Ok.

>
> and reference the correct regulator here.
> See DCDC_REG4 in rk3288-veyron.dtsi for reference.
>
>
>> +		HPVDD-supply =3D <&vcca_codec>;
>> +		PVDD-supply =3D <&vcca_codec>;
> vccio_codec as well

OK

>
>
>> +		clocks =3D <&cru SCLK_I2S0_OUT>;
>> +		clock-names =3D "i2s_clk_out";
>> +	};
>> +};
>> +
>>  &i2c5 {
>>  	status =3D "okay";
>>  };
>>
>> +&i2s {
>> +	status =3D "okay";
>> +};
>> +
>>  &pinctrl {
>>  	ir {
>>  		ir_int: ir-int {
>> @@ -190,6 +222,13 @@
>>  		};
>>  	};
>>
>> +	sound {
>> +		headphone: headphone {
>> +			rockchip,pins =3D <8 0 RK_FUNC_GPIO &pcfg_pull_up>,
>> +					<7 7 RK_FUNC_GPIO &pcfg_pull_none>;
> please use real pin names from schematics fro pinctrl entries when they a=
re =

> known. This makes greping for things easier.
>
> So please two separate definitions, "hp_det" and "phone_ctl".

Ok, I will change that.

Thanks,
Romain
