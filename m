From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: ALSA driver 1.0.2c: divide by zero oops
Date: Tue, 23 Mar 2004 16:21:31 +1030 (CST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200403230551.i2N5pVG01799@auster.physics.adelaide.edu.au>
References: <Pine.LNX.4.58.0403180957250.1835@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0403180957250.1835@pnote.perex-int.cz> from "Jaroslav Kysela" at Mar 18, 2004 09:58:17 AM
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all

> > I did this last night.  The following is my analysis of the problem.
> > With full debug selected, the only message reported by the ALSA system is
> >   ALSA ../alsa-kernel/core/pcm_timer.c:70: BUG? (rate != 0) 
> >   (called from d8c33a79)
> > That is, the assertion "rate!=0" fails.  This confirms the reported oops
> > trigger (that is, divide by zero).
> 
> Could you add exactly same initialization sequence to 
> alsa-oss/test/testoss.c code? So we can debug easily the problem here.

Sorry, I couldn't see where this would fit in in this file - testoss.c seems
more like it's testing the oss redirector though.  The bug I'm seeing is in
software which uses the oss emulation layer directly (that is, it accesses
/dev/dsp with no knowledge of ALSA).

To this end I've hacked up the following small C program which triggers the
fault (see the end of this email).  It essentially contains the exact same
initialisation sequence used in cinelerra 1.1.9.  In developing this program
I've made some more potentially interesting observations.

The divide by zero in snd_pcm_timer_resolution_change() is always triggered
by the SNDCTL_DSP_SETFMT ioctl following the SNDCTL_DSP_SETFRAGMENT. 
However, not all arguments to SNDCTL_DSP_SETFRAGMENT cause a problem.
The argument to SNDCTL_DSP_SETFRAGMENT is set to 
  (4 << 16) | XX
where XX is some number indicating the size of the buffer.  If XX<=14 then
ALSA works fine.  If, however, XX is 15 or greater we get the divide by zero
in snd_pcm_timer_resolution_change() during the following SNDCTL_DSP_SETFMT
call.

In cinelerra the default settings result in XX being set to 16 which is why
this application triggers the bug.  Other OSS applications either never call
the SNDCTL_DSP_SETFRAGMENT ioctl OR call it with smaller buffer sizes.

This program's output with ALSA when XX==16 (with alsa debug mode preventing
divide by zero):
   params: fragments=2 fragstotal=2 fragsize=32768 bytes=65536
Output with ALSA when XX==14:
   params: fragments=4 fragstotal=4 fragsize=16384 bytes=65536

Output with OSS when XX==16:
   fragments=4 fragstotal=4 fragsize=32768 bytes=131072
Output with OSS when XX==14:
   fragments=4 fragstotal=4 fragsize=16384 bytes=65536

Note that the bug has been observed when using an Ensoniq AudioPCI card with
the ens1370 ALSA driver.

I hope this is of assistance.
  jonathan

/*
 * This is a small program to illustrate a problem with the OSS emulation
 * in ALSA driver 1.0.2c.  The initialisation sequence herein causes
 * a divide by zero in snd_pcm_timer_resolution_change().  More particularly,
 * the SNDCTL_DSP_SETFRAGMENT ioctl call has a side effect which causes
 * the divide by zero when SNDCTL_DSP_SETFMT is called.
 *
 * buffer_info = (4 << 16) | XX;
 * If XX is 16 the fault is triggered.  If XX is 14 everything's fine.
 * In general, if XX<=14 everything works, but XX>=15 triggers the bug.
 *
 * Compile with
 *   gcc -o test_alsa_oss{,.c}
 *
 * The bug has been observed when using the ens1370 driver.  It's not known
 * whether it is triggered with other soundcards/drivers.
 *
 * Note: Cinelerra's default configuration has 16384 samples in the buffer -
 * this makes XX equal to 16, thus triggering the bug.
 *
 */
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <linux/soundcard.h>

int set_cloexec_flag(int desc, int value) {
  int oldflags = fcntl (desc, F_GETFD, 0);
  if (oldflags < 0) return oldflags;
  if(value != 0)
    oldflags |= FD_CLOEXEC;
  else
    oldflags &= ~FD_CLOEXEC;
  return fcntl(desc, F_SETFD, oldflags);
}

int main() {

int fd;
int format = AFMT_S16_LE;
int buffer_info = (4 << 16) | 16;
int res, arg;
audio_buf_info playinfo;

  fd = open("/dev/dsp", O_WRONLY);
  if (fd<1) {
    fprintf(stderr,"open() failed on /dev/dsp\n");
    return 1;
  } else {
    printf("open(): fd = %d\n",fd);
  }

  if (set_cloexec_flag(fd,1)<0) {
    printf("failed to set close-on-exec flag\n");
  }

  res = ioctl(fd, SNDCTL_DSP_SETFRAGMENT, &buffer_info);
  if (res < 0)
    printf("SNDCTL_DSP_SETFRAGMENT failed: returned %d\n",res);
  else
    printf("SNDCTL_DSP_SETFRAGMENT ok: %d\n",res); 
  res = ioctl(fd, SNDCTL_DSP_SETFMT, &format);
  if (res < 0)
    printf("SNDCTL_DSP_SETFMT failed: returned %d\n",res);
  else
    printf("SNDCTL_DSP_SETFMT ok: %d\n",res);
   
  arg = 2;
  res = ioctl(fd, SNDCTL_DSP_CHANNELS, &arg);
  if (res < 0)
    printf("SNDCTL_DSP_CHANNELS failed: returned %d\n",res);
  else
    printf("SNDCTL_DSP_CHANNELS ok: %d\n",res);
  arg = 48000;
  res = ioctl(fd, SNDCTL_DSP_SPEED, &arg);
  if (res < 0)
    printf("SNDCTL_DSP_SPEED failed: returned %d\n",res);
  else
    printf("SNDCTL_DSP_SPEED ok: %d\n",res);

  ioctl(fd, SNDCTL_DSP_GETOSPACE, &playinfo);
  printf("params: fragments=%d fragstotal=%d fragsize=%d bytes=%d\n",
    playinfo.fragments, playinfo.fragstotal, playinfo.fragsize, 
    playinfo.bytes);

  close(fd);
  return 0;
}

-- 
* Jonathan Woithe    jwoithe@physics.adelaide.edu.au                        *
*                    http://www.physics.adelaide.edu.au/~jwoithe            *
***-----------------------------------------------------------------------***
** "Time is an illusion; lunchtime doubly so"                              **
*  "...you wouldn't recognize a subtle plan if it painted itself purple and *
*   danced naked on a harpsichord singing 'subtle plans are here again'"    *


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
