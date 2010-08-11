From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 01/14] ASoC: multi-component - TI OMAP
 Platform
Date: Wed, 11 Aug 2010 12:44:28 +0100
Message-ID: <1281527068.3080.82.camel@odin>
References: <1281516393-6060-1-git-send-email-lrg@slimlogic.co.uk>
	<1281516393-6060-2-git-send-email-lrg@slimlogic.co.uk>
	<20100811140418.a802cd94.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 01C39103861
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Aug 2010 13:44:38 +0200 (CEST)
Received: by wwa36 with SMTP id 36so2932655wwa.20
	for <alsa-devel@alsa-project.org>; Wed, 11 Aug 2010 04:44:38 -0700 (PDT)
In-Reply-To: <20100811140418.a802cd94.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-08-11 at 14:04 +0300, Jarkko Nikula wrote:
> Hi
> 
> On Wed, 11 Aug 2010 09:46:20 +0100
> Liam Girdwood <lrg@slimlogic.co.uk> wrote:
> 
> > Other notable changes required for multi-component support:-
> > 
> >  o Moved zoom2 audio platform data to board-zoom2.c
> >  o Moved n810 audio platform data to board-n810.c
> >  o Moved RX51 audio platform data to board-rx51-peripherals.c
> >  o Added ASoC DAI and DMA platform devices.
> 
> Here are rejects from these two files when applied to Vanilla:
> 
> arch/arm/mach-omap2/board-rx51-peripherals.c
> arch/arm/mach-omap2/board-zoom2.c
> 
> Fortunately trivial.
> 
> board-rx51-peripherals.c conflicts with rx51_aic3x_data (i.e. add only
> rx51_aic34_setup) and board-zoom2.c with board_nand_init in
> omap_zoom2_init.
> 
> board-n8x0.c will conflict in 2.6.37 with changes from linux-omap but
> this is easiest to handle if you leave out the
> arch/arm/mach-omap2/board-n8x0.c changes. IMO n810_aic33_setup for
> the digital microphone can be patched after m-c.
> 

Thanks, I was expecting some conflicts in arch. Hopefully, these will
lessen when the 2.6.37 merge starts and I can rebase to a more recent
kernel before m-c is merged.

> >  o Misc fixes from Jarkko Nikula
> > 
> Add Peter also as he sent fixes too :-)

Oops.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
