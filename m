From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Re: Memory allocation and the "prealloc" procfile
Date: Fri, 8 Apr 2005 12:55:29 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0504081252410.22473-100000@studcom.urz.uni-halle.de>
References: <1112789019.6835.30.camel@andys_dellm60.ss82amr.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1112789019.6835.30.camel@andys_dellm60.ss82amr.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Andy Robinson <andy@seventhstring.com>
Cc: ALSA devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Andy Robinson wrote:
> But I'm still curious to know, what is all that
> /proc/asound/card0/pcm0p/sub0/prealloc memory used for?

For the buffer. :)

> I specify 128k but only get a 32k buffer reported by
> SNDCTL_DSP_GETOSPACE (and one of my users gets only 4k of buffer)

Doesn't happen on my machine.  What parameters are you using?


$ cat ospace.c
#include <stdio.h>
#include <fcntl.h>
#include <sys/soundcard.h>

int main()
{
	int fd;
	audio_buf_info i;
	int x;

	fd = open("/dev/dsp", O_WRONLY);
	x = 1;
	ioctl(fd, SNDCTL_DSP_STEREO, &x);
	x = AFMT_S16_LE;
	ioctl(fd, SNDCTL_DSP_SETFMT, &x);
	x = 48000;
	ioctl(fd, SNDCTL_DSP_SPEED, &x);
	ioctl(fd, SNDCTL_DSP_GETOSPACE, &i);
	close(fd);
	printf("buffer bytes: %d * %d = %d\n", i.fragstotal, i.fragsize, i.fragstotal * i.fragsize);
	return 0;
}
$ cat /proc/asound/cards
0 [ICH5           ]: ICH4 - Intel ICH5
                     Intel ICH5 with AD1985 at 0xfebff400, irq 209
$ cat /proc/asound/card0/pcm0p/sub0/prealloc
64
$ ospace
buffer bytes: 16 * 4096 = 65536
$ echo 128 > /proc/asound/card0/pcm0p/sub0/prealloc
$ ospace
buffer bytes: 16 * 8192 = 131072


Regards,
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
