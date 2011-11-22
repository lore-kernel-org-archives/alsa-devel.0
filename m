From: Tim Blechmann <tim@klingt.org>
Subject: [bisected] lx6464es fails to open a second time
Date: Tue, 22 Nov 2011 01:00:39 +0100
Message-ID: <2428359.JOQWRg64O4@moka>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from klingt.org (mail.klingt.org [86.59.21.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 58D312452A
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2011 01:00:43 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: LKML <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Brian Gerst <brgerst@gmail.com>
List-Id: alsa-devel@alsa-project.org

hi all, especially brian and takashi,

some time ago, i've been developing the driver for the lx6464es ethersound 
sound card, which has been included into the kernel for some time. however i 
haven't been able to use it in kernels after 2.6.33.

today, i was able to bisect the issue and the first bad commit is:

commit 6175ddf06b6172046a329e3abfd9c901a43efd2e
Author: Brian Gerst <brgerst@gmail.com>
Date:   Fri Feb 5 09:37:07 2010 -0500

    x86: Clean up mem*io functions.
    
    Iomem has no special significance on x86.  Use the standard mem*
    functions instead of trying to call other versions.  Some fixups
    are needed to match the function prototypes.
    
    Signed-off-by: Brian Gerst <brgerst@gmail.com>
    LKML-Reference: <1265380629-3212-6-git-send-email-brgerst@gmail.com>
    Signed-off-by: H. Peter Anvin <hpa@zytor.com>


the problem was: the sound card could only be started once, but i haven't been 
able to start it a second time, probably because the driver doesn't shut down 
the device correctly.

the communication with the device is done by passing simple commands via 
memcpy_fromio and memcpy_toio (compare sound/pci/lx6464es/lx_core.c, lines 75 
to 99). any idea, what is going wrong there?

thanks, tim
