From: =?iso-8859-15?q?G=FCnther=20Montag?= <Safari.Doktor@addcom.de>
Subject: Re: bugs found in ham program
Date: Fri, 3 Oct 2003 13:55:45 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <26933.4037126557$1065182616@news.gmane.org>
References: <200309261614.h8QGEQ3X011667@oud>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200309261614.h8QGEQ3X011667@oud>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>, Ralf-Axel Krause <ralf-axel-krause@gmx.de>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>, Ana Maria Grilo Moreira <ct1drb@vizzavi.pt>, Christopher Svenstedt <toffe@svenstedt.se>, dh8wr@winlink.org, hfterm-hackers@lists.sourceforge.net, sailer@ife.ee.ethz.ch, wgiovan@adinet.com.uy
List-Id: alsa-devel@alsa-project.org

Thanks all once more for help
I found 2 bugs, the one I had made myself:
I had changed mmap for input to PROT_READ | PROT_WRITE  (W R O N G !!)
which made endless loop system crash.
The other, after removing the first:
"memcpy" gave a segfault
I do not know why - it seems to have worked in old oss times
(I never tested it because I have half duplex card only,
this is in the full duplex driver)
if i look on it it must give a segfault!
Tom what do you think?
I put in a malloc for this memcpy -> now it runs
I append the new code.
please tell me what You think about it

/************************************************************************=
*****/

/*
 *      oss.c  --  Linux sound I/O.
 *
 *      Copyright (C) 1997  Thomas Sailer (sailer@ife.ee.ethz.ch)
 *        Swiss Federal Institute of Technology (ETH), Electronics Lab
 *
=2E.....

/* --------------------------------------------------------------------- =
*/

#define EXCESS_FRAGS 3

