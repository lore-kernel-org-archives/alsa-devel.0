From: Ankhit Vivekananda <ankhit.vivekananda@biscotti.com>
Subject: print audio ring buffer in kernel space
Date: Thu, 29 Oct 2015 13:03:06 -0500
Message-ID: <CACaQK7C7bH1wHomQyJLS=N1V+m5DeSus=4cjB=2WMv4B+3Np+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f170.google.com (mail-wi0-f170.google.com
 [209.85.212.170])
 by alsa0.perex.cz (Postfix) with ESMTP id B3A5026170F
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2015 19:03:06 +0100 (CET)
Received: by wikq8 with SMTP id q8so292276654wik.1
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2015 11:03:06 -0700 (PDT)
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

Hello,

I am trying to print the ring buffer used for DMA transfer using ALSA in
kernel space. I was able to print the ring buffer in user space after
calling the snd_pcm_readi() function. But, wanted to know as to which file
I need to be looking at to print the hardware buffer in kernel space as I
am trying to debug capturing audio using ALSA.

I am using a MCBSP I2S on TM320DM365 processor and CQ93 on chip voice codec
driver.

Appreciate any help as I am new to ALSA.

Thank you.
