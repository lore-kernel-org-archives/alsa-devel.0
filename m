From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 5/7] ASoC: TWL4030: Helper to check chip
 default registers
Date: Tue, 25 May 2010 14:09:56 +0100
Message-ID: <1274792996.3000.233.camel@odin>
References: <1274787248-18583-1-git-send-email-peter.ujfalusi@nokia.com>
	<1274787248-18583-6-git-send-email-peter.ujfalusi@nokia.com>
	<1274788644.3000.151.camel@odin>
	<201005251520.40206.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 9A55524549
	for <alsa-devel@alsa-project.org>;
	Tue, 25 May 2010 15:10:01 +0200 (CEST)
Received: by wyb33 with SMTP id 33so249685wyb.38
	for <alsa-devel@alsa-project.org>; Tue, 25 May 2010 06:09:59 -0700 (PDT)
In-Reply-To: <201005251520.40206.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-05-25 at 15:20 +0300, Peter Ujfalusi wrote:
> > 
> > Is this purely for information/debug purposes ?
> 
> Yes, the driver support twl4030, twl5030, twl5031, tps*something* chips.
> If someone, who have access to those chips, and in doubt, can check it.
>  

So it's more a debug aid.

> > Why do we need to check default vales at init(). Is there another driver
> > changing the audio codec registers ?
> 
> This driver is going to change it.
> It is also possible that the bootloader changed them (startup tone?).

Yeah, that's what I thought. In the past I've always forced the CODEC
registers to their default values during probe(). Very handy if the
driver is a module and you are recovering from a buggy state.

> So it is not really bulletproof, but at least it helped me to find out the the 
> ARXR2_APGA_CTL register does not have the reset value, which it supposed to 
> have.
> 
> Well, I can remove it, but I thought that it is a nice touch ;)
> 

It's nice ;) But maybe we should reset the default values at probe() to
be sure.

Thanks

Liam 
