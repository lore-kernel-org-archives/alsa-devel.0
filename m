From: =?iso-8859-15?q?G=FCnther=20Montag?= <Safari.Doktor@addcom.de>
Subject: Re: [Hfterm-hackers] Re: env LD_PRELOAD=/usr/lib/libaoss.so ....
Date: Tue, 21 Oct 2003 13:56:27 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200310211356.27457.Safari.Doktor@addcom.de>
References: <200310161413.28379.Safari.Doktor@addcom.de> <200310161756.10517.Safari.Doktor@addcom.de> <s5hr81df7n5.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: Quoted-Printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hr81df7n5.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net, hfterm-hackers@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hallo Takashi!
> >
> > > ~/.asoundrc.  simply add
> > >
> > > 	pcm.dsp0 pcm.default
> >
> > Thanks! It helped one step more!
> > Now:
> > ***
> > hfkernel[1488]: hfkernel 0.4.2 starting...
> > hfkernel[1488]: Your soundcard is full duplex capable.
> > Good; the reference time will be
> > derived from the sample clock, which should be accurate within +-20pp=
m.
> > So I hope your soundcard uses 'real' crystals instead of cheap cerami=
c
> > resonators. Adjust the clock with the soundcard correction factor.
> > ALSA lib pcm_plug.c:727:(snd_pcm_plug_hw_refine_schange) Unable to fi=
nd
> > an usable access for 'dsp0'
> > hfkernel[1488]: error: probe_oss: mmap: ibuf: PROT_READ: Invalid argu=
ment
>
> hmm, how about the following?
>
> 	pcm.dsp0 {
> 		type hw
> 		card 0
> 	}
>
Oh, one step on!=20
Now no error any more from the ALSA lib,
but still it says.
hfkernel[1488]: error: probe_oss: mmap: ibuf: PROT_READ: Invalid argument

this comes from last line of following snip:
***
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
	if ((ibuf.v =3D mmap(NULL, isize, PROT_READ | PROT_WRITE,=20
			   MAP_ANON | MAP_PRIVATE, -1, 0)) =3D=3D MAP_FAILED)
		errstr(SEV_FATAL, "mmap: MAP_ANONYMOUS");
	ibuf_ext =3D ibuf.v + isize;
	if (munmap(ibuf.v, isize))
		errstr(SEV_FATAL, "munmap: MAP_ANONYMOUS");
	if ((ibuf.v =3D mmap(ibuf.v, isize, PROT_READ, MAP_FILE=20
			  | MAP_SHARED | MAP_FIXED,=20
			  fd_audio, 0)) =3D=3D MAP_FAILED)

***
so i suppose something wrong with "isize"
only with ESS1938, it works with other cards.
Not-linear physical buffer in the card?
Do You know some hint, some trick out of ALSA API, how to "wrap" mmap?=20
g=FCnther




-------------------------------------------------------
This SF.net email is sponsored by OSDN developer relations
Here's your chance to show off your extensive product knowledge
We want to know what you know. Tell us and you have a chance to win $100
http://www.zoomerang.com/survey.zgi?HRPT1X3RYQNC5V4MLNSV3E54
