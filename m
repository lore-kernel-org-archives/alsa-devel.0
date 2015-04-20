From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Assert in pcm_params.c
Date: Mon, 20 Apr 2015 15:08:55 +0800
Message-ID: <CAN8cciaDr+0sdLPjOD1evTHjA6mSDMasM_ZgDpCanWE1Dbbd6w@mail.gmail.com>
References: <201504180908.47022.gineera@aspect135.co.uk>
 <CAN8cciYukOJMwfcmnss+QdTCuNN4=4pi11aOSCHNjyaKO-Komw@mail.gmail.com>
 <201504181207.26711.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f170.google.com (mail-ob0-f170.google.com
 [209.85.214.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 3EEEC2604FC
 for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2015 09:08:59 +0200 (CEST)
Received: by oblw8 with SMTP id w8so112512257obl.0
 for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2015 00:08:57 -0700 (PDT)
In-Reply-To: <201504181207.26711.gineera@aspect135.co.uk>
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

> > > Hi,
> > >
> > > The following assert is being hit in pcm_params.c:
> > >
> > > "pcm_params.c:2249: snd1_pcm_hw_params_slave: Assertion `err >= 0'>
> > > failed."
> >
> > > This is from a developer using Portaudio in his own application; I
have
> > > yet to ascertain full details, but it is trying successive sample
rates to
> > > see which are valid.
> > >
> > > Does this point to a flaw in the configuration or possibly a bug in
> > > Alsa-lib or can it occur just as a result of misuse of the Alsa API?

> >
> >
http://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m___h_w___params.
> >html
> >
> > Only snd_pcm_hw_params_test_rate() can be call multiple times,
> > Verify if a rate is available inside a configuration space for a PCM.
> >
> > Those snd_pcm_hw_params_ser_rate*  functions restrict the configuration
> > space to one rate and can be called once only
>
> The stream is being opened and closed at each attempt.

Seem Delta 44 does not support 2,4,6 or 8 channels

aplay --dump-hw-params -Dhw:CARD=M44 any.wav

Do both channel min and channel max > 8 ?

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/sound/pci/ice1712/delta.c

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/sound/pci/ice1712/ice1712.c

rates = SNDRV_PCM_RATE_CONTINUOUS | SNDRV_PCM_RATE_8000_48000,
.rate_min = 4000,
.rate_max = 48000,

If the driver really support any rate between 4000Hz and 48000Hz, the list
of supported rates has 48000-4000+1 entries
