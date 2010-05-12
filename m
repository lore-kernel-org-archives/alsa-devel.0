From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [patch 1/6] kirkwood: add audio functions.
Date: Wed, 12 May 2010 09:56:14 +0100
Message-ID: <1273654574.3294.2.camel@odin>
References: <20100511162342.640158675@mandriva.com>
	<20100511162601.375878707@mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id B24342498A
	for <alsa-devel@alsa-project.org>;
	Wed, 12 May 2010 10:56:18 +0200 (CEST)
Received: by wwb24 with SMTP id 24so384687wwb.38
	for <alsa-devel@alsa-project.org>; Wed, 12 May 2010 01:56:18 -0700 (PDT)
In-Reply-To: <20100511162601.375878707@mandriva.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: apatard@mandriva.com
Cc: tbm@cyrius.com, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, saeed@marvell.com, nico@fluxnic.net
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-05-11 at 18:23 +0200, apatard@mandriva.com wrote:
> plain text document attachment (kirkwood_add_audio_dev.patch)
> This patch add audio related definitions and functions
> 
> 
> Signed-off-by: Arnaud Patard <apatard@mandriva.com>
> ---
>  arch/arm/mach-kirkwood/common.c                |    9 	9 +	0 -	0 !
>  arch/arm/mach-kirkwood/common.h                |    2 	2 +	0 -	0 !
>  arch/arm/mach-kirkwood/include/mach/audio.h    |   13 	13 +	0 -	0 !
>  arch/arm/mach-kirkwood/include/mach/kirkwood.h |    3 	3 +	0 -	0 !
>  4 files changed, 27 insertions(+)
>  create mode 100644 include/linux/mv88fx_audio.h
>  create mode 100644 sound/soc/kirkwood/Kconfig
>  create mode 100644 sound/soc/kirkwood/Makefile
>  create mode 100644 sound/soc/kirkwood/cs42l51.c
>  create mode 100644 sound/soc/kirkwood/cs42l51.h
>  create mode 100644 sound/soc/kirkwood/kirkwood_audio_hal.c
>  create mode 100644 sound/soc/kirkwood/kirkwood_audio_hal.h
>  create mode 100644 sound/soc/kirkwood/kirkwood_audio_regs.h
>  create mode 100644 sound/soc/kirkwood/kirkwood_pcm.c
> 

Some of the files above are missing from this patch series i.e.
kirkwood_audio_hal. Are they required ?

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
