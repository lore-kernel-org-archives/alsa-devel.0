From: Mark Rivera <marr@lumin.us>
Subject: Source of timing for MIDI and/or audio synchronization
Date: Tue, 12 Jun 2007 01:17:57 -0500
Message-ID: <466E3A95.8070900@lumin.us>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from swarthymail-a5.g.dreamhost.com
	(sd-green-bigip-207.dreamhost.com [208.97.132.207])
	by alsa0.perex.cz (Postfix) with ESMTP id 054D410382A
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Jun 2007 08:18:03 +0200 (CEST)
Received: from [192.168.1.101] (unknown [24.224.35.97])
	by swarthymail-a5.g.dreamhost.com (Postfix) with ESMTP id 961E4109EAC
	for <alsa-devel@alsa-project.org>; Mon, 11 Jun 2007 23:17:59 -0700 (PDT)
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


Hello (new to list), and thank you for the work you have been doing. As 
an end-user of the ALSA project's development, I am very grateful for 
being able to use softwares which provide audio functionality to Linux.

I have been reading up on the docs and list archives, but I still have 
an open question for which I hope you can lead me to an answer.

I designed and built a MIDI sequencer based around a Microchip PIC18 
MCU, and used the built-in hardware timers and interrupt levels to drive 
the 'scheduler' for initiating MIDI output (EUSART) routines. In this 
same vein, I would like to write a software sequencer with as 'tight' 
timing as possible. So, in a similar concept for Linux - from where does 
the timing of audio and MIDI events come from?

It occurred to me that it would be nice to have a loadable kernel module 
(LKM) to which userland programs could subscribe for receiving 'soft 
interrupts' based on some timer (cpu ticks?) so that various software 
could all reference the same notion of the "current time" - a sort of 
"master clock" with start/stop/continue as well.

Does ALSA provide this functionality? Can someone point me in the right 
direction for learning more about this?

Many thanks.

Mark
