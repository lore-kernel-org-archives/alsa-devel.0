From: Ted <ted@nowtsfree.freeserve.co.uk>
Subject: Fix in interwave.c for dma1/dma2 requests
Date: Mon, 15 Dec 2003 18:28:31 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031215182831.99B2C4955@marimba.home.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Ted <ted@nowtsfree.freeserve.co.uk>
List-Id: alsa-devel@alsa-project.org

Hello,
    Maybe a small typo, but I was getting wrong dma chanels assigned
to my interwave card.

alsa-driver-1.0.0rc2/alsa-kernel/isa/gus/interwave.c:
629c629
<       dma1[dev] = pnp_dma(pdev, 1);
---
>       dma1[dev] = pnp_dma(pdev, 0);

Note: this assumes my earlier reported bug-fix to ensure that
CONFIG_ISAPNP is defined when support/pnp/* are built for my
configuration, too.

Ted.
-- 
Ted <ted@nowtsfree.freeserve.co.uk>
   http://www.nowtsfree.freeserve.co.uk


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
