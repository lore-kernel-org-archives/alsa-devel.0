From: "Dr. med. =?iso-8859-15?q?G=FCnther?= Montag" <Safari.Doktor@addcom.de>
Subject: ham radio OSS duplex realtime mmap program.
Date: Fri, 26 Sep 2003 13:26:01 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200309251628.48034.Safari.Doktor@addcom.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: Quoted-Printable
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
Cc: hfterm-hackers@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello
I work at "hfkernel" by Tom Sailer, a program for pactor/rtty (soundcard =
ham=20
radio digimodes). It seems complicated, because it uses realtime scheduli=
ng,=20
select(), mmap(), and runs in 3 threads.=20
It was made in 1996 for OSS; I am trying to get it running with ALSA.=20

It is unique thing because it can do=20
Pactor without the expensive PTC (something like a radio modem),=20
may be of interest for many hams outside Europe /USA.

I and friends see messages like
" 512 fragments passed since last wakeup", in endless loop, leading to=20
crashes, seems to be xruns, not able to ctrl-alt-del, have to switch off=20
machine.
=2E
What do You think, how can ALSA support it, or Do I have to rewrite it fo=
r=20
ALSA.
I tried already with no success to say "Direct" and "non-block" in all=20
combinations to /proc/asound/card0/pcm0p etc...=20
If to rewrite, what function / ioctl matches
SNDCTL_DSP_GETISPACE...SNDCTL_DSP_GETOSPACE...
" ioctl(fd_audio, SNDCTL_DSP_GETIPTR, &cinfo) "
and=20
" ioctl(fd_audio, SNDCTL_DSP_GETOPTR, &cinfo) " ?

The prog is at https//projects.sourceforge.net/hfterm.
Here is one of the important functions out of l1/user/oss.c my prog:
Thanks for Your ideas!

*************************************************************************=
****/

