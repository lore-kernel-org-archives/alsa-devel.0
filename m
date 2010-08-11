From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 01/14] ASoC: multi-component - TI OMAP
	Platform
Date: Wed, 11 Aug 2010 14:04:18 +0300
Message-ID: <20100811140418.a802cd94.jhnikula@gmail.com>
References: <1281516393-6060-1-git-send-email-lrg@slimlogic.co.uk>
	<1281516393-6060-2-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id C5D6C245BC
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Aug 2010 13:04:27 +0200 (CEST)
Received: by eye27 with SMTP id 27so4121255eye.38
	for <alsa-devel@alsa-project.org>; Wed, 11 Aug 2010 04:04:27 -0700 (PDT)
In-Reply-To: <1281516393-6060-2-git-send-email-lrg@slimlogic.co.uk>
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
Cc: Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

Hi

On Wed, 11 Aug 2010 09:46:20 +0100
Liam Girdwood <lrg@slimlogic.co.uk> wrote:

> Other notable changes required for multi-component support:-
> 
>  o Moved zoom2 audio platform data to board-zoom2.c
>  o Moved n810 audio platform data to board-n810.c
>  o Moved RX51 audio platform data to board-rx51-peripherals.c
>  o Added ASoC DAI and DMA platform devices.

Here are rejects from these two files when applied to Vanilla:

arch/arm/mach-omap2/board-rx51-peripherals.c
arch/arm/mach-omap2/board-zoom2.c

Fortunately trivial.

board-rx51-peripherals.c conflicts with rx51_aic3x_data (i.e. add only
rx51_aic34_setup) and board-zoom2.c with board_nand_init in
omap_zoom2_init.

board-n8x0.c will conflict in 2.6.37 with changes from linux-omap but
this is easiest to handle if you leave out the
arch/arm/mach-omap2/board-n8x0.c changes. IMO n810_aic33_setup for
the digital microphone can be patched after m-c.

>  o Misc fixes from Jarkko Nikula
> 
Add Peter also as he sent fixes too :-)


-- 
Jarkko
