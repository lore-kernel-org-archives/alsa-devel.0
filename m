From: Shane Volpe <shanevolpe@gmail.com>
Subject: Suspend/Resume failure of Alsa but OSS emulation still
	works
Date: Wed, 13 Jul 2011 15:01:30 -0400
Message-ID: <CAMgc3zMzTrkG-ENxayHG6v+q_3WttVv47L6oiLOrCO8EV3h8sA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id C214A103908
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Jul 2011 21:01:50 +0200 (CEST)
Received: by ewy6 with SMTP id 6so2195905ewy.38
	for <alsa-devel@alsa-project.org>; Wed, 13 Jul 2011 12:01:50 -0700 (PDT)
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

My embedded system's audio is not resuming after the system resumes
from suspend to RAM, below is a detailed discription of the problem
and what I have done, to date, to identify the source of the problem.

I have tested the following scenario with several audio applications
such as Alsa aplay and ogg123:
If I have an audio player (aplay or ogg123) using Alsa and I suspend
my system to RAM when the system wakes up (resumes) there is no sound.
 If I kill the audio player and start it back up the sound returns so
it seems the act of opening and closing Alsa fixes the failure. During
the "no sound state" I also opened alsamixer and adjusted
(successfully) several alsa settings including volume but the sound
still did not resume until I restarted the player.

I also configured one player to use the OSS (emulated by Alsa).  When
I used the emulated OSS audio driver (/dev/dsp) the sound did resume
after the system woke up (resumed) from memory so everything WORKED! I
then configured the player back to use the native Alsa driver and
again there was no sound after resume.

Has anyone seen this issue before or does anyone have additional tests
or debugging ideas they can recommend to further narrow down the
issue.  I'm very comfortable with modifying and compiling the Kernel
so please do not limit your suggestions to user-space tweaks.

Embedded System Information:
Processor: ARM/Xscale (PXA270)
Audio Codec: AC97 (UCB1400)
alsa lib version: 1.0.24.1
Linux Kernel Version: 2.6.39.2

Regards,
Shane