/*
 *      oss.c  --  Linux sound I/O.
 *
 *      Copyright (C) 1997  Thomas Sailer (sailer@ife.ee.ethz.ch)
 *        Swiss Federal Institute of Technology (ETH), Electronics Lab
 *
...
 *  This is the Linux realtime sound output driver
     =20
#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

#include <asm/byteorder.h>
#include <sys/soundcard.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <sys/time.h>
#include <signal.h>
#include <endian.h>
#include <pthread.h>
#include "os.h"
#include "l1.h"
#include "l1user.h"

static int samples_remain =3D 0;
static int samples_count =3D 0;
static short *samples_ptr =3D NULL;

static int invert_ptt =3D 0;

static pthread_t thr_l1;

static float snd_corr;

#if __BYTE_ORDER =3D=3D __BIG_ENDIAN
#define AUDIO_FMT AFMT_S16_BE
#else
#define AUDIO_FMT AFMT_S16_LE
#endif


static void *fdx_driver(void *name_audio)
{
        size_t pagesize =3D getpagesize();
        int apar, fd_audio, i;
	union {
		caddr_t v;
		short *s;
	} ibuf;
	caddr_t ibuf_ext;
	union {
		caddr_t v;
		short *s;
	} obuf;
	struct audio_buf_info iinfo, oinfo;
	unsigned int isize, osize;
	unsigned int ifragptr, ofragptr;
	fd_set rmask, wmask;
	struct count_info cinfo;
	unsigned int curfrag, lastfrag, nfrags;
	unsigned long long itime, otime, inc_fragment;
	l1_time_t inc_sample;
	int ptt_frames;
	short *s;
=09
        if ((fd_audio =3D open(name_audio, O_RDWR, 0)) < 0)
                errstr(SEV_FATAL, "open");
        /*
         * configure audio
         */
        apar =3D AUDIO_FMT;
        if (ioctl(fd_audio, SNDCTL_DSP_SETFMT, &apar) =3D=3D -1)
                errstr(SEV_FATAL, "ioctl: SNDCTL_DSP_SETFMT");
        if (apar !=3D AUDIO_FMT)=20
		errprintf(SEV_FATAL, "audio driver does not support the S16 format\n");
        apar =3D 0;
        if (ioctl(fd_audio, SNDCTL_DSP_STEREO, &apar) =3D=3D -1)
                errstr(SEV_FATAL, "ioctl: SNDCTL_DSP_STEREO");
        if (apar !=3D 0)
		errprintf(SEV_FATAL, "audio driver does not support mono\n");
        apar =3D SAMPLE_RATE;
        if (ioctl(fd_audio, SNDCTL_DSP_SPEED, &apar) =3D=3D -1)
                errstr(SEV_FATAL, "ioctl: SNDCTL_DSP_SPEED");
	if (apar !=3D SAMPLE_RATE) {
		if (abs(apar-SAMPLE_RATE) >=3D SAMPLE_RATE/100)
			errprintf(SEV_FATAL, "audio driver does not support 8kHz sampling=20
frequency\n");
	}
	inc_sample =3D 1000000.0*snd_corr/apar;
	inc_fragment =3D 64*1000000.0*snd_corr/apar*(1<<24);
        ifragptr =3D 0;
	itime =3D 0;
	ofragptr =3D 1;
	otime =3D ofragptr * inc_fragment;
	ptt_frames =3D 0;
	lastfrag =3D 0;
        /*
         * set fragment sizes
         */
        apar =3D 0xffff0007U;
        if (ioctl(fd_audio, SNDCTL_DSP_SETFRAGMENT, &apar) =3D=3D -1)
                errstr(SEV_FATAL, "ioctl: SNDCTL_DSP_SETFRAGMENT");
	if (ioctl(fd_audio, SNDCTL_DSP_GETOSPACE, &oinfo) =3D=3D -1)
		errstr(SEV_FATAL, "ioctl: SNDCTL_DSP_GETOSPACE");
	osize =3D oinfo.fragstotal * oinfo.fragsize;
	if (ioctl(fd_audio, SNDCTL_DSP_GETISPACE, &iinfo) =3D=3D -1)
		errstr(SEV_FATAL, "ioctl: SNDCTL_DSP_GETISPACE");
	isize =3D iinfo.fragstotal * iinfo.fragsize;
	if (EXCESS_FRAGS * iinfo.fragsize > pagesize)
		errprintf(SEV_FATAL, "OSS: input: fragment size %d times excess frags >=
 page=20
size %d\n",
			  iinfo.fragsize, pagesize);
	/*
         * mmap buffers
         *
	 * BSD people attention: you may need to uncomment the PROT_READ
	 * feedback welcome: sailer@ife.ee.ethz.ch
	 */
	if ((ibuf.v =3D mmap(NULL, pagesize+isize, PROT_READ | PROT_WRITE,=20
			   MAP_ANON | MAP_PRIVATE, -1, 0)) =3D=3D MAP_FAILED)
		errstr(SEV_FATAL, "mmap: MAP_ANONYMOUS");
	ibuf_ext =3D ibuf.v + isize;
	if (munmap(ibuf.v, isize))
		errstr(SEV_FATAL, "munmap: MAP_ANONYMOUS");
/* following line: '| PROT_WRITE ' helps against abort in my machine. Gue=
nther=20
*/
	if ((ibuf.v =3D mmap(ibuf.v, isize, PROT_READ | PROT_WRITE, MAP_FILE=20
			  | MAP_SHARED | MAP_FIXED,=20
			  fd_audio, 0)) =3D=3D MAP_FAILED)
		errstr(SEV_FATAL, "mmap: PROT_READ");
	if ((obuf.v =3D mmap(NULL, osize, PROT_WRITE /* | PROT_READ*/,=20
			   MAP_FILE | MAP_SHARED, fd_audio, 0)) =3D=3D MAP_FAILED)
		errstr(SEV_FATAL, "mmap: PROT_WRITE");
	errprintf(SEV_INFO, "OSS: output: #frag: %d  fragsz: %d  totbuf: %d  buf=
addr:=20
%p\n"
		  "OSS: input: #frag: %d  fragsz: %d  totbuf: %d  bufaddr: %p  mempage:=
=20
%p\n"
		  "OSS: sample time increment: %u  fragment time increment: %u\n",
		  oinfo.fragstotal, oinfo.fragsize, osize, obuf.s,
		  iinfo.fragstotal, iinfo.fragsize, isize, ibuf.s, ibuf_ext,=20
		  (unsigned int)inc_sample, (unsigned int)(inc_fragment >> 24));
        /*
         * start playback/recording
         */
        apar =3D 0;
        if (ioctl(fd_audio, SNDCTL_DSP_SETTRIGGER, &apar) =3D=3D -1)
                errstr(SEV_FATAL, "ioctl: SNDCTL_DSP_SETTRIGGER");
	apar =3D PCM_ENABLE_OUTPUT | PCM_ENABLE_INPUT;
        if (ioctl(fd_audio, SNDCTL_DSP_SETTRIGGER, &apar) =3D=3D -1)
                errstr(SEV_FATAL, "ioctl: SNDCTL_DSP_SETTRIGGER");
	/*
	 * loop
	 */
	for (;;) {
		FD_ZERO(&rmask);
		FD_ZERO(&wmask);
		FD_SET(fd_audio, &rmask);
		FD_SET(fd_audio, &wmask);
		i =3D select(fd_audio+1, &rmask, &wmask, NULL, NULL);
		if (i < 0)=20
			errstr(SEV_FATAL, "select");
		if (!FD_ISSET(fd_audio, &rmask) && !FD_ISSET(fd_audio, &wmask))
			continue;
		/*
		 * process input
		 */
		if (ioctl(fd_audio, SNDCTL_DSP_GETIPTR, &cinfo) =3D=3D -1)
			errstr(SEV_FATAL, "ioctl: SNDCTL_DSP_GETIPTR");
		curfrag =3D cinfo.ptr / iinfo.fragsize;
		if (cinfo.blocks > 2)
			errprintf(SEV_WARNING, "%d fragments passed since last wakeup\n",=20
cinfo.blocks);
		while (ifragptr !=3D curfrag) {
			if (!ifragptr) {
				s =3D (short *)(ibuf.v + isize + iinfo.fragsize * ifragptr);
				memcpy(s, ibuf.v + iinfo.fragsize * ifragptr, iinfo.fragsize);
			} else
				s =3D (short *)(ibuf.v + iinfo.fragsize * ifragptr);
			if (samples_remain > 0) {
				i =3D 2*samples_remain;
				if (i > iinfo.fragsize)
					i =3D iinfo.fragsize;
				memcpy(samples_ptr, s, i);
				samples_ptr +=3D i/2;
				samples_remain -=3D i/2;
			}
			l1_input_samples(itime >> 24, inc_sample, s, iinfo.fragsize/2);
			itime +=3D inc_fragment;		=09
			ifragptr++;
			if (ifragptr >=3D iinfo.fragstotal)
				ifragptr =3D 0;
		}
		/*
		 * process output
		 */
		if (ioctl(fd_audio, SNDCTL_DSP_GETOPTR, &cinfo) =3D=3D -1)
			errstr(SEV_FATAL, "ioctl: SNDCTL_DSP_GETOPTR");
		curfrag =3D cinfo.ptr / oinfo.fragsize;
		nfrags =3D oinfo.fragstotal + curfrag - lastfrag;
		lastfrag =3D curfrag;
		if (nfrags >=3D oinfo.fragstotal)
			nfrags -=3D oinfo.fragstotal;
		if (nfrags !=3D cinfo.blocks)
			errprintf(SEV_WARNING, "OSS sound driver lost interrupt!\n");
		if (nfrags > 2)
			errprintf(SEV_WARNING, "%d fragments passed since last wakeup\n", nfra=
gs);
		ptt_frames -=3D nfrags;
		if (ptt_frames < 0) {
			otime +=3D (-ptt_frames) * inc_fragment;
			ofragptr -=3D ptt_frames;
			while (ofragptr >=3D oinfo.fragstotal)
				ofragptr -=3D oinfo.fragstotal;
			ptt_frames =3D 0;
			memset(obuf.s, 0, oinfo.fragsize * oinfo.fragstotal);
		}
		/* sanity check */
		if (!ptt_frames && ofragptr !=3D (curfrag + 1) % oinfo.fragstotal)
			errprintf(SEV_FATAL, "output pointers inconsistent %u %u %lu\n",
				  ofragptr, curfrag, (unsigned long)(otime >> 24));
		while (ptt_frames < oinfo.fragstotal && ptt_frames <=3D 4 &&=20
		       l1_output_samples(otime >> 24, inc_sample, (short *)(obuf.v +=20
oinfo.fragsize * ofragptr),=20
					 oinfo.fragsize/2)) {
			ofragptr++;
			if (ofragptr >=3D oinfo.fragstotal)
				ofragptr =3D 0;
			ptt_frames++;
			otime +=3D inc_fragment;
		}
		output_ptt(ptt_frames > 0);
	}
}

/* --------------------------------------------------------------------- =
*/

G=FCnther=20
Safari.Doktor@addcom.de


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
