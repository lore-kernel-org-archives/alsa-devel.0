From: Shilpa Kedar Walvekar <shilpa.walvekar@coreobjects.com>
Subject: Re: Using 8bit mono at 8000Hz with arecord and aplay -
 Full duplex operation
Date: Thu, 20 Aug 2009 12:17:50 +0530
Message-ID: <33A0EEB8D50198449794A1AB9DEB1E0186643AE3ED@copuex01.coreobjects.com>
References: <33A0EEB8D50198449794A1AB9DEB1E0186642A95DC@copuex01.coreobjects.com>
	<4A8A7BA8.9050906@gmail.com>
	<33A0EEB8D50198449794A1AB9DEB1E0186643AE17F@copuex01.coreobjects.com>
	<s5hhbw4cdok.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from colaex01.coreobjects.com (mailus.coreobjects.com [67.89.120.9])
	by alsa0.perex.cz (Postfix) with ESMTP id B3899243C6
	for <Alsa-devel@alsa-project.org>;
	Thu, 20 Aug 2009 08:47:56 +0200 (CEST)
In-Reply-To: <s5hhbw4cdok.wl%tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "Alsa-devel@alsa-project.org" <Alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

What we did was:
Modify the asound.conf and .asoundrc as:
pcm_slave.default { pcm "hw:0,0" format U8 channels 1 rate 8000 } pcm.!default{ type plug slave default } ct1.!default { type hw card 0 }

Then issue following commnd:
arecord -D default /home/test_record

We get following error:
Recording WAVE '/home/test_arecord' : Unsigned 8 bit, Rate 8000 Hz, Mono
arecord: set_params:979: Sample format non available


Apart from this, we are also facing problem with playing and recording simultaneously. We are using multi threading and Alsa apis to achieve this. One thread plays continuously using "snd_pcm_writei" and other thread records using "snd_pcm_readi". Snd_pcm_readi always returns with error:
"read from audio interface failed (Broken pipe)"

Why this read call is failing? Are we missing anything?

Regards,
--Shilpa.


-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de]
Sent: Wednesday, August 19, 2009 3:45 PM
To: Shilpa Kedar Walvekar
Cc: Alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] Using 8bit mono at 8000Hz with arecord and aplay - Full duplex operation

At Wed, 19 Aug 2009 14:28:52 +0530,
Shilpa Kedar Walvekar wrote:
>
> The driver and the hardware supports it as we have played audio file of this format using raw open/read/write calls (without using ALSA).
> Since we want Full duplex so we switched to alsa.
>
> We tried to use plug as well as follows:
> pcm_slave.sl3 {
>  pcm
>  format U8
>  channels 1
>  rate 8000
> }
>
> pcm.complex_convert {
>  type plug
>  slave sl3
> }
>
> Then still the same error, " Sample format non available"

Are you sure that you are opening the PCM with "complex_convert"?
Better to show exactly what you did and what you got.


Takashi

> Now we are trying to record and play .wav audio file in full duplex mode: We have two threads, one is playing the file continuously (S16_LE, 48000) and other thread is trying to record to a wav file (here using S16_LE, 44100). Now we get error "Broken pipe" for each snd_pcm_readi call.
> We are stuck here and cannot move forward.
>
> Code used for recording is:
>
> /* open sound device */
>        if ((err = snd_pcm_open(&handle, "hw:0,0", SND_PCM_STREAM_CAPTURE, 0))
< 0) {
>                  printf("Capture open error: %s\n", snd_strerror(err));
>                  exit(EXIT_FAILURE);
>          }
>
>
>         if ((err = snd_pcm_set_params(handle,
>                                        SND_PCM_FORMAT_S16_LE,
>                                        SND_PCM_ACCESS_RW_INTERLEAVED,
>                                        2, //channels
>                                        44100,
>                                        1,
>                                             0)) < 0) {
>
>                  printf("set_param_Capture open error: %s\n", snd_strerror(err));
>                  exit(EXIT_FAILURE);
>          }
>
>
> /* open file for recording */
>         write_fd = open(writefile,O_WRONLY | O_CREAT , 0777);
>         if(write_fd < 0)
>         {
>                 fprintf(stderr,"Can't open %s\ns",writefile);
>                 exit(1);
>         }
>
>
>         while(1)
>         {
>                 if ((err = snd_pcm_prepare (handle)) < 0) {
>                         fprintf (stderr, "cannot prepare audio interface for use (%s)\n",
>                                 snd_strerror (err));
>
>                 }
>
>
>                          if ((err = snd_pcm_readi (handle, buf_mic, mic_samples)) != mic_samples) {
>                                 fprintf (stderr, "read from audio interface failed (%s)\n",
>                                          snd_strerror (err));
>                         }
>
>         }
>
> Note: recording works successfully using arecord.
>
> Please help us to resolve:
> 1. Recording and Playing 8bit mono audio at 8000Hz
> 2. Full duplex functionality using alsa apis
>
>
> Thanks & Regards,
> --Shilpa.
>
> -----Original Message-----
> From: Stefan Schoenleitner [mailto:dev.c0debabe@gmail.com]
> Sent: Tuesday, August 18, 2009 3:30 PM
> To: Shilpa Kedar Walvekar
> Cc: alsa-devel@alsa-project.org
> Subject: Re: [alsa-devel] Using 8bit mono at 8000Hz with arecord and aplay
>
> Shilpa Kedar Walvekar wrote:
> > Hello,
> >
> > We tried to record and play the recorded file using arecord and aplay as follows:
> > arecord -f cd /home/test.wav
> > aplay -f cd /home/test.wav
> >
> > The file gets recorded and played correctly.
> >
> > But if I try to record file of format S8 or U8, I get error:
> >
> > # arecord -f U8 /home/test_alsa_record_2
> > Recording WAVE '/home/test_alsa_record_2' : Unsigned 8 bit, Rate 8000 Hz, Mono
> > arecord: set_params:979: Sample format non available
> >
> > # arecord -f S8 /home/alsa_record_2
> > Recording WAVE '/home/alsa_record_2' : Signed 8 bit, Rate 8000 Hz, Mono
> > arecord: set_params:979: Sample format non available
> >
> > Is there any other way to set the format as S8 or U8? Or only cd/cdr/dat formats can be played using alsa?
>
> Basically it should be possible to play these formats.
> If you look at the aplay help output, it also lists the recognized
> sample formats (which include U8 and S8).
>
> However, it also says "Some of these may not be available on selected
> hardware".
>
> For this reason I assume that your hardware (or at least the driver)
> does not support these formats.
>
> A workaround is to use one of the ALSA format conversion plugins.
> (see here: http://www.alsa-project.org/alsa-doc/alsa-lib/pcm_plugins.html)
>
> Specifically have a look at the rate or plug plugin.
>
> The idea is that you can play arbitrary formats and the plugin
> automatically converts the PCM streams to a fixed format that your
> hardware can deal with (e.g. 16 bit at 48 kHz).
>
> cheers,
> stefan
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
