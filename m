From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Monotonic timestamps
Date: Wed, 9 Apr 2008 23:36:02 +0200
Message-ID: <20080409213602.GA2589@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 1E0D324589
	for <alsa-devel@alsa-project.org>;
	Wed,  9 Apr 2008 23:36:03 +0200 (CEST)
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
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hey!

I saw that ALSA 1.0.16 claims to support monotonic timestamps. I
couldn't figure out however, how they are supposed to work. From the
sources I only could figure out that they are enabled if a) the libc
knows CLOCK_MONOTONIC a) the kernel supports CLOCK_MONOTONIC, b) the
ALSA kernel code support timestamps this way. That's at least how I
read this code from pcm_hw.c:

<snip>
#if defined(HAVE_CLOCK_GETTIME) && defined(CLOCK_MONOTONIC)
        if (SNDRV_PROTOCOL_VERSION(2, 0, 9) <= ver) {
                struct timespec timespec;
                if (clock_gettime(CLOCK_MONOTONIC, &timespec) == 0) {
                        int on = SNDRV_PCM_TSTAMP_TYPE_MONOTONIC;
                        if (ioctl(fd, SNDRV_PCM_IOCTL_TTSTAMP, &on) <
                        0) {
                                ret = -errno;
                                SNDMSG("TTSTAMP failed\n");
                                return ret;
                        }
                        monotonic = 1;
                }
        }
#endif
          else if (SNDRV_PROTOCOL_VERSION(2, 0, 5) <= ver) {
                int on = 1;
                if (ioctl(fd, SNDRV_PCM_IOCTL_TSTAMP, &on) < 0) {
                        ret = -errno;
                        SNDMSG("TSTAMP failed\n");
                        return ret;
                }
        }
</snip>

The problem with this is that there seems to be no way to determine
from an application if monotonic timestamps are enabled in an
snd_pcm_t or not, ALSA just switches over to them, making the
timestamps relatively useless, because we cannot reliable relate them
to timestamps we query from the kernel ourselves -- because we just
don't know if we need to use CLOCK_MONOTONIC or CLOCK_REALTIME.

I find it very strange that ALSA just switches to monotonic timestamps
just like that, anyway. Programs written for wallclack timestamps will
break if they run on a system where ALSA uses monotonic timestamps!

There's a function missing that enables monotonic timestamps
explicitly, or at least one that can be used to query if they are
monotonic or not.

Could anybody please explain the difference between status->tstamp and
status->trigger_tstamp for me, please? The doxygen docs are bit too
terse on this, I fear.

Oh, and the code I pasted above will not compile if the #ifdef check
fails, because of the "else". The "else" should be moved inside of
#ifddef block.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
