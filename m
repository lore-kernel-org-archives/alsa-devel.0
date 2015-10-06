From: Matt Campbell <mcampbell@izotope.com>
Subject: race condition between dmaengine_pcm_dma_complete and
	snd_pcm_release
Date: Tue, 6 Oct 2015 17:45:43 -0400
Message-ID: <CAMDowVWrLOK1Ysmfe1zTujw0Ev5PjPei1RBH8t_Mve_fsfe2ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yk0-f174.google.com (mail-yk0-f174.google.com
 [209.85.160.174])
 by alsa0.perex.cz (Postfix) with ESMTP id DAAE92606ED
 for <alsa-devel@alsa-project.org>; Tue,  6 Oct 2015 23:45:44 +0200 (CEST)
Received: by ykdz138 with SMTP id z138so217133158ykd.2
 for <alsa-devel@alsa-project.org>; Tue, 06 Oct 2015 14:45:43 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi All,

I've been trying to track down a kernel crash I've been getting when
closing ALSA devices. There is a race condition between the bottom half
interrupt handler for the DMA system (dmaengine_pcm_dma_complete in
pcm_dmaengine.c) and the releasing of the sub-stream resources it receives
as an argument (when snd_pcm_release is called). An older thread from 2013
discussed this to a good extent so I wont go into the details here. I've
been unable to track down either a patch to fix this or even a good
solution that I could implement. I've spent a couple days trying to think
of an elegant solution and come up with nothing so far. Any input would be
appreciated.

Link to original thread:
http://mailman.alsa-project.org/pipermail/alsa-devel/2013-October/067111.html

It's worth nothing that the original thread points out how this can arise
on multi-core systems. In my case I'm on a single core system, but with the
real-time patch enabled and the userspace ALSA thread running at a higher
priority than the kernel's tasklet thread which can reproduce this almost
100% of the time.

~Matt
