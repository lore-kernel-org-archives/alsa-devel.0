From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: 2.5: wrong CONFIG_SND_SEQUENCER logic in several drivers
Date: Sat, 21 Jun 2003 09:53:02 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0306210951500.9621-100000__32425.5736348734$1056387588@pnote.perex-int.cz>
References: <20030621011210.GS29247@fs.tum.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (UNKNOWN@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id JAA32766
	for <alsa-devel@alsa-project.org>; Sat, 21 Jun 2003 09:53:27 +0200
In-Reply-To: <20030621011210.GS29247@fs.tum.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Fabio Bracci <fabio@hoendiep.ath.cx>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sat, 21 Jun 2003, Adrian Bunk wrote:

> @Jaroslav:
> Several drivers have a wrong logic for CONFIG_SND_SEQUENCER. The correct 
> solution is something like the following:
> 
> --- sound/pci/emu10k1/emu10k1.c.old	2003-06-21 03:02:04.000000000 +0200
> +++ sound/pci/emu10k1/emu10k1.c	2003-06-21 03:02:31.000000000 +0200
> @@ -35,7 +35,7 @@
>  MODULE_DEVICES("{{Creative Labs,SB Live!/PCI512/E-mu APS},"
>  	       "{Creative Labs,SB Audigy}}");
>  
> -#if defined(CONFIG_SND_SEQUENCER) || defined(CONFIG_SND_SEQUENCER_MODULE)
> +#if defined(CONFIG_SND_SEQUENCER) || (defined (MODULE) && defined(CONFIG_SND_SEQUENCER_MODULE))
>  #define ENABLE_SYNTH
>  #include <sound/emu10k1_synth.h>
>  #endif
> 
> If you comfirm this is correct I'll send a fix for all affected drivers.

Yes, it's correct. I fixed our code. The fix will be in the next ALSA 
2.5 update. Thanks.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
