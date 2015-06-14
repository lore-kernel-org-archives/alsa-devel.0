From: Azizul Hakim <azizulfahim2002@gmail.com>
Subject: Audio Driver Works In Ubuntu but Crash in Debian After
	2nd Run
Date: Sat, 13 Jun 2015 23:18:55 -0400
Message-ID: <CA+k7WwYp8aN0OWmSNjtYq-4w4s+00Ej7tcsjiqbj7BbiJ+MtQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f169.google.com (mail-ob0-f169.google.com
 [209.85.214.169])
 by alsa0.perex.cz (Postfix) with ESMTP id AD9152604D1
 for <alsa-devel@alsa-project.org>; Sun, 14 Jun 2015 05:18:56 +0200 (CEST)
Received: by obpc2 with SMTP id c2so15946903obp.3
 for <alsa-devel@alsa-project.org>; Sat, 13 Jun 2015 20:18:55 -0700 (PDT)
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

Dear altruists,

I'm writing a sound card driver based on ALSA API. My driver works
perfectly on Ubuntu 12.04, 13.10 and 14.04. There is no problem on how many
times I play a sound file using my driver. Everything works great. But same
driver has some issue on debian distribution.


I've been trying to test it on BeagleBone and during the first run the
driver works pretty well. But as soon as I play a second sound file, it
crash. I thought may be I did something wrong in releasing resources after
1st run. But so far from my debugging it looks like there is no problem
with resource release. Also same driver works on Ubuntu as many times as I
test. I even tested with the same sound file.  On debian, I get the
following message is kernel log-

Apr 23 20:26:41 beaglebone kernel: [  183.631905] ALSA
sound/core/pcm_lib.c:1910 playback write error (DMA or IRQ trouble?)


It would be highly appreciated if I can get some suggestions on which
direction I should try to resolve this issue. Is there any known issue with
debian distribution or anyone faced similar kind of problem before?


Thanks
Azizul Hakim
