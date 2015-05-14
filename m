From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Assert in pcm_params.c
Date: Thu, 14 May 2015 09:34:32 +0800
Message-ID: <CAN8cciZCDiz2ihbxSZZ5zovtkvX_EBWc6v2BG=wevCq2_WBaYg@mail.gmail.com>
References: <201504180908.47022.gineera@aspect135.co.uk>
 <201504201217.36477.gineera@aspect135.co.uk>
 <201505010836.47714.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f49.google.com (mail-oi0-f49.google.com
 [209.85.218.49])
 by alsa0.perex.cz (Postfix) with ESMTP id CB92B2605D3
 for <alsa-devel@alsa-project.org>; Thu, 14 May 2015 03:34:33 +0200 (CEST)
Received: by oiko83 with SMTP id o83so45419964oik.1
 for <alsa-devel@alsa-project.org>; Wed, 13 May 2015 18:34:32 -0700 (PDT)
In-Reply-To: <201505010836.47714.gineera@aspect135.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alan Horstmann <gineera@aspect135.co.uk>, Leif Asbrink <leif@sm5bsz.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> > The following assert is being hit in pcm_params.c:
> > >
> > > "pcm_params.c:2249: snd1_pcm_hw_params_slave: Assertion `err >= 0'
> > > failed."
> > >
> > > This is from a developer using Portaudio in his own application; I have
> > > yet to ascertain full details, but it is trying successive sample rates
> > > to see which are valid.
> >
> > Further info: this occurs with an Intel motherboard/soundcard, attempting
> > to open and config the stream at 44100 using front, surround or hdmi pcm,
> > having previously opened and tried at a lower, not-supported samplerate,
> > and closed. AFAIK other pcms work OK.
> >
> > The assert is hit with all current Debian and Ubuntu distros, for example
> >      Debian 8 (jessie) 32 bit:  kernel 3.16.0-4-686-pae (Alsa 1.0.28)
> > but is not seen with Fedora 20 or OpenSuse 12.1 (do they have asserts
> > off?).
> >
> > > Does this point to a flaw in the configuration or possibly a bug in
> > > Alsa-lib or can it occur just as a result of misuse of the Alsa API?
> >
> > I will try to conceive some more tests.  How can we debug this further?
>
> A minimal self-contained demo program ('test-format') has been developed
> and
> is attached, that demonstrates the issue 100% on the reporters machine
> (HDA-Intel, 6-ch I believe).  The output is:
>
> root@Xeon:/home/patest# ./test-format
> Testing device front
> Num channels 6
> Testing rate: 22050   Result:...Invalid Sample Rate
> Testing rate: 32000   Result:...Invalid Sample Rate
> test-format: pcm_params.c:2249: snd1_pcm_hw_params_slave: Assertion `err >=
> 0' failed.
> Testing rate: 44100   Aborted
>

> Alsa-info is at:
>
> http://www.alsa-project.org/db/?f=19dfeee29f73007e61a00a8fabe3c958f7cb8e87
>
> This apparently happens with or without Pulseaudio running, with just the
> single 44100 rate, and also with surround devices.  Also, on all current
> Debian and Ubuntu - we have focused on Jessie.
>
> I do not have a machine with similar hardware, so cannot duplicate the
> results.
>

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda/hda_intel.c?id=2ae66c26550cd94b0e2606a9275eb0ab7070ad0e

seem assert only occur when hda controller support arbitrary period size
(align_buffer_size=0) and softvol plugin ,

your program return invalid argument -22 without softvol plugin
