From: Andy Robinson <andy@seventhstring.com>
Subject: Re: Memory allocation and the "prealloc" procfile
Date: Fri, 08 Apr 2005 17:07:49 +0100
Message-ID: <1112976469.6902.2.camel@andys_dellm60.ss82amr.net>
References: <20050408154303.E61098C466@sc8-sf-spam1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050408154303.E61098C466@sc8-sf-spam1.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

> Message: 5
> Date: Fri, 8 Apr 2005 12:55:29 +0200 (METDST)
> From: Clemens Ladisch <clemens@ladisch.de>
> To: Andy Robinson <andy@seventhstring.com>
> cc: ALSA devel <alsa-devel@lists.sourceforge.net>
> Subject: Re: [Alsa-devel] Re: Memory allocation and the "prealloc" procfile
> 
> Andy Robinson wrote:
> > But I'm still curious to know, what is all that
> > /proc/asound/card0/pcm0p/sub0/prealloc memory used for?
> 
> For the buffer. :)
> 
> > I specify 128k but only get a 32k buffer reported by
> > SNDCTL_DSP_GETOSPACE (and one of my users gets only 4k of buffer)
> 
> Doesn't happen on my machine.  What parameters are you using?
> 
> 
> $ cat ospace.c
> #include <stdio.h>
> #include <fcntl.h>
> #include <sys/soundcard.h>
> 
> int main()
> {
> 	int fd;
> 	audio_buf_info i;
> 	int x;
> 
> 	fd = open("/dev/dsp", O_WRONLY);
> 	x = 1;
> 	ioctl(fd, SNDCTL_DSP_STEREO, &x);
> 	x = AFMT_S16_LE;
> 	ioctl(fd, SNDCTL_DSP_SETFMT, &x);
> 	x = 48000;
> 	ioctl(fd, SNDCTL_DSP_SPEED, &x);
> 	ioctl(fd, SNDCTL_DSP_GETOSPACE, &i);
> 	close(fd);
> 	printf("buffer bytes: %d * %d = %d\n", i.fragstotal, i.fragsize, i.fragstotal * i.fragsize);
> 	return 0;
> }
> $ cat /proc/asound/cards
> 0 [ICH5           ]: ICH4 - Intel ICH5
>                      Intel ICH5 with AD1985 at 0xfebff400, irq 209
> $ cat /proc/asound/card0/pcm0p/sub0/prealloc
> 64
> $ ospace
> buffer bytes: 16 * 4096 = 65536
> $ echo 128 > /proc/asound/card0/pcm0p/sub0/prealloc
> $ ospace
> buffer bytes: 16 * 8192 = 131072
> 
> 
> Regards,
> Clemens

Amazing! Thank you enormously for this, which produces the same result
on my system as yours. It is indeed a matter of ioctl order, as Takashi
Iwai also suggests.

If I add extra SNDCTL_DSP_GETOSPACE/printf at each point to your sample
then I see the following (prealloc is 128) :

       fd = open("/dev/dsp", O_WRONLY);
buffer bytes: 8 * 4096 = 32768

        ioctl(fd, SNDCTL_DSP_STEREO, &x);
buffer bytes: 8 * 8192 = 65536

        ioctl(fd, SNDCTL_DSP_SETFMT, &x);
buffer bytes: 32 * 4096 = 131072

        ioctl(fd, SNDCTL_DSP_SPEED, &x);
buffer bytes: 16 * 8192 = 131072

I don't know know if this surprises you but it certainly surprises me! I
would have expected that if prealloc is 128k then SNDCTL_DSP_GETOSPACE
would tell us 128k ... instead of 32k, just after opening the device.

I have been using the following order:
- open
- SNDCTL_DSP_SETFRAGMENT
- SNDCTL_DSP_GETOSPACE
- set up other parameters (sample rate & format)

my reasoning being that I have read, with regard to
SNDCTL_DSP_SETFRAGMENT in native OSS, that
"NOTE! This ioctl call must be used as early as possible. The optimum
location is immediately after opening the device."
and it seemed natural to me that after SNDCTL_DSP_SETFRAGMENT to ask for
what we want, we call SNDCTL_DSP_GETOSPACE to see what we got. And in
fact this does seem to work on native OSS.

So I will change this to:
- open
- SNDCTL_DSP_SETFRAGMENT
- set up other parameters (sample rate & format)
- SNDCTL_DSP_GETOSPACE

Which seems like it should be ok on native OSS and ALSA too. Come to
think of it, if I was a sloppier programmer and hadn't bothered to call
SNDCTL_DSP_GETOSPACE at all, then everything would have been fine.

I am very happy to have an answer to this problem which has been bugging
me for months, and has prevented some people from using the Linux
version of my software - thank you again. You may be wondering why I
didn't switch to using ALSA directly, but the point is that I want
maximum compatibility, including older systems which don't use ALSA.

Regards,
Andy Robinson, Seventh String Software, www.seventhstring.com



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
