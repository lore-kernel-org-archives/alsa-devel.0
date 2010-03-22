From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 1/4] extend ad1938
 codec driver to ad193x supporting ad1936/7/8/9
Date: Mon, 22 Mar 2010 12:52:00 +0000
Message-ID: <20100322125159.GA1520@rakim.wolfsonmicro.main>
References: <20100318111848.GB3080@opensource.wolfsonmicro.com>
	<8bd0f97a1003180857vdd155e0o29684b50cbd5e34e@mail.gmail.com>
	<20100318162017.GA6142@rakim.wolfsonmicro.main>
	<8bd0f97a1003181017xba8e1a9oce2d40bf56818956@mail.gmail.com>
	<20100318180516.GF6142@rakim.wolfsonmicro.main>
	<8bd0f97a1003181108y3f7f5871t81c5cd5ba0c6312d@mail.gmail.com>
	<3c17e3571003182030mc8ea095u2298f008fbcbee8e@mail.gmail.com>
	<3c17e3571003190007p61929e99y4db8f5545e777401@mail.gmail.com>
	<20100319122422.GE23306@rakim.wolfsonmicro.main>
	<3c17e3571003212250l5464504erb47f814319a28f6b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6A61A24154
	for <alsa-devel@alsa-project.org>; Mon, 22 Mar 2010 13:52:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <3c17e3571003212250l5464504erb47f814319a28f6b@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Barry Song <barry.song@analog.com>, yi.li@analog.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 22, 2010 at 01:50:08PM +0800, Barry Song wrote:
> On Fri, Mar 19, 2010 at 8:24 PM, Mark Brown

> > =A0- The way you've factored out the bus probe and removal functions so
> > =A0 that there's no code in the individual I2C and SPI functions means
> > =A0 that the register() and unregister() functions could just be squash=
ed
> > =A0 into the bus_probe() and bus_remove() functions - all that the
> > =A0 register and unregister functions are is the code that's shared
> > =A0 between the bus

> if so, it likes register/unregister should be moved into probe/remove
> even for codecs with single codec?

I'm assuming you mean single bus?  If the code is structured like yours
with nothing in the per-bus probe/remove then definitely.  Note that
sometimes drivers do keep a split for multiple buses since the hardware
supports multiple buses but they've not all been implemented yet.
