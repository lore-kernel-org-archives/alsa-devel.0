From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Subject: Re: au88x0 modem
Date: Fri, 16 Sep 2005 09:53:48 +0200
Message-ID: <20050916075348.GA524@titan.lahn.de>
References: <20050913085552.GA2655@titan.lahn.de> <20050913173529.GD31269@sashak.softier1.local> <20050913174930.GA5816@titan.lahn.de> <4327DA14.3040205@netvigator.com> <20050914205608.GD14657@sashak.softier1.local> <20050915091158.GA7314@titan.lahn.de> <20050915092155.GA7328@titan.lahn.de> <20050915143533.GB23218@sashak.softier1.local> <20050915204345.GC27700@sashak.softier1.local> <432A4B24.1040209@netvigator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <432A4B24.1040209@netvigator.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Raymond <rayau@netvigator.com>
Cc: alsa-devel@lists.sourceforge.net, Sasha Khapyorsky <sashak@smlink.com>, openvortex-dev@nongnu.org, Manuel Jander <manuel.jander@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hello!

On Fri, Sep 16, 2005 at 12:33:40PM +0800, Raymond wrote:
> >Pilipp, no real patches yet, let's investigate few things:
> >
> >1. Actual "secondary codec" bit in CODEC_EN register - just silly print
> >(apply with -p1):
> >
> >
> >--- au88x0_prev/au88x0_core.c	2005-09-14 20:51:03.000000000 +0300
> >+++ au88x0/au88x0_core.c	2005-09-15 22:59:05.000000000 +0300
> >@@ -2516,6 +2516,8 @@ static void vortex_codec_init(vortex_t *
...
> >+	printk("vortex_codec_init: VORTEX_CODEC_EN = %08x\n",
> >+		hwread(vortex->mmio, VORTEX_CODEC_EN));
>
> VORTEX_CODEC_EN = 00000000 on au8830 (STAC9708) after cold reset of AC-Link.

VORTEX_CODEC_EN = 00003f00

> static int vortex_core_init(vortex_t * vortex)
...
> +	printk(KERN_INFO "VORTEX_CTRL : %.8x\n",hwread(vortex->mmio, VORTEX_CTRL));

VORTEX_CTRL : 00303260

> diff -Naur modem/alsa-driver/alsa-kernel/pci/au88x0_orig/au8810.c 
> modem/alsa-driver/alsa-kernel/pci/au88x0/au8810.c

The patch is line wrapped, will take me a moment to apply by hand.
Will send another email.

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
