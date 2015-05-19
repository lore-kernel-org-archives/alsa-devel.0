From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Assert in pcm_params.c
Date: Tue, 19 May 2015 21:02:50 +0800
Message-ID: <CAN8cciYKVdDJ0n_xstewP_kohnZoLsmQhCcg8kjRbo5iJQ_gEQ@mail.gmail.com>
References: <201504180908.47022.gineera@aspect135.co.uk>
 <201504201217.36477.gineera@aspect135.co.uk>
 <201505010836.47714.gineera@aspect135.co.uk>
 <s5hbnhgzsh4.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f173.google.com (mail-ob0-f173.google.com
 [209.85.214.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 950442651A3
 for <alsa-devel@alsa-project.org>; Tue, 19 May 2015 15:02:51 +0200 (CEST)
Received: by obblk2 with SMTP id lk2so11385276obb.0
 for <alsa-devel@alsa-project.org>; Tue, 19 May 2015 06:02:50 -0700 (PDT)
In-Reply-To: <s5hbnhgzsh4.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> > > > The following assert is being hit in pcm_params.c:
> > > >
> > > > "pcm_params.c:2249: snd1_pcm_hw_params_slave: Assertion `err >= 0'
> > > > failed."
> > > >
> > > > This is from a developer using Portaudio in his own application; I
have
> > > > yet to ascertain full details, but it is trying successive sample
rates
> > > > to see which are valid.
> > >
> > > Further info: this occurs with an Intel motherboard/soundcard,
attempting
> > > to open and config the stream at 44100 using front, surround or hdmi
pcm,
> > > having previously opened and tried at a lower, not-supported
samplerate,
> > > and closed. AFAIK other pcms work OK.
> > >
> > > The assert is hit with all current Debian and Ubuntu distros, for
example
> > >      Debian 8 (jessie) 32 bit:  kernel 3.16.0-4-686-pae (Alsa 1.0.28)
> > > but is not seen with Fedora 20 or OpenSuse 12.1 (do they have asserts
> > > off?).
> > >
> > > > Does this point to a flaw in the configuration or possibly a bug in
> > > > Alsa-lib or can it occur just as a result of misuse of the Alsa API?
> > >
> > > I will try to conceive some more tests.  How can we debug this
further?
> >
> > A minimal self-contained demo program ('test-format') has been
developed and
> > is attached, that demonstrates the issue 100% on the reporters machine
> > (HDA-Intel, 6-ch I believe).  The output is:
> >
> > root@Xeon:/home/patest# ./test-format
> > Testing device front
> > Num channels 6
> > Testing rate: 22050   Result:...Invalid Sample Rate
> > Testing rate: 32000   Result:...Invalid Sample Rate
> > test-format: pcm_params.c:2249: snd1_pcm_hw_params_slave: Assertion
`err >=
> > 0' failed.
> > Testing rate: 44100   Aborted
> >
> > Alsa-info is at:
> >
> >
http://www.alsa-project.org/db/?f=19dfeee29f73007e61a00a8fabe3c958f7cb8e87
> >
> > This apparently happens with or without Pulseaudio running, with just
the
> > single 44100 rate, and also with surround devices.  Also, on all current
> > Debian and Ubuntu - we have focused on Jessie.
> >
> > I do not have a machine with similar hardware, so cannot duplicate the
> > results.
> >
> > Any comments, ideas etc would be appreciated.
>
> I also can't reproduce this.  So this must be pretty specific to the
> setup.
>
> Could you give the exact condition to trigger the problem?  Also, this
> happens certainly with the latest alsa-lib?

It can be reproduced by modify snd-dummy to use azx_pcm_hw

6 channels and softvol similar to hda controller which support arbitrary
period size

snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_BYTES, 4);

snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 4);

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda?id=2ae66c26550cd94b0e2606a9275eb0ab7070ad0e

Slave can return err when call schange

snd_pcm_hw_params_t slave_params;
int err;
err = sprepare(pcm, &slave_params);
assert(err >= 0);
err = schange(pcm, params, &slave_params);
- assert(err >= 0);
+  if (err < 0)
+       return err;
err = sparams(pcm, &slave_params);
if (err < 0)
cchange(pcm, params, &slave_params);
return err;
