From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Assert in pcm_params.c
Date: Tue, 21 Apr 2015 10:54:35 +0800
Message-ID: <CAN8ccibzTzBQgae9u_JtGPi_EZVMrKcB3qSXdmUPjCeaYd2i8Q@mail.gmail.com>
References: <201504180908.47022.gineera@aspect135.co.uk>
 <201504181207.26711.gineera@aspect135.co.uk>
 <CAN8cciaDr+0sdLPjOD1evTHjA6mSDMasM_ZgDpCanWE1Dbbd6w@mail.gmail.com>
 <201504201231.04341.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f181.google.com (mail-ob0-f181.google.com
 [209.85.214.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 7FF342606D2
 for <alsa-devel@alsa-project.org>; Tue, 21 Apr 2015 04:54:36 +0200 (CEST)
Received: by obcux3 with SMTP id ux3so30483559obc.2
 for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2015 19:54:35 -0700 (PDT)
In-Reply-To: <201504201231.04341.gineera@aspect135.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alan Horstmann <gineera@aspect135.co.uk>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> > > > > Hi,
> > > > >
> > > > > The following assert is being hit in pcm_params.c:
> > > > >
> > > > > "pcm_params.c:2249: snd1_pcm_hw_params_slave: Assertion `err >=
0'>
> > > > > failed."
> > > > >
> > > > > This is from a developer using Portaudio in his own application; I
> <snip>
> > > > > Does this point to a flaw in the configuration or possibly a bug
in
> > > > > Alsa-lib or can it occur just as a result of misuse of the Alsa
API?
> >
> >
http://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m___h_w___params.
> > > >
> > > > Only snd_pcm_hw_params_test_rate() can be call multiple times,
> > > > Verify if a rate is available inside a configuration space for a
PCM.
> > > >
> > > > Those snd_pcm_hw_params_ser_rate*  functions restrict the
configuration
> > > > space to one rate and can be called once only
> > >
> > > The stream is being opened and closed at each attempt.
> >
> > Seem Delta 44 does not support 2,4,6 or 8 channels
>
> This issue is not on Delta44, but an Intel motherboard.  But I would not
> expect to hit an assert in Alsa-lib whatever we do, surely?

> call to Pa_IsFormatSupported(NULL, &outputParameters, samprate ); will
cause a crasch for a certain samprate. The Linrad log file is like this:
TESTING PORTAUDIO DEVICE 10 FOR Rx output

id=10 device=front hostapi=ALSA max_input_chan=0 max_output_chan=6 Testing
0 8000.000000 err=-9997 Invalid sample rate
Testing 1 9600.000000 err=-9997 Invalid sample rate
Testing 2 11025.000000 err=-9997 Invalid sample rate
Testing 3 12000.000000 err=-9997 Invalid sample rate
Testing 4 16000.000000 err=-9997 Invalid sample rate
Testing 5 22050.000000 err=-9997 Invalid sample rate
Testing 6 24000.000000 err=-9997 Invalid sample rate
Testing 7 32000.000000 err=-9997 Invalid sample rate
Testing 8 44100.000000

9600,12000 are not in Table 56. Defined Sample Rates of HDA specification

http://git.kernel.org/cgit/linux/kernel/git/tiwai/hda-emu.git/tree/codecs/ad1988b-asus-p5b-deluxe-wifi?id=HEAD

Most 6 channels audio are at 48000Hz, but some application upmix stereo
44100Hz to 6 channels

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda?id=5f1545bc45a33361d6bb2fb44af7c35bcd733b9d

>From the HDA spec it appears that the buffers written to the BDL and
sent to a codec must be 128 byte aligned (section 4.5.1).  The alignment
was not happening especially when playing 6 channels.

Do you mean the driver still have this alignment when playing 6 channel ?
I
