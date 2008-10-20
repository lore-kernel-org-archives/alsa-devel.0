From: Oliver Ford <ipaqlinux@oliford.co.uk>
Subject: ALSA SOC in the ARM linux kernel - pxa2xx-pcm oops on
	invalid dma_ch.
Date: Mon, 20 Oct 2008 09:48:40 +0100
Message-ID: <48FC45E8.2060705@oliford.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0.thdo.woaf.net (dog.thdo.woaf.net [213.230.192.130])
	by alsa0.perex.cz (Postfix) with ESMTP id 87D991037FA
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Oct 2008 10:49:02 +0200 (CEST)
Received: from i-83-67-105-182.freedom2surf.net ([83.67.105.182]
	helo=[127.0.0.1])
	by mx0.thdo.woaf.net with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63) (envelope-from <ipaqlinux@oliford.co.uk>)
	id 1KrqRO-0003Rj-Bt
	for alsa-devel@alsa-project.org; Mon, 20 Oct 2008 08:48:44 +0000
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I had been working on a kernel for the iPAQ 21x series (PXA310 based 
with a WM9713) which I had originally (June 08) based on 
arm.linux.org.uk's git tree with   
wolfsonmicro.com/linux-2.6-asoc/asoc-v2-dev merged in. Recently (last 
week) I tried to pull the latest changes from arm.linux.org.uk and got 
too many conflicts in the ALSA SOC code, the mainline kernel code seems 
to have been cleaned up a lot compared to asoc-v2-dev. Due to this I'm 
now working from the ALSA SOC code as it comes in arm.linux.org.uk.

This mostly works but I'm having trouble with oopses due to invalid DMA 
channels in pxa2xx-pcm.c. Is this the right place to ask about this, if 
so I'll post the details here (which I already posted on the arm-linux 
mailing list). Is there a branch on wolfsonmicro.com that would be 
closer to what is now in the main kernel?

Thanks,

Oliver Ford
