From: sknauert@wesleyan.edu
Subject: Re: [alsa-devel] [RFC] SGI O2 MACE audio ALSA module
Date: Thu, 12 Jul 2007 01:50:12 -0600 (MDT)
Message-ID: <37831.129.133.89.141.1184226612.squirrel@webmail.wesleyan.edu>
References: <6849c8890707020427q47704326od05ebb8241c3cf@mail.gmail.com>
    <s5hejjpaiwa.wl%tiwai@suse.de>
    <6849c8890707091407g61fe2f01jc4eb8ee41e624f15@mail.gmail.com>
    <s5h644rjmn2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <s5h644rjmn2.wl%tiwai@suse.de>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: Takashi Iwai <tiwai@suse.de>
Cc: TJ <tj.trevelyan@gmail.com>, Linux MIPS List <linux-mips@linux-mips.org>, ALSA Dev List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Okay, I got the module compiled and it and ALSA installed.

I noticed the timing bug, I doubt its a frequency issue as the ALSA guides
to downsample (i.e. if it were doing 48kHz instead of 44.1kHz) didn't
help.

You mentioned on some players it would sound okay? I tried everything from
aplay to xmms and always seemed to play too fast. What CPU are you running
this on, by the way? Aplay does give underruns if I'm heavily
multitasking, though sound output seems the same.
