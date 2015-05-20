From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Assert in pcm_params.c
Date: Wed, 20 May 2015 10:21:14 +0800
Message-ID: <CAN8cciaFFBp-wp08e5sRjqdsc3vPybU6Exr0SbkW3fi7uGmkzw@mail.gmail.com>
References: <201504180908.47022.gineera@aspect135.co.uk>
 <201505010836.47714.gineera@aspect135.co.uk>
 <s5hbnhgzsh4.wl-tiwai@suse.de>
 <201505192022.50591.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f45.google.com (mail-oi0-f45.google.com
 [209.85.218.45])
 by alsa0.perex.cz (Postfix) with ESMTP id CEB6F26043E
 for <alsa-devel@alsa-project.org>; Wed, 20 May 2015 04:21:15 +0200 (CEST)
Received: by oihb9 with SMTP id b9so25600069oih.3
 for <alsa-devel@alsa-project.org>; Tue, 19 May 2015 19:21:15 -0700 (PDT)
In-Reply-To: <201505192022.50591.gineera@aspect135.co.uk>
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

> > > A minimal self-contained demo program ('test-format') has been
developed
> > > and is attached, that demonstrates the issue 100% on the reporters
> > > machine (HDA-Intel, 6-ch I believe).  The output is:
> > >
> > > root@Xeon:/home/patest# ./test-format
> > > Testing device front
> > > Num channels 6
> > > Testing rate: 22050   Result:...Invalid Sample Rate
> > > Testing rate: 32000   Result:...Invalid Sample Rate
> > > test-format: pcm_params.c:2249: snd1_pcm_hw_params_slave: Assertion
`err
> > > >= 0' failed.
> > > Testing rate: 44100   Aborted
> > >
> > > Alsa-info is at:
> > >
> > >
http://www.alsa-project.org/db/?f=19dfeee29f73007e61a00a8fabe3c958f7cb8e8
> > >7
> > >

00:1b.0 0403: 8086:269a (rev 09)
Subsystem: 8086:0419

{ PCI_DEVICE(0x8086, 0x269a),
  .driver_data = AZX_DRIVER_ICH | AZX_DCAPS_INTEL_ICH },

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda?id=103884a351a221553095c509a1dbbbf7d4fd9b05

#define AZX_DCAPS_INTEL_ICH \
(AZX_DCAPS_OLD_SSYNC | AZX_DCAPS_NO_ALIGN_BUFSIZE)

Only AZX_DCAPS_INTEL_ICH use AZX_DCAPS_NO_ALIGN_BUFSIZE

> > > This apparently happens with or without Pulseaudio running, with just
the
> > > single 44100 rate, and also with surround devices.  Also, on all
current
> > > Debian and Ubuntu - we have focused on Jessie.
> > >
> > > I do not have a machine with similar hardware, so cannot duplicate the
> > > results.
> > >
> > > Any comments, ideas etc would be appreciated.
> >
> > I also can't reproduce this.  So this must be pretty specific to the
> > setup.
> >
> > Could you give the exact condition to trigger the problem?  Also, this
> > happens certainly with the latest alsa-lib?
>
> Thanks for taking a look.  Just compiling and running that test program,
on
> the reporter's machine, which has some sort of multi-channel HDA-Intel, is
> 100% reproducible. The Alsa-lib must be the one provided by Debian Jessie
> (which was released 25.4.2015); 1.0.28 I think.  Does the Alsa-info give
> enough details - I can ask any specific questions.
>

snd_hda_prealloc_size may affect the result

when your program let alsa lib to determine those buffer size, period and
period size , snd_pcm_hw_params return error on 6 channels for some hda
controllers

Your program  return error when using "hw" instead of  assert  when using
"front" with 6 channels
