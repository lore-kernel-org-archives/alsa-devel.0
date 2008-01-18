From: "Christophe Osuna" <christophe.osuna@gmail.com>
Subject: Re: Problems with ALC882
Date: Fri, 18 Jan 2008 17:10:06 +0100
Message-ID: <b6251a620801180810y6628debcxf9ff36de35514848@mail.gmail.com>
References: <b6251a620801160920q327049ffifa72f77b17738f75@mail.gmail.com>
	<s5hzlv5r7yx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.180])
	by alsa0.perex.cz (Postfix) with ESMTP id BD45A243FA
	for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2008 17:10:09 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id m33so1791913wag.8
	for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2008 08:10:07 -0800 (PST)
In-Reply-To: <s5hzlv5r7yx.wl%tiwai@suse.de>
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2008/1/16, Takashi Iwai <tiwai@suse.de>:
> At Wed, 16 Jan 2008 18:20:20 +0100,
> Christophe Osuna wrote:
> >
> > I am having a bad time trying to get an ALC882 [1] to work. I hope
> > that you can help me. Currently I am using alsa-driver-1.0.14 but it
> > would probably be the same with 1.0.15 since there has been no change
> > in /pci/hda/.
>
> There have been tons of changes for HD-audio between these versions :)
> You should have looked at alsa-driver*/alsa-kernel/pci/hda.
>
> Anyway, now it's much better to try the latest ALSA HG version than
> 1.0.15.  1.0.15 is so old.  If you are not familiar with HG, try the
> daily snapshot tarball below:
>
>         ftp://ftp.suse.com/pub/projects/alsa/snapshot/
>

I have tried alsa-driver-hg20080117; it shows two additional mixer
options (Mic Boost and Front Mic Boost) but in the end it's the same:
I am unable to access the 3rd ADC.

  ~# cat /proc/asound/version
  Advanced Linux Sound Architecture Driver Version 1.0.15.
  Compiled on Jan 18 2008 for kernel 2.6.23.14-soos (SMP).
  ~# cat /proc/asound/devices
    0: [ 0]   : control
    6: [ 0- 2]: hardware dependent
   16: [ 0- 0]: digital audio playback
   17: [ 0- 1]: digital audio playback
   24: [ 0- 0]: digital audio capture
   25: [ 0- 1]: digital audio capture
   26: [ 0- 2]: digital audio capture
   33:        : timer
  ~# cat /proc/asound/pcm
  00-02: ALC882 Analog : ALC882 Analog : capture 2
  00-01: ALC882 Digital : ALC882 Digital : playback 1 : capture 1
  00-00: ALC882 Analog : ALC882 Analog : playback 1 : capture 2
  ~# arecord -l
  **** List of CAPTURE Hardware Devices ****
  card 0: Intel [HDA Intel], device 0: ALC882 Analog [ALC882 Analog]
    Subdevices: 2/2
    Subdevice #0: subdevice #0
    Subdevice #1: subdevice #1
  card 0: Intel [HDA Intel], device 1: ALC882 Digital [ALC882 Digital]
    Subdevices: 1/1
    Subdevice #0: subdevice #0
  card 0: Intel [HDA Intel], device 2: ALC882 Analog [ALC882 Analog]
    Subdevices: 2/2
    Subdevice #0: subdevice #0
    Subdevice #1: subdevice #1

When I start two instances of arecord to pipe hw:0,0,0 and hw:0,2,0 to
/dev/null, both stop because of I/O error.

The ALC882 datasheet states that "3 stereo ADCs support 16/20-bit PCM
format, two for microphone array, one for legacy mixer recording".
This is the only place that suggests there could be a difference, but
I do not understand this sentence as "only 2 ADC can be used at a
time" (English is not my native language). The block diagram in the
following page does not suggest such a limit either.

Besides that I have read in the same datasheet that "rates in
sub-multiples (1/n) of 48kHz are interleaving n frames containing no
sample blocks" and so we can have 8 kHz by setting one sample block
every six frames. Still, I can't set the device to 8 kHz.

Here is a summary of my questions:
1) Why is the 3rd ADC missing from PCM (the mixer does show it)?
2) If that is a bug, where should I look first? (However, because of
my very limited experience I am not very confident in fixing that
myself)
3) Is it possible to use two ALC882 driven by the same HDA?
4) In that case, how will I be able to access the second ALC882 (hw:0,x,y)?
5) Still in that case, will I be able to use snd_pcm_link() for all devices?
6) Would you know any ALSA-supported card with three ADC?
7) Does HDA really support 8 kHz?
8) If it does, will ALSA support it?

Thanks for your help.
