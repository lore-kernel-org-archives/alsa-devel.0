From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: ASoC: wm9712: Microphone doesn't work,
 "Capture Volume" inverted
Date: Thu, 26 Apr 2012 23:11:33 +0200
Message-ID: <1335474693.3628.26.camel@lovely>
References: <1335384469.14096.203.camel@mars>
	<20120426112726.GF3207@opensource.wolfsonmicro.com>
	<1335448142.20000.40.camel@mars>
	<20120426172010.GP3207@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f179.google.com (mail-lb0-f179.google.com
	[209.85.217.179])
	by alsa0.perex.cz (Postfix) with ESMTP id BCF6710BC4D
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Apr 2012 23:11:40 +0200 (CEST)
Received: by lban1 with SMTP id n1so41898lba.38
	for <alsa-devel@alsa-project.org>; Thu, 26 Apr 2012 14:11:40 -0700 (PDT)
In-Reply-To: <20120426172010.GP3207@opensource.wolfsonmicro.com>
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

On Thu, 2012-04-26 at 18:20 +0100, Mark Brown wrote:
> On Thu, Apr 26, 2012 at 03:49:02PM +0200, Christoph Fritz wrote:
> 
> > I added some printks into ac97_write() "sound/soc/codecs/wm9712.c" and
> > when I do for example change "Item: Mic Boost [dB gain: 20.00] " I get
> > this:
> 
> >  write  eh 8000  [6808]
> >  write  eh 8000  [6888]
> 
> > but when I try to change "Mic Select Source" or "Item: Differential
> > Source", nothing happens here.
> 
> Odd.  Can you see the write actually happening on the bus?
> 

Not at the moment, I'll dig into this tomorrow.


> > Why is wm9712_enum[0] never used?
> 
> I rather imagine it's just a simple case of the feature having being
> missed when the driver was implemented.
> 
> > Is "SOC_ENUM_SINGLE(0x5c, 8, 2, wm9712_diff_sel)," correct? Because of
> > the ">> 1" shift in ac97_write() ?
> 
> What makes you think it might not be correct?
> 

ac97_write() doesn't get called when I try to change "Item: Differential Source".

Thanks,
 -- Christoph
