From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v4 2/7] clk: at91: add I2S clock mux driver
Date: Tue, 12 Jun 2018 09:33:24 -0700
Message-ID: <152882120419.16708.16947882037246176868@swboyd.mtv.corp.google.com>
References: <1527251668-31396-1-git-send-email-codrin.ciubotariu@microchip.com>
 <1527251668-31396-3-git-send-email-codrin.ciubotariu@microchip.com>
 <152778039660.144038.4743783065942615925@swboyd.mtv.corp.google.com>
 <d2558674-9aee-8b08-293f-34754fd2b185@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d2558674-9aee-8b08-293f-34754fd2b185@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>, alexandre.belloni@bootlin.com, alsa-devel@alsa-project.org, boris.brezillon@bootlin.com, broonie@kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.ferre@microchip.com, robh+dt@kernel.org
Cc: Cristian.Birsan@microchip.com
List-Id: alsa-devel@alsa-project.org

Quoting Codrin Ciubotariu (2018-06-04 01:20:29)
> On 31.05.2018 18:26, Stephen Boyd wrote:
> > Quoting Codrin Ciubotariu (2018-05-25 05:34:23)
> > =

> >> +       .get_parent =3D clk_i2s_mux_get_parent,
> >> +       .set_parent =3D clk_i2s_mux_set_parent,
> >> +       .determine_rate =3D __clk_mux_determine_rate,
> >> +};
> >> +
> >> +static struct clk_hw * __init
> >> +at91_clk_i2s_mux_register(struct regmap *regmap, const char *name,
> >> +                         const char * const *parent_names,
> >> +                         unsigned int num_parents, u32 bus_id)
> >> +{
> >> +       struct clk_init_data init =3D {};
> >> +       struct clk_i2s_mux *i2s_ck;
> >> +       int ret;
> >> +
> >> +       i2s_ck =3D kzalloc(sizeof(*i2s_ck), GFP_KERNEL);
> >> +       if (!i2s_ck)
> >> +               return ERR_PTR(-ENOMEM);
> >> +
> >> +       init.name =3D name;
> >> +       init.ops =3D &clk_i2s_mux_ops;
> >> +       init.parent_names =3D parent_names;
> >> +       init.num_parents =3D num_parents;
> >> +       init.flags =3D CLK_IGNORE_UNUSED;
> > =

> > Really? Why?
> =

> I am thinking that there is no need to gate this clock, since there is =

> no way to gate this clock in HW.

This flag is not necessary if the clk can't be gated via hardware
control registers. Please remove the flag.
