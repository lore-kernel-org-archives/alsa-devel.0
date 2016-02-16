From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 4/4] ASoC: simple-card: Support for selecting system
 clocks by ID
Date: Tue, 16 Feb 2016 11:46:52 +0200
Message-ID: <56C2F00C.8080809@ti.com>
References: <1455545495-20292-1-git-send-email-peter.ujfalusi@ti.com>
 <1455545495-20292-5-git-send-email-peter.ujfalusi@ti.com>
 <20160215152635.GN18988@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20160215152635.GN18988@sirena.org.uk>
Sender: linux-clk-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Jyri Sarha <jsarha@ti.com>, linux-clk@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Kristo, Tero" <t-kristo@ti.com>
List-Id: alsa-devel@alsa-project.org

On 02/15/2016 05:26 PM, Mark Brown wrote:
> On Mon, Feb 15, 2016 at 04:11:35PM +0200, Peter Ujfalusi wrote:
>=20
>> Most CPU and codec drivers can select their system clock from differ=
ent
>> sources. They rely on snd_soc_dai_set_sysclk(x, sysclk_id, x, x) to =
do so.
>> Add support for selecting which clock need to be selected along with=
 the
>> rate.
>=20
> Rather than adding new bindings for the ASoC specific clocking APIs i=
t
> seems better to use the standard clock API bindings and transition
> drivers to use that.  In the past the clock API didn't have DT bindin=
gs
> so wehad to do our own thing but I think now that's no longer the cas=
e?

McASP is relatively simple regarding to clocking and it is only problem=
atic in
case when it is master. When it is slave it is going to use the BCLK an=
d FS
coming from outside for clocking the data.

The driver currently only supports symmetric clocking, meaning we only =
use the
TX clock path (RX is using the TX clocks).
To generate the bit clock we have something like this:

[mcaspA_auxclkx_div]->
		    [mcaspA_hclkx_mux] -> [mcaspA_hclkx_div] -> [mcaspA_bclkx]
[mcaspA_ahclkx_in]  ->

If [mcaspA_auxclkx_div] is selected in [mcaspA_hclkx_mux], then:
[mcaspA_hclkx_mux] -> [mcaspA_ahclkx_out]
the HCLKX clock can be sent to mcaspA_ahclkx_out, as output from the So=
C.

mcaspA is mcasp0...number of MCASP in the SoC.

We would need three (or two if we decide to not represent the mcaspA_bc=
lkx)
simple clock node, two dividers and one mux.

We could have binding for this regarding to clocks:

/* McASP clk IDs */
#define MCASP_AUXCLKX_DIV	0
#define MCASP_AHCLKX_IN		1
#define MCASP_HCLKX_MUX		2
#define MCASP_HCLKX_DIV		3
#define MCASP_AHCLKX_OUT	4
#define MCASP_BCLK		5

/* dtsi file */
mcasp3: mcasp@48468000 {
	compatible =3D "ti,dra7-mcasp-audio";
	#clock-cells =3D <1>;
	clocks =3D <&mcasp3_aux_gfclk_mux>, <&mcasp3_ahclkx_mux>;
	clock-names =3D "fck", "ahclkx";
	assigned-clocks =3D <&mcasp3 MCASP_AHCLKX_IN>,
			  <&mcasp3 MCASP_AUXCLKX_DIV>;
	assigned-clock-parents =3D <&mcasp3_ahclkx_mux>,
				 <&mcasp3_aux_gfclk_mux>;
};

/* board dts */
&mcasp3 {
	assigned-clocks =3D <&mcasp3 MCASP_AHCLKX_IN>,
			  <&mcasp3 MCASP_AUXCLKX_DIV>,
			  <&mcasp3_ahclkx_mux>,
			  <&mcasp3 MCASP_HCLKX_MUX>;
	assigned-clock-parents =3D <&mcasp3_ahclkx_mux>,
				 <&mcasp3_aux_gfclk_mux>,
				 <&atl_clkin2_ck>,
				 <&mcasp3 MCASP_AHCLKX_IN>;
};

With this one we can set up the clock tree via clk bindings. Not sure h=
ow this
will work if audio including McASP is built as module?

There are couple of important questions regarding to this: if the
MCASP_HCLKX_DIV is not explicitly set the McASP driver will configure i=
t based
on the need for the starting stream (rate, bits, etc), but in some case=
 we
need to have different calculation since we want to have more bclk then=
 it is
needed for the audio data (bclk-fck ratio).

The clock tree within the McASP need to be built up inside of the code,=
 can
not be done via DT.

As for codecs, tlv320aic3106 is also pretty simple device from the outs=
ide, it
can receive it's reference clock via:
MCLK pin, GPIO2 pin or it can use the BCLK from the bus. Based on the i=
ncoming
frequency it can use it directly or it needs to use the internal PLL to
generate the cocks.
It can output generated clock via GPIO1

I don't think it will bring any clarity or features we miss right now i=
f we
try to move CPU and codec drivers to clk API. IMHO.

--=20
P=E9ter
