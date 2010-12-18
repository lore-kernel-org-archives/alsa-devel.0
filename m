From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: periods*period_size vs. buffer_size;
	should they be equal?
Date: Sat, 18 Dec 2010 11:12:09 +0800
Message-ID: <AANLkTi=+CyFF3FovfckPmUmoTQdQfzjemF7ppzEMchSy@mail.gmail.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF030FD787C0@HQMAIL01.nvidia.com>
	<AANLkTim-5ynM+Z=0PfGPpyN3rOhxb+e6SHkphWZ7=V6T@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f42.google.com (mail-bw0-f42.google.com
	[209.85.214.42])
	by alsa0.perex.cz (Postfix) with ESMTP id 1AF0610391A
	for <alsa-devel@alsa-project.org>; Sat, 18 Dec 2010 04:12:10 +0100 (CET)
Received: by bwz13 with SMTP id 13so1747941bwz.29
	for <alsa-devel@alsa-project.org>; Fri, 17 Dec 2010 19:12:09 -0800 (PST)
In-Reply-To: <AANLkTim-5ynM+Z=0PfGPpyN3rOhxb+e6SHkphWZ7=V6T@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/12/18 Jassi Brar <jassisinghbrar@gmail.com>

> On Sat, Dec 18, 2010 at 5:04 AM, Stephen Warren <swarren@nvidia.com>
> wrote:
> > I'm attempting to understand the layout of the DMA buffer used by ASoC
> > devices. It seems like the buffer should consist of runtime->periods
> entries
> > each of runtime->period_size frames of audio data. Hence,
> runtime->buffer_size
> > should be equal to runtime->periods * runtime->period_size in frames.
> >
> > This assumption holds true in many cases. However, it doesn't in others:
> >
> > (sizes in hex)
> >
> > Playing WAVE '8000.wav' : Signed 16 bit Little Endian, Rate 8000 Hz,
> Stereo
> > [  217.910867] Trigger: runtime->periods=4
> > [  217.914696] Trigger: runtime->period_size=3e8
> > [  217.919043] Trigger: runtime->buffer_size=fa0
> > [  217.923389] Trigger: f2b(4)=10
> >
> > Playing WAVE '11025.wav' : Signed 16 bit Little Endian, Rate 11025 Hz,
> Stereo
> > [  268.543821] Trigger: runtime->periods=5
> > [  268.547651] Trigger: runtime->period_size=400
> > [  268.551998] Trigger: runtime->buffer_size=1589
> >
> > Playing WAVE '16000.wav' : Signed 16 bit Little Endian, Rate 16000 Hz,
> Stereo
> > [  315.889280] Trigger: runtime->periods=7
> > [  315.893109] Trigger: runtime->period_size=400
> > [  315.897456] Trigger: runtime->buffer_size=1f40
> >
> > Yet for any higher sample rate the layout is identical:
> >
> > Playing WAVE '96000.wav' : Signed 16 bit Little Endian, Rate 96000 Hz,
> Stereo
> > [  385.494764] Trigger: runtime->periods=8
> > [  385.498594] Trigger: runtime->period_size=400
> > [  385.502941] Trigger: runtime->buffer_size=2000
> >
> > Is my assumption wrong? Is there some bug somewhere?
>
> You assumption doesn't seem to be accurate.
> Theoretically, your buffer_size may not be a multiple of period_size. But
> that
> would mean points shifting on the ring buffer at which interrupts are
> generated.
>
> Usually embedded systems don't have dedicated ring buffer DMA for use
> with ASoC... and it is cumbersome to reprogram the next interrupt point if
> buffer_size is not a multiple of period_size. So, we usually call
> snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);
> in the stream open callback, which ensures constrainst buffer_size to
> be a multiple of period_size.
>
>
How about the DMA page size in PCI/PCIe ?

It seem that some PCI card (e.g. au88x0) does not allow a period split
across two DMA page and require period size must be power of two.

Is this a requirement of using scatther gather buffer or hardware limitation
of au88x0 ?
