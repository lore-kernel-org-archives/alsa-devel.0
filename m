From: Michael Voigt <michael.c.m.voigt@web.de>
Subject: write/read system calls and ioctl
Date: Thu, 20 Dec 2007 20:37:42 +0100
Message-ID: <200712202037.44154.michael.c.m.voigt@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fmmailgate01.web.de (fmmailgate01.web.de [217.72.192.221])
	by alsa0.perex.cz (Postfix) with ESMTP id 7D708103889
	for <alsa-devel@alsa-project.org>; Thu, 20 Dec 2007 20:37:54 +0100 (CET)
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id DB5F5BF54509
	for <alsa-devel@alsa-project.org>; Thu, 20 Dec 2007 20:37:53 +0100 (CET)
Received: from [141.76.49.56] (helo=os-dhcp056.inf.tu-dresden.de)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.108 #208) id 1J5RDH-0006eK-00
	for alsa-devel@alsa-project.org; Thu, 20 Dec 2007 20:37:47 +0100
Content-Disposition: inline
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


Dear ALSA developers,

At the beginning, I would like to give a short introdution of myself, then my 
question follows. 

My project:
===============
Currently, I am interning at the TU Dresden operating 
systems group's [1] and it is my task to port ALSA to DROPS [2, 3], a
L4-microkernel-based real-time system. The long-term goal of this
project should be to establish a truely real-time capable FOSS platform
for audio recording and processing.

The current state of the project: By using DDELinux [4] and writing a small 
kernel-user inferface emulation layer, we now have an unchanged version of 
ALSA and an unchanged version of salsa-lib [5] running on our system. The 
next steps will be to test how stable this port is and fix bugs. Then, during 
my diploma thesis, it is my task to port Jack (or an equivalent) to our 
system and to evaluate how to make the whole thing to work in real-time.

But now my question:
===============
In the file pcm_native in alsa-core read (snd_pcm_read) and write 
(snd_pcm_write) functions are attached to the snd_pcm_f_ops. But as far 
as I can see, these write- und read- system calls aren't used either in 
salsa-lib or in alsa-lib.

I can see that in former versions of alsa-lib (for instance alsalib-0.0.3) the 
write system call was used to implement snd_pcm_write (LIB); but now we have 
snd_pcm_writei (LIB) and snd_pcm_writen (LIB) which use ioctl. I guess this 
was done to realize both interleaved and noninterleaved audio playback (The 
old snd_pcm_write (LIB) was based on bytes not on frames and did not have a 
notion of interleaved/noninterleaved playback?). If I have a look at 
snd_pcm_write (KERNEL, pcm_native.c), I can see it also ends up in 
snd_pcm_lib_write(...). So does ioctl with SNDRV_PCM_IOCTL_WRITEI_FRAMES as 
argument, but snd_pcm_write (KERNEL) does not copy the frames to kernel 
memory. 

My question: what is snd_pcm_write in pcm_native.c good for? Is it only there 
to keep ALSA compatible to older versions of alsa-lib?

Kindest regards,
Michael Voigt

================
[1] http://www.inf.tu-dresden.de/index.php?node_id=1141&ln=en
[2] http://www.osnews.com/story.php/15814/Introduction-to-TUD-OS/
[3]
http://www.realtimelinuxfoundation.org/variants/variants.html#VARIANTS_DROPS
[4] http://demo.tudos.org/dsweeper_tutorial.html
[5] http://ftp.isr.ist.utl.pt/pub/MIRRORS/ftp.suse.com/people/tiwai/salsa-lib/
================

-- 
Today is Pungenday, the 61st day of The Aftermath in the YOLD 3173
