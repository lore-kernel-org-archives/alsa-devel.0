From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: ASoC: wm9712: Microphone doesn't work,
 "Capture Volume" inverted
Date: Fri, 27 Apr 2012 10:00:02 +0200
Message-ID: <1335513602.3504.4.camel@mars>
References: <1335384469.14096.203.camel@mars>
	<20120426112726.GF3207@opensource.wolfsonmicro.com>
	<1335448142.20000.40.camel@mars>
	<20120426172010.GP3207@opensource.wolfsonmicro.com>
	<1335474693.3628.26.camel@lovely>
	<20120426213745.GA18260@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id C12EF10BE03
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Apr 2012 10:00:06 +0200 (CEST)
Received: by laap9 with SMTP id p9so291409laa.38
	for <alsa-devel@alsa-project.org>; Fri, 27 Apr 2012 01:00:06 -0700 (PDT)
In-Reply-To: <20120426213745.GA18260@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, "Hans J. Koch" <hjk@hansjkoch.de>, Sascha Hauer <s.hauer@pengutronix.de>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2012-04-26 at 22:37 +0100, Mark Brown wrote:
> On Thu, Apr 26, 2012 at 11:11:33PM +0200, Christoph Fritz wrote:
> > On Thu, 2012-04-26 at 18:20 +0100, Mark Brown wrote:
> > > On Thu, Apr 26, 2012 at 03:49:02PM +0200, Christoph Fritz wrote:
> 
> > > > Is "SOC_ENUM_SINGLE(0x5c, 8, 2, wm9712_diff_sel)," correct? Because of
> > > > the ">> 1" shift in ac97_write() ?
> 
> > > What makes you think it might not be correct?
> 
> > ac97_write() doesn't get called when I try to change "Item: Differential Source".
> 
> Oh, right - you're not actually seeing any attempt to write.  There
> won't be anything on the bus, then.  Still, why are you identifying the
> shift there?

The shift should be fine here.

>   The write will be suppresed if the register contents don't
> change which looks like what you're seeing here - 

Can you imagine why the registers don't change?

> though I can't see
> anything obviously wrong with the enum from looking at the code, it's
> saying that the enumeration exists in bit 8 of register 0x5c...

Yes I rechecked this too.


Thanks,
 -- Christoph
