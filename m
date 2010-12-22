From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add initial WM8995 driver
Date: Wed, 22 Dec 2010 11:29:40 +0000
Message-ID: <1293017380.29185.59.camel@dplaptop.localdomain>
References: <1292951800-16694-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<1292963892.3296.56.camel@odin>
	<1293013616.29185.55.camel@dplaptop.localdomain>
	<1293015279.3329.11.camel@odin>
	<20101222110752.GB12426@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3BE1A1038C3
	for <alsa-devel@alsa-project.org>; Wed, 22 Dec 2010 12:28:30 +0100 (CET)
In-Reply-To: <20101222110752.GB12426@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-12-22 at 11:07 +0000, Mark Brown wrote:
> On Wed, Dec 22, 2010 at 10:54:39AM +0000, Liam Girdwood wrote:
> > On Wed, 2010-12-22 at 10:26 +0000, Dimitris Papastamos wrote:
> > > On Tue, 2010-12-21 at 20:38 +0000, Liam Girdwood wrote:
> > > > On Tue, 2010-12-21 at 17:16 +0000, Dimitris Papastamos wrote:
> 
> > > > > +static int wm8995_volatile(unsigned int reg)
> > > > > +{
> > > > > +	if (reg >= WM8995_MAX_REGISTER + 1)
> > > > > +		return 1;
> > > > > +
> 
> > > > return -EINVAL here.
> 
> > > The logic behind this is that out of bounds registers are considered
> > > volatile. 
> 
> > It does look a little odd since out of bounds generally means invalid. 
> 
> Most of the drivers that use this idiom use a constant like
> MAX_CACHED_REGISTER or similar which makes it clearer that there are
> more registers beyond the end of the register map.  The normal use is to
> allow access to partially documented diagnostic registers or to support
> register banks that are partially owned by something else (devices with
> an embedded DSP being the most obvious example).

Yes that makes sense.  I've changed the function to use
WM8995_MAX_CACHED_REGISTER instead.

Thanks,
Dimitris
