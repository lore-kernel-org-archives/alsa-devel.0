From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 10/14] ASoC: multi-component - Analog
 Devices Blackfin Platform
Date: Thu, 12 Aug 2010 12:30:22 +0100
Message-ID: <1281612622.3067.26.camel@odin>
References: <1281516393-6060-1-git-send-email-lrg@slimlogic.co.uk>
	<1281516393-6060-11-git-send-email-lrg@slimlogic.co.uk>
	<AANLkTikj0NUnhHPn+X24A91hg=mAU2JTBtQDMoCHGSkp@mail.gmail.com>
	<AANLkTi=iQiRkx1iJFMNJ5WeMONBVyRVVY3sYDxK67Tcx@mail.gmail.com>
	<1281599837.3067.7.camel@odin>
	<AANLkTimxD-GWFTh-YXk2v8YQpjDWfBdeYWP+QzPZZ2wR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 6098424488
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Aug 2010 13:30:27 +0200 (CEST)
Received: by wwc33 with SMTP id 33so587881wwc.20
	for <alsa-devel@alsa-project.org>; Thu, 12 Aug 2010 04:30:26 -0700 (PDT)
In-Reply-To: <AANLkTimxD-GWFTh-YXk2v8YQpjDWfBdeYWP+QzPZZ2wR@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-08-12 at 07:17 -0400, Mike Frysinger wrote:
> On Thu, Aug 12, 2010 at 03:57, Liam Girdwood wrote:
> > On Wed, 2010-08-11 at 23:47 -0400, Mike Frysinger wrote:
> >> On Wed, Aug 11, 2010 at 23:46, Mike Frysinger wrote:
> >> > for Blackfin changes, please use our mailing list:
> >> > uclinux-dist-devel@blackfin.uclinux.org
> >>
> >> actually, this should be for all ADI changes (including Blackfin
> >> processors).  i guess i should add MAINTAINERS entries for this.
> >
> > That would be good if your willing to help out and maintain the ASoC AD
> > codecs and Blackfin support. I did initially email Sedji, but it looks
> > like he no longer works for Analog Devices.
> 
> i dont know anyone named Sedji ... and git log doesnt show him ...

Yeah, that was my bad - He was an ex Atmel guy. Too early in the morning
for me ;)

> 
> this is what is was going to merge:
> ANALOG DEVICES INC ALSA DRIVERS

Just one request, could we have the word "ASoC" after ALSA and before
DRIVERS. 

> L: uclinux-dist-devel@blackfin.uclinux.org
> W: http://blackfin.uclinux.org/
> S: Supported
> F: sound/soc/blackfin/*
> F: sound/soc/codecs/ad1*
> F: sound/soc/codecs/adau*
> F: sound/soc/codecs/adav*
> F: sound/soc/codecs/ssm*

Otherwise

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
