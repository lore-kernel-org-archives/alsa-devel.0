From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Assert in pcm_params.c
Date: Mon, 20 Apr 2015 22:45:28 +0800
Message-ID: <CAN8ccibgvLdyL426V4_Qe7FpFv0xBu0-r+q5T2DE3mJHEx+i6A@mail.gmail.com>
References: <201504180908.47022.gineera@aspect135.co.uk>
 <201504201217.36477.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f46.google.com (mail-oi0-f46.google.com
 [209.85.218.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 11B722659ED
 for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2015 16:45:30 +0200 (CEST)
Received: by oica37 with SMTP id a37so124159788oic.0
 for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2015 07:45:29 -0700 (PDT)
In-Reply-To: <201504201217.36477.gineera@aspect135.co.uk>
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
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> > The following assert is being hit in pcm_params.c:
> >
> > "pcm_params.c:2249: snd1_pcm_hw_params_slave: Assertion `err >= 0'
failed."
> >
> > This is from a developer using Portaudio in his own application; I have
yet
> > to ascertain full details, but it is trying successive sample rates to
see
> > which are valid.
>
> Further info: this occurs with an Intel motherboard/soundcard, attempting
to
> open and config the stream at 44100 using front, surround or hdmi pcm,
having
> previously opened and tried at a lower, not-supported samplerate, and
closed.
> AFAIK other pcms work

call to Pa_IsFormatSupported(NULL, &outputParameters, samprate );
will cause a crasch for a certain samprate. The Linrad log file
is like this:
TESTING PORTAUDIO DEVICE 10 FOR Rx output

id=10 device=front hostapi=ALSA max_input_chan=0 max_output_chan=6
Testing 0 8000.000000  err=-9997  Invalid sample rate
Testing 1 9600.000000  err=-9997  Invalid sample rate
Testing 2 11025.000000  err=-9997  Invalid sample rate
Testing 3 12000.000000  err=-9997  Invalid sample rate
Testing 4 16000.000000  err=-9997  Invalid sample rate
Testing 5 22050.000000  err=-9997  Invalid sample rate
Testing 6 24000.000000  err=-9997  Invalid sample rate
Testing 7 32000.000000  err=-9997  Invalid sample rate
Testing 8 44100.000000

This means that the call to Pa_IsFormatSupported did not return
when samprate=44100.

The terminal window (stderr) shows this:
root <at> Xeon:/home/dsp# ./xlinrad64
ALSA lib confmisc.c:1286:(snd_func_refer) Unable to find definition
'cards.HDA-Intel.pcm.rear.0:CARD=0'
ALSA lib conf.c:4259:(_snd_config_evaluate) function snd_func_refer returned
error: No such file or directory
ALSA lib conf.c:4738:(snd_config_expand) Evaluate error: No such file or
directory
ALSA lib pcm.c:2239:(snd_pcm_open_noupdate) Unknown PCM rear
ALSA lib confmisc.c:1286:(snd_func_refer) Unable to find definition
'cards.HDA-Intel.pcm.center_lfe.0:CARD=0'
ALSA lib conf.c:4259:(_snd_config_evaluate) function snd_func_refer returned
error: No such file or directory
ALSA lib conf.c:4738:(snd_config_expand) Evaluate error: No such file or
directory
ALSA lib pcm.c:2239:(snd_pcm_open_noupdate) Unknown PCM center_lfe
ALSA lib confmisc.c:1286:(snd_func_refer) Unable to find definition
'cards.HDA-Intel.pcm.side.0:CARD=0'
ALSA lib conf.c:4259:(_snd_config_evaluate) function snd_func_refer returned
error: No such file or directory
ALSA lib conf.c:4738:(snd_config_expand) Evaluate error: No such file or
directory
ALSA lib pcm.c:2239:(snd_pcm_open_noupdate) Unknown PCM side
ALSA lib pcm_route.c:947:(find_matching_chmap) Found no matching channel map
ALSA lib pulse.c:243:(pulse_connect) PulseAudio: Unable to connect:
Connection refused

ALSA lib pulse.c:243:(pulse_connect) PulseAudio: Unable to connect:
Connection refused

Cannot connect to server socket err = No such file or directory
Cannot connect to server request channel
jack server is not running or cannot be started
xlinrad64: pcm_params.c:2249: snd1_pcm_hw_params_slave: Assertion `err >= 0'
failed.
Aborted

Most likely bug in those user defined devices

Do portaudio hardcode "rear" device ?

http://git.alsa-project.org/?p=alsa-lib.git;a=blob;f=src/conf/cards/HDA-Intel.conf;hb=HEAD

Not all hda codecs support 44100Hz

Which hda codec?

>
> The assert is hit with all current Debian and Ubuntu distros, for example
>      Debian 8 (jessie) 32 bit:  kernel 3.16.0-4-686-pae (Alsa 1.0.28)
> but is not seen with Fedora 20 or OpenSuse 12.1 (do they have asserts
off?).
>
> > Does this point to a flaw in the configuration or possibly a bug in
> > Alsa-lib or can it occur just as a result of misuse of the Alsa API?
>
> I will try to conceive some more tests.  How can we debug this further
> Regards
>
>

Output of alsa-info.sh

and those customised devices in asoundrc
