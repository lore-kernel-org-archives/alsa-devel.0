From: Anders Johansson <ajh@watri.org.au>
Subject: VXPocket 440
Date: Sat, 8 May 2004 16:54:58 +0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040508085458.GC8559@watri.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I am trying to get full duplex 4 channel I/O with minimum latency to
work on a Digiram VXpocket 440, and I am having some problems. All log
files and test scripts that I have been using are found under the link
at the end of this mail:

1. If i turn on preemptive multitasking the log fills up with 
   error messages about Bad scheduling and I cant get anything through
   the card.

2. ACPI seems to make the kernel more instable and more easy to
   crash.

3. If i pipe sound from arecord to aplay and use too small buffer size
   the kernel locks. I need buffer-space > 2048 bytes to avoid buffer
   over and under runs see atest.log and atest. aplay uses 50% of CPU.
   Kernel lockups occur when buffer-space is below 1024 bytes.

4. Using all four channels is only possible with S16_LE not S24_LE.

5. I have written an application which loop backs sound from jackds
   inputs to outputs. JACK never receives any samples however so
   nothing is played or recorded. See jtest and jtest.log
   When jack runs ksoftirqd used ~15 % of the CPU. 

6. When trying to run jack and increasing buffer length to 1024
   samples and above I get: jackd: pcm.c:5946: snd_pcm_mmap_commit:
   Assertion `frames <= snd_pcm_mmap_avail(pcm)' failed. I assume this
   is related to my asoundrc file.


The device is a SBC with very limited resources so debugging is a
bit hard for me. My application is demo system for a new type of
hearing aid. I know a little bit about alsa and have previously helped
you debug M-Audio delta 1010LT.

Where do you suggest I start? I guess the problem is in the interrupt
handling in the PCMCIA subsystem.

This is the link for my logs and scripts:
http://www.watri.org.au/~ajh/debug/

Thank you for your help,
//Anders



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
