From: Lars Heineken <Lars.Heineken@gmx.de>
Subject: Re: Opening dev/dsp takes very long
Date: Sat, 20 Mar 2004 09:20:02 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <405BFEB2.9040402@gmx.de>
References: <Pine.HPX.4.33n.0403160917290.14608-100000@studcom.urz.uni-halle.de> <4056BF90.2060005@gmx.de> <405AE7B8.6080603@gmx.de> <405B6CFD.9070303@gmx.de> <405B88B1.3070204@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070603000802030201040607"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <405B88B1.3070204@superbug.demon.co.uk>
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

This is a multi-part message in MIME format.
--------------070603000802030201040607
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

>      0.000531 ioctl(4, SNDCTL_DSP_RESET, 0) = 0
>      0.000232 ioctl(4, SNDCTL_DSP_GETFMTS, 0xbffff668) = 0
>      0.510506 ioctl(4, SNDCTL_DSP_SETFMT, 0xbffff668) = 0
>      0.506515 ioctl(4, SNDCTL_DSP_STEREO, 0xbffff668) = 0
>      0.504940 ioctl(4, SOUND_PCM_READ_RATE, 0xbffff668) = 0
>      0.065604 ioctl(4, SNDCTL_DSP_GETBLKSIZE, 0x80a5824) = 0
>      0.000302 ioctl(4, SNDCTL_DSP_SYNC, 0) = 0
>      0.000250 munmap(0x40016000, 4096)  = 0 



The output is from executing this line:

strace -r sox 01.wav -t ossdsp /dev/dsp

As each and every oss-program on my machine suffers from this unusual 
delay I think it doesn't make much sense to write a sample program, but 
anyway, it's attached.

Regards,

Lars.





--------------070603000802030201040607
Content-Type: text/plain;
 name="delay.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="delay.c"

#include "stdio.h"

#include <sys/soundcard.h>
#include <unistd.h>
#include <fcntl.h>

main() {
	int file;
	
	file = open("/dev/dsp", O_RDWR, 0);

	ioctl(file, SNDCTL_DSP_RESET, 0);
	ioctl(file, SNDCTL_TMR_TIMEBASE, 0xbffff4d0);	

	ioctl(file, SNDCTL_DSP_GETFMTS, 0xbffff668);
	ioctl(file, SNDCTL_DSP_SETFMT, 0xbffff668);
	ioctl(file, SNDCTL_DSP_STEREO, 0xbffff668);
	ioctl(file, SOUND_PCM_READ_RATE, 0xbffff668);
	ioctl(file, SNDCTL_DSP_GETBLKSIZE, 0x80a5824);
	ioctl(file, SNDCTL_DSP_SYNC, 0);

	close(file);
					      
}

--------------070603000802030201040607--



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
