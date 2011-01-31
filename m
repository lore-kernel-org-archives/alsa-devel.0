From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] soc: neo1973_wm8753 audio support does	not
	require scoop
Date: Mon, 31 Jan 2011 12:05:04 +0000
Message-ID: <1296475504.3316.46.camel@odin>
References: <201101281200.18371.hartleys@visionengravers.com>
	<20110131112339.GD11937@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 66CDC244E4
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2011 13:05:08 +0100 (CET)
Received: by wyi11 with SMTP id 11so5366550wyi.38
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2011 04:05:08 -0800 (PST)
In-Reply-To: <20110131112339.GD11937@sirena.org.uk>
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
Cc: H Hartley Sweeten <hartleys@visionengravers.com>, alsa-devel@alsa-project.org, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 2011-01-31 at 11:23 +0000, Mark Brown wrote:
> On Fri, Jan 28, 2011 at 12:00:18PM -0700, H Hartley Sweeten wrote:
> > This driver does not use any of the functionality provided by the scoop
> > hardware.  Remove the unneeded header.
> > 
> > Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> 
> CCing in Liam.  As I think I've mentioned before please do remember to
> CC maintainers.
> 
> > 
> > ---
> > 
> > diff --git a/sound/soc/samsung/neo1973_wm8753.c b/sound/soc/samsung/neo1973_wm8753.c
> > index c7a2451..c5b3113 100644
> > --- a/sound/soc/samsung/neo1973_wm8753.c
> > +++ b/sound/soc/samsung/neo1973_wm8753.c
> > @@ -24,7 +24,6 @@
> >  #include <sound/tlv.h>
> >  
> >  #include <asm/mach-types.h>
> > -#include <asm/hardware/scoop.h>
> >  #include <mach/regs-clock.h>
> >  #include <mach/regs-gpio.h>
> >  #include <mach/hardware.h>


Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
