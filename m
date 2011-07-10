From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 02/10] ASoc: mxs: add mxs-saif driver
Date: Sun, 10 Jul 2011 17:34:02 +0900
Message-ID: <20110710083359.GB23199@opensource.wolfsonmicro.com>
References: <1310140790-2132-1-git-send-email-b29396@freescale.com>
	<1310140790-2132-3-git-send-email-b29396@freescale.com>
	<20110709025252.GC26900@sirena.org.uk>
	<CAA+hA=S0HTqNt+OxprdaqZMF8_9NF8G54UKJprcWc2DCbGf0xA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAA+hA=S0HTqNt+OxprdaqZMF8_9NF8G54UKJprcWc2DCbGf0xA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dong Aisheng <dongas86@gmail.com>
Cc: alsa-devel@alsa-project.org, Dong Aisheng <b29396@freescale.com>, s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Sun, Jul 10, 2011 at 04:17:13PM +0800, Dong Aisheng wrote:
> 2011/7/9 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> > On Fri, Jul 08, 2011 at 11:59:42PM +0800, Dong Aisheng wrote:

> >> + =A0 =A0 switch (clk_id) {
> >> + =A0 =A0 case MXS_SAIF_SYS_CLK:
> >> + =A0 =A0 =A0 =A0 =A0 =A0 clk_set_rate(saif->clk, freq);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(saif->clk);

> > How would one turn this clock off?

> Currenty simply enable clock always.

If that's what you're doing you should enable the clock when the device
is probed and disable it when the device is removed.  These repeated
enables will mean that you're constantly leaking references.

> The problem is that the codec may use the MCLK supplied by SAIF as its
> system clock for normal operations such as i2c r/w.

That may be true for your particular system but it is not going to be
true in general - most devices can handle having their MCLK removed.

> If we disable it after playback or capture. The automatic dapm
> operations of codec may fail on i2c r/w. Will check if dapm has any
> machnism to avoid this.
> Can you share your experience ont this issue?

You should ideally let the machine driver or other system integration
code control if the clock is constantly enabled, or at the very least
control it from the probe and remove.

> >> +static irqreturn_t mxs_saif_irq(int irq, void *dev_id)
> >> +{
> >> + =A0 =A0 struct mxs_saif *saif =3D dev_id;
> >> +
> >> + =A0 =A0 if (saif->fifo_err_counter++ % 100 =3D=3D 0)
> >
> > The rate limit looks awfully suspicious...
> Originally it's just for printing less error messages when the issue happ=
ens.
> I could remove the rate limit.

Please do so.

> >> + =A0 =A0 clk_set_rate(saif->clk, 12000000);
> >> + =A0 =A0 clk_enable(saif->clk);

> > How did you pick this clock rate and why does it need to be set? =A0It's
> > not an obvious audio rate...

> It's initial clock rate for normal operations of codecs based on MCLK.
> We found the default MCLK ouput(only about 7.3Khz) can not work for codec=
s like
> sgtl5000 for its initialization since its clock range is 8Mhz~27Mhz.
> So we set a common working clock 12Mhz here.
> Maybe i should try to set it elsewhere or just set it via platform data.

This is the same issue as the above one with repeated enables?  You
should delegate the rate selection and ideally also the enable control
to the machine driver, it can set something in its probe() function.
