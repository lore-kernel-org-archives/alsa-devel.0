From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [PATCH 1/2] wss_lib: move cs4231_lib into wss_lib
Date: Mon, 23 Jun 2008 02:22:13 +0200
Message-ID: <485EECB5.4070808@keyaccess.nl>
References: <20080619230718.044b7905.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id AF49F2484A
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Jun 2008 02:21:32 +0200 (CEST)
In-Reply-To: <20080619230718.044b7905.krzysztof.h1@poczta.fm>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 19-06-08 23:07, Krzysztof Helt wrote:

> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> Move the file sound/isa/cs423x/cs4231_lib.c 
> into sound/isa/cs423x/wss_lib.c
> This is the first step toward merging all libraries
> for Windows Sound System compatible chips
> into a single library.
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

Acked-by: Rene Herman <rene.herman@gmail.com>

Only small request:

> diff -urNp linux-alsa/sound/isa/wss/Makefile linux-mm/sound/isa/wss/Makefile
> --- linux-alsa/sound/isa/wss/Makefile	1970-01-01 01:00:00.000000000 +0100
> +++ linux-mm/sound/isa/wss/Makefile	2008-06-15 22:38:44.705642447 +0200
> @@ -0,0 +1,10 @@
> +#
> +# Makefile for ALSA
> +# Copyright (c) 2008 by Krzysztof Helt <krzysztof.h1@wp.pl>
> +#
> +
> +snd-wss-lib-objs := wss_lib.o
> +
> +# Toplevel Module Dependency
> +obj-$(CONFIG_SND_WSS_LIB) += snd-wss-lib.o
> +

Could you maybe "donate" the copyright on this Makefile to Jaroslav Kysela?

Basically, this single file is too trivial (and uncreative due to being 
rather fully dictated by the build-system as a whole) to be protectable 
under copyright in the first place but the ALSA build system as a whole 
IS copyrightable and Jaroslav holds the copyright on all others (except 
David Miller on the one sparc specific one).

It's likely not a practical issue really but I feel it's probably good 
to keep this concentrated.

Rene.
