From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH] New Aztech Sound Galaxy driver
Date: Sun, 23 Sep 2007 17:43:17 +0200
Message-ID: <20070923174317.71510732.krzysztof.h1@poczta.fm>
References: <46F26571.501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.poczta.interia.pl (smtp35.poczta.interia.pl [80.48.65.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 44B31244DA
	for <alsa-devel@alsa-project.org>;
	Sun, 23 Sep 2007 17:35:24 +0200 (CEST)
In-Reply-To: <46F26571.501@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@gmail.com>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 20 Sep 2007 14:20:01 +0200
Rene Herman <rene.herman@gmail.com> wrote:

> FCC-ID I38-MMSN852: Aztech Sound Galaxy Waverider Pro 32-3D
> 

I have tested your driver on this cards and it works for me (no suprise).
I have no tested full-duplex recording.

Just two minor issues below.

> --- /dev/null	Thu Jan 01 00:00:00 1970 +0000
> +++ b/isa/galaxy/Makefile	Thu Sep 20 14:15:22 2007 +0200
> @@ -0,0 +1,10 @@
> +#
> +# Makefile for ALSA
> +# Copyright (c) 2001 by Jaroslav Kysela <perex@suse.cz>
> +#
> +

You should be file's author, I suppose.

> diff -r 0687faf0e009 isa/galaxy/galaxy.c
> --- /dev/null	Thu Jan 01 00:00:00 1970 +0000
> +++ b/isa/galaxy/galaxy.c	Thu Sep 20 14:15:22 2007 +0200
> @@ -0,0 +1,562 @@
> [...]
> +#define DSP_COMMAND_GALAXY_9	9
> +#define GALAXY_COMMAND_WSSMODE	0
> +#define GALAXY_COMMAND_SB8MODE	1
> +
> +#define GALAXY_MODE_WSS		GALAXY_COMMAND_WSSMODE
> +#define GALAXY_MODE_SB8		GALAXY_COMMAND_SB8MODE

There is no need for these redefinitions. The first constant is used once, the second not even once.
You can use the original name (GALAXY_COMMAND_WSSMODE) without losing readability.

Regards,
Krzysztof



----------------------------------------------------------------------
Tutaj sa Twoi nowi znajomi!
Sprawdz >>> http://link.interia.pl/f1bb7
