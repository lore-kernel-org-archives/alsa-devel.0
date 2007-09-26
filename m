From: Akio <akioolin@gmail.com>
Subject: =?utf-8?q?about_sound/core/pcm=5Flib=2Ec=3A1997=3A_c?=
	=?utf-8?q?apture_read_error_=28DMA_or_IRQ_trouble=3F=29?=
Date: Wed, 26 Sep 2007 03:28:10 +0000 (UTC)
Message-ID: <loom.20070926T031709-238@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 29BF924494
	for <alsa-devel@alsa-project.org>;
	Wed, 26 Sep 2007 05:28:37 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IaNZX-0005bk-GE
	for alsa-devel@alsa-project.org; Wed, 26 Sep 2007 03:28:31 +0000
Received: from cache8000-1.itri.org.tw ([61.61.254.9])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 26 Sep 2007 03:28:23 +0000
Received: from akioolin by cache8000-1.itri.org.tw with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 26 Sep 2007 03:28:23 +0000
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

Dear ALL:


                after long time amr-wb codec loopback test. (above 90 hours)
                I got the following kernel message.  it comes from
snd_pcm_lib_read1()
                function. 
                ALSA sound/core/pcm_lib.c:1997: capture read error (DMA or IRQ
trouble?)
                ALSA sound/core/pcm_lib.c:1997: capture read error (DMA or IRQ
trouble?)
                ALSA sound/core/pcm_lib.c:1997: capture read error (DMA or IRQ
trouble?)
                ALSA sound/core/pcm_lib.c:1997: capture read error (DMA or IRQ
trouble?)
                ALSA sound/core/pcm_lib.c:1997: capture read error (DMA or IRQ
trouble?)
                ALSA sound/core/pcm_lib.c:1997: capture read error (DMA or IRQ
trouble?)

                What should I do? My platform is ARM926, with Kernel 2.6.19.2
                ALSA version is 1.0.13.

Best Regards,
Akio
