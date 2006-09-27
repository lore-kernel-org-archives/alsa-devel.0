From: Ondrej Zary <linux@rainbow-software.org>
Subject: Re: [Patch] Memory Leak in sound/isa/es18xx.c
Date: Thu, 28 Sep 2006 00:21:14 +0200
Message-ID: <200609280021.14839.linux@rainbow-software.org>
References: <1159371001.9125.2.camel@alice>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mailhub3.nextra.sk (smtp3.nextra.sk [195.168.1.142])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4051A152
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Sep 2006 00:20:33 +0200 (MEST)
In-Reply-To: <1159371001.9125.2.camel@alice>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Eric Sesterhenn <snakebyte@gmx.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wednesday 27 September 2006 17:30, Eric Sesterhenn wrote:
> hi,
>
> your patch
> http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdi
>ff;h=1c3985580445ef9225c1ea7714d6d963f7626eeb to add PnP BIOS support to the
> es18xx driver, removed a kfree(cfg) in an error path, was this intentional,
> because coverity flagged it as a memory leak, and i found nothing that
> speaks against it. Attached is a patch to readd the kfree()

Yes, looks just like a stupid bug. Thanks.

> Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>
>
> --- linux-2.6.18-git7/sound/isa/es18xx.c.orig	2006-09-27 17:02:57.000000000
> +0200 +++ linux-2.6.18-git7/sound/isa/es18xx.c	2006-09-27
> 17:03:51.000000000 +0200 @@ -2154,6 +2154,7 @@ static int __devinit
> snd_audiodrive_pnpc
>  	}
>  	/* Control port initialization */
>  	if (pnp_activate_dev(acard->devc) < 0) {
> +		kfree(cfg);
>  		snd_printk(KERN_ERR PFX "PnP control configure failure (out of
> resources?)\n"); return -EAGAIN;
>  	}

-- 
Ondrej Zary

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
