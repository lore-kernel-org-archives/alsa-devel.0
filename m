From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 03/10] ASoc: mxs: add mxs-sgtl5000 machine driver
Date: Sun, 10 Jul 2011 17:40:27 +0900
Message-ID: <20110710084021.GE23199@opensource.wolfsonmicro.com>
References: <1310140790-2132-1-git-send-email-b29396@freescale.com>
	<1310140790-2132-4-git-send-email-b29396@freescale.com>
	<20110709030008.GD26900@sirena.org.uk>
	<CAA+hA=TirfTs9WB19snuH2HhmJvaxApEg2H1oT2BwQwPkTOuUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAA+hA=TirfTs9WB19snuH2HhmJvaxApEg2H1oT2BwQwPkTOuUA@mail.gmail.com>
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

On Sun, Jul 10, 2011 at 04:36:44PM +0800, Dong Aisheng wrote:
> 2011/7/9 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> > On Fri, Jul 08, 2011 at 11:59:43PM +0800, Dong Aisheng wrote:

> >> + =A0 =A0 int (*init) (void); =A0 =A0 /* board specific init */
> >> + =A0 =A0 int (*finit) (void); =A0 =A0/* board specific finit */

> > Eh? =A0Your machine driver is already entirely board specific...

> Still not.

> It's originally used for some board's codec that do not need SAIF to
> provide mclk.
> I will remove it if we still do not need it to make the things simply.

If you've got different CODECs you almost certainly want to have
different machine drivers for the relevant boards.
