From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v4 1/7] dt-bindings: clk: at91: add an I2S mux clock
Date: Tue, 12 Jun 2018 01:06:05 -0700
Message-ID: <152879076578.16708.6230985334183790836@swboyd.mtv.corp.google.com>
References: <1527251668-31396-1-git-send-email-codrin.ciubotariu@microchip.com>
 <1527251668-31396-2-git-send-email-codrin.ciubotariu@microchip.com>
 <20180531005827.GA17203@rob-hp-laptop>
 <4f2e6e6a-df3a-b645-093c-b4467b3aa843@microchip.com>
 <CAL_JsqJ=T0p17hHg6=obtydt7T-yrAeOr7C2XAEnDFQ-c0b5XQ@mail.gmail.com>
 <152778070837.144038.4555982304713569160@swboyd.mtv.corp.google.com>
 <CAL_JsqJu6=ORfutZ5tAyNp2q2rH6P+fgJMRKw750RyFy=ptjPw@mail.gmail.com>
 <18f6871e-794d-3ea2-487e-32399a8b89b4@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <18f6871e-794d-3ea2-487e-32399a8b89b4@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Codrin Ciubotariu <codrin.ciubotariu@microchip.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Boris Brezillon <boris.brezillon@bootlin.com>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, linux-clk <linux-clk@vger.kernel.org>, Cristian.Birsan@microchip.com
List-Id: alsa-devel@alsa-project.org

Quoting Codrin Ciubotariu (2018-06-07 03:30:14)
> > =

> > Seems to me that clock additions could use a new binding and we start
> > with a new driver that handles these few clocks initially. But I
> > haven't looked whether both can coexist.
> =

> Mark already applied to broonie/sound.git the I2S bindings that have a =

> phandle to this clock. If I am to change #clock-cells to 1, I will have =

> to change the bindings to include the clock-id.
> Which approach should I take now?
> =


You're talking about changing the example in the binding doc? That
doesn't really matter. Consumer side of the provider has to match the
cell count from the provider so it doesn't really need to be 'fixed' in
the example at all.
