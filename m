From: Ted <ted@nowtsfree.freeserve.co.uk>
Subject: alsa-lib-1.0.0rc2/src/pcm/pcm.c and RATE: NONE ??
Date: Wed, 31 Dec 2003 07:09:39 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031231070940.0AEF14958@marimba.home.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: ted@nowtsfree.freeserve.co.uk
List-Id: alsa-devel@alsa-project.org

Hello and happy new year.

I'm having problems getting the pcm hw parameters set up correctly:

| $ sg audio -c "./aplay /opt/qt-2.2.4/examples/sound/sounds/1.wav"
| Playing WAVE '/opt/qt-2.2.4/examples/sound/sounds/1.wav' : \
| 	Unsigned 8 bit, Rate 8000 Hz, Mono
| aplay: set_params:875: Unable to install hw params:
| ACCESS:  RW_INTERLEAVED
| FORMAT:  U8
| SUBFORMAT:  STD
| SAMPLE_BITS: 8
| FRAME_BITS: 8
| CHANNELS: 1
| RATE: NONE					<---- looks bad
| PERIOD_TIME: (1365333 1365334)		<---- ditto
| PERIOD_SIZE: (183712867 183712868)		<---- ditto
| PERIOD_BYTES: (183712867 183712868)
| PERIODS: (1 2)
| BUFFER_TIME: (1365333 1365334)
| BUFFER_SIZE: 183712912
| BUFFER_BYTES: 183712912
| TICK_TIME: 10000

Running aplay under gdb reveals:

| (gdb) where
| #0  snd_pcm_hw_param_set_near (pcm=0x805ad08, params=0xbffff654,
|     var=SNDRV_PCM_HW_PARAM_RATE, val=0xbffff5dc, dir=0x0) at pcm_params.c:787
| #1  0x4005459a in __snd_pcm_hw_params_set_rate_near (pcm=0x805ad08,
|     params=0xbffff654, val=0xbffff5dc, dir=0x0) at pcm.c:3593
| #2  0x400582a4 in snd_pcm_hw_params_set_rate_near (pcm=0x805ad08,
|     params=0xbffff654, val=134555356, dir=0x0) at pcm.c:6437
| #3  0x804c4fd in set_params () at aplay.c:841
| #4  0x804ec53 in playback_go (fd=4, loaded=0, count=8580, rtype=2,
|     name=0xbffffca9 "/opt/qt-2.2.4/examples/sound/sounds/1.wav")
|     at aplay.c:1776
| #5  0x804f0ef in playback (
|     name=0xbffffca9 "/opt/qt-2.2.4/examples/sound/sounds/1.wav")
|     at aplay.c:1899
| #6  0x804b796 in main (argc=2, argv=0xbffffb44) at aplay.c:553
| #7  0x40101856 in __libc_start_main (main=0x804ad7c <main>, argc=2,
|     argv=0xbffffb44, init=0x8049d68 <_init>, fini=0x804fa94 <_fini>,
|     rtld_fini=0x4000a480 <_dl_fini>, stack_end=0xbffffb3c)
|     at ../sysdeps/generic/libc-start.c:92

| (gdb) list 780,786
| 780     int snd_pcm_hw_param_set_near(snd_pcm_t *pcm, snd_pcm_hw_params_t *params,
| 781                                   snd_pcm_hw_param_t var,
| 782                                   unsigned int *val, int *dir)
| 783     {
| 784             snd_pcm_hw_params_t save;
| 785             int err;
| 786             unsigned int best = *val, saved_min;
| (gdb) print *val
| $2 = 134555356
| (gdb) print **val
| $3 = 8000		<---- this is what should be assigned to "best"
| (gdb) print best
| $4 = 134555356

The 4th argument to snd_pcm_hw_param_set_near(), and
the 3rd argument to __snd_pcm_hw_params_set_rate_near(),
named "val", seems to have been dereferenced once too often.

I suspect the macro __P_OLD_NEAR1(pfx, name, ret_type) in /src/pcm/pcm.c,
but have also seen the discussion early in November, 2003,

  Subject: Re: [Alsa-devel] switch to new PCM API for 1.0 release
    between Jaroslav Kysela <perex@suse.cz> and
	    Martin Langer <martin-langer@gmx.de>

where the cause was mixing libraries or headers of different versions.
I have not found any sign of this here, although it does seem strange
that there are not more people reporting the same problem.

alsa-lib-1.0.0rc2 was configured with
CFLAGS="-g -O2" LDFLAGS="-g -O2" ./configure \
	--with-versioned=no --with-debug=yes

alsa-utils-1.0.0rc2 was configured with
CFLAGS="-g O2" LDFLAGS="-g O2" ./configure

and I'm using gcc 2.95.3 and linux-2.2.25.

Ted.
-- 
Ted <ted@nowtsfree.freeserve.co.uk>
   http://www.nowtsfree.freeserve.co.uk


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
