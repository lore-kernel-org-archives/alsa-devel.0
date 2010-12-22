From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add initial WM8995 driver
Date: Wed, 22 Dec 2010 11:07:52 +0000
Message-ID: <20101222110752.GB12426@opensource.wolfsonmicro.com>
References: <1292951800-16694-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<1292963892.3296.56.camel@odin>
	<1293013616.29185.55.camel@dplaptop.localdomain>
	<1293015279.3329.11.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 687001038B0
	for <alsa-devel@alsa-project.org>; Wed, 22 Dec 2010 12:07:39 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1293015279.3329.11.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 22, 2010 at 10:54:39AM +0000, Liam Girdwood wrote:
> On Wed, 2010-12-22 at 10:26 +0000, Dimitris Papastamos wrote:
> > On Tue, 2010-12-21 at 20:38 +0000, Liam Girdwood wrote:
> > > On Tue, 2010-12-21 at 17:16 +0000, Dimitris Papastamos wrote:

> > > > +static int wm8995_volatile(unsigned int reg)
> > > > +{
> > > > +	if (reg >= WM8995_MAX_REGISTER + 1)
> > > > +		return 1;
> > > > +

> > > return -EINVAL here.

> > The logic behind this is that out of bounds registers are considered
> > volatile. 

> It does look a little odd since out of bounds generally means invalid. 

Most of the drivers that use this idiom use a constant like
MAX_CACHED_REGISTER or similar which makes it clearer that there are
more registers beyond the end of the register map.  The normal use is to
allow access to partially documented diagnostic registers or to support
register banks that are partially owned by something else (devices with
an embedded DSP being the most obvious example).

> > I've found one call to dc_servo_cmd() using a magic number.  The dapm
> > widgets and the kcontrols don't generally use the macros since the lines
> > become very long.

> There are also some magic numbers in configure_aif_clock,
> wm8995_set_dai_fmt, wm8995_hw_params. It's possible there are no macros
> defined for these numbers though...

Those are all bitfield values IIRC - our register map generation tool is
only smart enough to generate register and full field wide constants, it
can't manage to generate constants for the values that go in bitfields
(yet!).
