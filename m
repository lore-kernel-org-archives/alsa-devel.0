From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH v2 1/4] Add SuperH FSI driver support for
 ALSA
Date: Thu, 20 Aug 2009 15:22:12 +0300
Message-ID: <20090820152212.b8be38b9.jhnikula@gmail.com>
References: <uy6ped79a.wl%morimoto.kuninori@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.150])
	by alsa0.perex.cz (Postfix) with ESMTP id 65E971038BB
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Aug 2009 14:20:39 +0200 (CEST)
Received: by ey-out-1920.google.com with SMTP id 13so1053521eye.56
	for <alsa-devel@alsa-project.org>; Thu, 20 Aug 2009 05:20:38 -0700 (PDT)
In-Reply-To: <uy6ped79a.wl%morimoto.kuninori@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Cc: alsa-devel@alsa-project.org, linux-sh@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, broonie@opensource.wolfsonmicro.com, Magnus Damm <magnus.damm@gmail.com>, lethal@linux-sh.org
List-Id: alsa-devel@alsa-project.org

Hi

On Thu, 20 Aug 2009 21:01:05 +0900
Kuninori Morimoto <morimoto.kuninori@renesas.com> wrote:

> This driver is very simple.
> It support playback only now.
> This patch is tested by ms7724se board.
> 
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> ---
> v1 -> v2
> 
> o it direct use clk_enable/disable
> o rename fsi.h -> sh_fsi.h
> 
>  include/sound/sh_fsi.h |   83 ++++
>  sound/soc/sh/Kconfig   |    7 +-
>  sound/soc/sh/Makefile  |    2 +
>  sound/soc/sh/fsi.c     | 1004 ++++++++++++++++++++++++++++++++++++++++++++++++

I'm not familiar with the SH but this arch specific header file
sh_fsi.h should go either into sound/soc/sh or if generic enough, then
somewhere under arch/sh/include/.


-- 
Jarkko
