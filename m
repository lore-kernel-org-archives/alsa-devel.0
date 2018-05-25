From: Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: [PATCH] ASoC: ssm2602: Fix ADC powerup sequencing
Date: Fri, 25 May 2018 13:42:53 +0200
Message-ID: <20180525114253.jj6akdazsbxqkbfu@pengutronix.de>
References: <20180517133009.26079-1-m.felsch@pengutronix.de>
 <CAL_JsqKhkVOYf+XEA3MYpK4JYfMrZTbHZtoXgaH=wCBRoU6cfQ@mail.gmail.com>
 <1526640409.3948.5.camel@pengutronix.de>
 <20180523165352.GA6187@rob-hp-laptop>
 <20180525094724.3f4edofopk52i3v6@pengutronix.de>
 <20180525102609.GK4828@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [85.220.165.71])
 by alsa0.perex.cz (Postfix) with ESMTP id 383B7267663
 for <alsa-devel@alsa-project.org>; Fri, 25 May 2018 13:42:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20180525102609.GK4828@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de, devicetree@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 18-05-25 11:26, Mark Brown wrote:
> On Fri, May 25, 2018 at 11:47:24AM +0200, Marco Felsch wrote:
> =

> > I found the: "ti,charge-period (sound/ti,tas5086.txt)" binding which
> > represents nearly the same but it is not common. One opportunity would =
be to
> > introduce a common "charge-period-us" binding and change the ti binding=
 the
> > common binding later.
> =

> Are you sure what you have is a charge period and not some stabalization
> time or something?

According to the data sheet:
8<-----
As described in the Digital Core Clock section of the
Theory of Operation, insert enough delay time to charge
the VMID decoupling capacitor before setting the active
bit [Register R9, Bit D0].
8<-----
I think yes, it is a charge period.

Also the formula for the delay time (t =3D C =D7 25,000/3.5) depends only on
the capacity size.

Marco