static void *fdx_driver(void *name_audio)
{
        size_t pagesize =3D getpagesize();
        int apar, fd_audio, i, brake, brakepoint =3D 7;
=09union {
=09=09caddr_t v;
=09=09short *s;
=09} ibuf;
=09caddr_t ibuf_ext;
=09union {
=09=09caddr_t v;
=09=09short *s;
=09} obuf;
=09struct audio_buf_info iinfo, oinfo;
=09unsigned int isize, osize;
=09unsigned int ifragptr, ofragptr;
=09fd_set rmask, wmask;
=09struct count_info cinfo;
=09unsigned int curfrag, lastfrag, nfrags;
=09unsigned long long itime, otime, inc_fragment;
=09l1_time_t inc_sample;
=09int ptt_frames;
=09short *s;
=09void * m;
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
=09=09errprintf(SEV_FATAL, "audio driver does not support the S16 format\=
n");
        apar =3D 0;
        if (ioctl(fd_audio, SNDCTL_DSP_STEREO, &apar) =3D=3D -1)
                errstr(SEV_FATAL, "ioctl: SNDCTL_DSP_STEREO");
        if (apar !=3D 0)
=09=09errprintf(SEV_FATAL, "audio driver does not support mono\n");
        apar =3D SAMPLE_RATE;
        if (ioctl(fd_audio, SNDCTL_DSP_SPEED, &apar) =3D=3D -1)
                errstr(SEV_FATAL, "ioctl: SNDCTL_DSP_SPEED");
=09if (apar !=3D SAMPLE_RATE) {
=09=09if (abs(apar-SAMPLE_RATE) >=3D SAMPLE_RATE/100)
=09=09=09errprintf(SEV_FATAL, "audio driver does not support 8kHz samplin=
g frequency\n");
=09}
=09inc_sample =3D 1000000.0*snd_corr/apar;
=09inc_fragment =3D 64*1000000.0*snd_corr/apar*(1<<24);
        ifragptr =3D 0;
=09itime =3D 0;
=09ofragptr =3D 1;
=09otime =3D ofragptr * inc_fragment;
=09ptt_frames =3D 0;
=09lastfrag =3D 0;
        /*
         * set fragment sizes
         */
        apar =3D 0xffff0007U;
        if (ioctl(fd_audio, SNDCTL_DSP_SETFRAGMENT, &apar) =3D=3D -1)
                errstr(SEV_FATAL, "ioctl: SNDCTL_DSP_SETFRAGMENT");
=09if (ioctl(fd_audio, SNDCTL_DSP_GETOSPACE, &oinfo) =3D=3D -1)
=09=09errstr(SEV_FATAL, "ioctl: SNDCTL_DSP_GETOSPACE");
=09osize =3D oinfo.fragstotal * oinfo.fragsize;
=09if (ioctl(fd_audio, SNDCTL_DSP_GETISPACE, &iinfo) =3D=3D -1)
=09=09errstr(SEV_FATAL, "ioctl: SNDCTL_DSP_GETISPACE");
=09isize =3D iinfo.fragstotal * iinfo.fragsize;
=09if (EXCESS_FRAGS * iinfo.fragsize > pagesize)
=09=09errprintf(SEV_FATAL, "OSS: input: fragment size %d times excess fra=
gs > page size %d\n",
=09=09=09  iinfo.fragsize, pagesize);
=09/*
         * mmap buffers
         *
=09 * BSD people attention: you may need to uncomment the PROT_READ
=09 * feedback welcome: sailer@ife.ee.ethz.ch
=09 */
=09if ((ibuf.v =3D mmap(NULL, pagesize + isize, PROT_READ,=20
=09=09=09   MAP_ANON | MAP_PRIVATE, -1, 0)) =3D=3D MAP_FAILED)
=09=09errstr(SEV_FATAL, "mmap: MAP_ANONYMOUS");
=09ibuf_ext =3D ibuf.v + isize;
=09if (munmap(ibuf.v, isize))
=09=09errstr(SEV_FATAL, "munmap: MAP_ANONYMOUS");
=09if ((ibuf.v =3D mmap(ibuf.v, isize , PROT_READ ,=20
=09=09=09    MAP_FILE  | MAP_SHARED | MAP_FIXED,=20
=09=09=09  fd_audio, 0)) =3D=3D MAP_FAILED)
=09=09errstr(SEV_FATAL, "mmap: PROT_READ");
=09=09
/* orig
=09if ((obuf.v =3D mmap(NULL, osize, PROT_WRITE -comment- | PROT_READ -co=
mment,=20
=09=09=09   MAP_FILE | MAP_SHARED, fd_audio, 0)) =3D=3D MAP_FAILED)
=09=09errstr(SEV_FATAL, "mmap: PROT_WRITE");
*/

=09if ((obuf.v =3D mmap(NULL, pagesize+osize, PROT_WRITE,=20
=09=09=09    MAP_ANON | MAP_PRIVATE, -1, 0)) =3D=3D MAP_FAILED)
=09=09errstr(SEV_FATAL, "mmap: obuf: MAP_ANONYMOUS");
//=09ibuf_ext =3D ibuf.v + isize;
=09if (munmap(obuf.v, osize))
=09=09errstr(SEV_FATAL, "munmap: obuf: MAP_ANONYMOUS");
=09if ((obuf.v =3D mmap(obuf.v, osize, PROT_WRITE /*| PROT_READ*/,=20
=09=09=09    MAP_FILE  | MAP_SHARED | MAP_FIXED,=20
=09=09=09    fd_audio, 0)) =3D=3D MAP_FAILED)
=09=09errstr(SEV_FATAL, "mmap: obuf: PROT_WRITE");


=09errprintf(SEV_INFO,=20
=09=09    "\nOSS:  input: #frag: %d  fragsz: %d  totbuf: %d  bufaddr: %p =
 mempage: %p\n"
=09=09    "OSS: output: #frag: %d  fragsz: %d  totbuf: %d  bufaddr: %p\n"
=09=09    "OSS: sample time increment: %u  fragment time increment: %u\n"=
,
=09=09    iinfo.fragstotal, iinfo.fragsize, isize, ibuf.s, ibuf_ext,=20
=09=09    oinfo.fragstotal, oinfo.fragsize, osize, obuf.s,
=09=09    (unsigned int)inc_sample, (unsigned int)(inc_fragment >> 24));
        /*
         * start playback/recording
         */
        apar =3D 0;
        if (ioctl(fd_audio, SNDCTL_DSP_SETTRIGGER, &apar) =3D=3D -1)
                errstr(SEV_FATAL, "ioctl: SNDCTL_DSP_SETTRIGGER");
=09apar =3D PCM_ENABLE_OUTPUT | PCM_ENABLE_INPUT;
        if (ioctl(fd_audio, SNDCTL_DSP_SETTRIGGER, &apar) =3D=3D -1)
                errstr(SEV_FATAL, "ioctl: SNDCTL_DSP_SETTRIGGER");
=09/*
=09 * loop
=09 */

=09for (;;) {
=09=09FD_ZERO(&rmask);
=09=09FD_ZERO(&wmask);
=09=09FD_SET(fd_audio, &rmask);
=09=09FD_SET(fd_audio, &wmask);
=09=09i =3D select(fd_audio+1, &rmask, &wmask, NULL, NULL);
=09=09if (i < 0)=20
=09=09=09errstr(SEV_FATAL, "select");
=09=09if (!FD_ISSET(fd_audio, &rmask) && !FD_ISSET(fd_audio, &wmask))
=09=09=09continue;
=09=09/*
=09=09 * process input
=09=09 */
=09=09if (ioctl(fd_audio, SNDCTL_DSP_GETIPTR, &cinfo) =3D=3D -1)
=09=09=09errstr(SEV_FATAL, "ioctl: SNDCTL_DSP_GETIPTR");
=09=09curfrag =3D cinfo.ptr / iinfo.fragsize;
//=09=09printf( "fdx in:  count info: bytes =3D %d, blocks =3D %d, ptr =3D=
 %d\n", cinfo.bytes, cinfo.blocks, cinfo.ptr );
=09=09if (cinfo.blocks > 2) {
=09=09=09errprintf(SEV_WARNING, "in:  %d fragments passed since last wake=
up\n", cinfo.blocks);
=09=09=09brake ++;
=09=09=09}
=09=09if (brake >=3D brakepoint) {
=09=09=09errprintf(SEV_FATAL, "%d xruns. Exiting.\n", brake);
=09=09=09exit (1);
=09=09=09}
=09=09
=09=09while (ifragptr !=3D curfrag) {

=09=09=09if (!ifragptr)=20
=09=09=09
=09=09=09{
=09=09=09=09m =3D malloc(pagesize);
=09=09=09=09if (m =3D=3D NULL)
=09   =09=09=09    errstr(SEV_FATAL, "fdx_driver: malloc failed");
=09=09=09=09//=09s =3D (short *)(ibuf.v + isize );
=09=09=09=09s =3D (short *) m;
=09=09//=09=09printf("\nifragptr: %d, curfrag %d, ibuf.v: %p, s: %p \n",
=09=09//=09=09ifragptr, curfrag, ibuf.v, s);  =09=09=09=20
=09=09//=09=09printf ("shift mem malloced in %p\n", m);
=09=09=09=09memcpy(s, ibuf.v, iinfo.fragsize);
=09=09=09}=20
=09=09=09
=09=09=09else
=09=09=09=09s =3D (short *)(ibuf.v + iinfo.fragsize * ifragptr);
=09=09//=09printf("=3D\nifragptr: %d, curfrag %d, ibuf.v: %p, s: %p \n",=20
=09=09//=09        ifragptr, curfrag, ibuf.v, s);  =09=09=09
=09=09=09
=09=09=09if (samples_remain > 0) {
=09=09=09=09i =3D 2*samples_remain;
=09=09=09=09if (i > iinfo.fragsize)
=09=09=09=09=09i =3D iinfo.fragsize;
=09=09=09=09memcpy(samples_ptr, s, i);
=09=09
=09=09//=09=09printf("\nsamples_remain: %d, samples_ptr: %p, i: %d", samp=
les_remain, samples_ptr, i);  =09=09=09
=09=09=09=09=09=09=09=09
=09=09=09=09samples_ptr +=3D i/2;
=09=09=09=09samples_remain -=3D i/2;
=09=09=09}
=09=09=09
=09=09=09l1_input_samples(itime >> 24, inc_sample, s, iinfo.fragsize/2);
=09=09=09itime +=3D inc_fragment;=09=09=09
=09=09=09if (!ifragptr) free(m);
=09=09=09ifragptr++;
=09=09=09if (ifragptr >=3D iinfo.fragstotal)
=09=09=09=09ifragptr =3D 0;
=09=09}
=09=09/*
=09=09 * process output
=09=09 */
=09=09if (ioctl(fd_audio, SNDCTL_DSP_GETOPTR, &cinfo) =3D=3D -1)
=09=09=09errstr(SEV_FATAL, "ioctl: SNDCTL_DSP_GETOPTR");
=09=09curfrag =3D cinfo.ptr / oinfo.fragsize;
//=09=09printf( "fdx out: count info: bytes =3D %d, blocks =3D %d, ptr =3D=
 %d\n", cinfo.bytes, cinfo.blocks, cinfo.ptr );
=09=09nfrags =3D oinfo.fragstotal + curfrag - lastfrag;
=09=09lastfrag =3D curfrag;
=09=09if (nfrags >=3D oinfo.fragstotal)
=09=09=09nfrags -=3D oinfo.fragstotal;
=09=09if (nfrags !=3D cinfo.blocks)
=09=09=09errprintf(SEV_WARNING, "OSS sound driver lost interrupt!\n");
=09=09if (nfrags > 2) {
=09=09=09errprintf(SEV_WARNING, "out: %d fragments passed since last wake=
up\n", nfrags);
=09=09=09brake ++;
=09=09=09}
=09=09ptt_frames -=3D nfrags;
=09=09if (ptt_frames < 0) {
=09=09=09otime +=3D (-ptt_frames) * inc_fragment;
=09=09=09ofragptr -=3D ptt_frames;
=09=09=09while (ofragptr >=3D oinfo.fragstotal)
=09=09=09=09ofragptr -=3D oinfo.fragstotal;
=09=09=09ptt_frames =3D 0;
=09=09=09memset(obuf.s, 0, oinfo.fragsize * oinfo.fragstotal);
=09=09}
=09=09/* sanity check */
=09=09if (!ptt_frames && ofragptr !=3D (curfrag + 1) % oinfo.fragstotal)
=09=09=09errprintf(SEV_FATAL, "output pointers inconsistent %u %u %lu\n",
=09=09=09=09  ofragptr, curfrag, (unsigned long)(otime >> 24));
=09=09while (ptt_frames < oinfo.fragstotal && ptt_frames <=3D 4 &&=20
=09=09       l1_output_samples(otime >> 24, inc_sample, (short *)(obuf.v =
+ oinfo.fragsize * ofragptr),=20
=09=09=09=09=09 oinfo.fragsize/2)) {
=09=09=09ofragptr++;
=09=09=09if (ofragptr >=3D oinfo.fragstotal)
=09=09=09=09ofragptr =3D 0;
=09=09=09ptt_frames++;
=09=09=09otime +=3D inc_fragment;
=09=09}
=09=09output_ptt(ptt_frames > 0);
=09}
}

/* --------------------------------------------------------------------- =
*/

static void *hdx_driver(void *name_audio)
=2E....

cheers
Safari.Doktor@addcom.de


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
