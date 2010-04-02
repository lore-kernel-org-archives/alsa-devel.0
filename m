From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4] ASoC: enable wm8753 in aspenite
Date: Fri, 2 Apr 2010 10:43:22 +0100
Message-ID: <20100402094322.GB11134@rakim.wolfsonmicro.main>
References: <s2g771cded01003310548udc9ff8b8u35736bd95038f92c@mail.gmail.com>
	<20100401182124.GB26650@opensource.wolfsonmicro.com>
	<l2u771cded01004012140pa41dac0egc067ce7a1cbeed0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 596622436E
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Apr 2010 11:43:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <l2u771cded01004012140pa41dac0egc067ce7a1cbeed0@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 02, 2010 at 12:40:30PM +0800, Haojian Zhuang wrote:
> On Fri, Apr 2, 2010 at 2:21 AM, Mark Brown

> >> +/* Get the MCLK frequency */
> >> +static int pxa168_get_mclk(int i)

> > This stuff probably shouldn't be in the machine driver since pretty much
> > all machine drivers are going to want exactly the same code - it should
> > be in the library code. =A0Probably best to have them take hw_params
> > rather than require the machine driver to decode the format, rate and
> > channel since that'll save a bit of per driver boiler plate if they
> > don't otherwise need that information.

> > As I said last time ideally machine drivers shouldn't have to see this
> > at all, of course.

> This functions is used to get the sysclk. It's the parameter that is
> used in hw_params() of machine driver since we need set codec and cpu
> sysclock. But hw_params() of machine driver is invoked before
> hw_params() of cpu_dai.

> That's the main reason. If hw_params() of cpu_dai is invoked before
> machine driver. This issue won't exist.

That's not the main point here - the code itself shouldn't be in the
machine driver since pretty much all machine drivers need exactly the
same code.  If they need to do this they should be calling functions
provided by the CPU driver rather than cut'n'pasting the code.
