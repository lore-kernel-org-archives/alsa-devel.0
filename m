From: Aaron Heller <heller@ai.sri.com>
Subject: Delta 1010 -  noisy analog capture at 96 and 88kHz
Date: Tue, 25 Nov 2003 17:53:37 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FC407A1.3000900@ai.sri.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

A couple of months ago I replaced an M-Audio Delta66 with a Delta1010 
(not LT) in my system.  The Delta66 works flawlessly.  The Delta1010 is 
OK on playback at all sample rates.  Analog capture is OK at 44.1 and 48 
kHz sample rates.

However, at 96kHz the noise level on analog capture is very high, about 
-30dBfs.   At 88kHz it drops to about -35dBfs.   The audio is clear and 
undistorted, but sounds as if a pink noise generator is summed in as 
well.  This is not a dropped sample, clicking, stuttering problem. No 
xruns are reported.

In fact, the problem is audible/measurable by just routing the inputs 
directly to the outputs with via the on-board mixer/router controlled by 
envy24control -- no host software (e.g., ecasound, arecord) needs to be 
running.

I wrote to M-Audio Tech support.  They advised me to try it under 
Windows with their drivers.  I did this and it worked flawlessly.  I 
noticed that under Windows when I switched from a high sample rate (88.2 
or 96) to a low sample rate (48 or 44.1) or the reverse (low to high) 
there was a loud click on the audio, as if something was being reset. 
Switching from low to low or high to high did not produce a click.

Under ALSA no click is heard, just the change in the noise level.

I'm running ALSA 0.9.8 on Planet CCRMA Red Hat 9.

   [root@blumlein tmp]# uname -a
   Linux blumlein 2.4.22-6.ll.rh90 #1 Wed Sep 10 15:43:57 PDT 2003 i686 
i686 i386 GNU/Linux

   [root@blumlein tmp]# cat /proc/asound/version
   Advanced Linux Sound Architecture Driver Version 0.9.8.
   Compiled on Oct 28 2003 for kernel 2.4.22-6.ll.rh90 with versioned 
symbols.

I've captured audio clips at 44.1, 48, 88.2, 96 and placed them at

  http://www.ai.sri.com/ajh/audio/delta-1010-noise/

This directory includes the raw output of board, 12-channels of 32-bit 
samples, as well as 2-channel 16-bit files of the first two channels, 
and OGG encoded versions of the last files.

The capture and conversion was done by the script test.csh.  I also 
tar'ed the contents of /proc/asound in proc-asound.tar, the wall paper 
from that shell is in proc-tar-shell, for reference.


Any help or insight would be greatly appreciated.

Thanks...

Aaron Heller <heller@ai.sri.com>
Menlo Park, CA





-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
