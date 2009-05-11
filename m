From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: appl_ptr and DMA overrun at end of stream
Date: Mon, 11 May 2009 15:45:49 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0905111537090.25064@eeebox2.perex-int.cz>
References: <9e4733910905070923i16683486n678653ba56c28b74@mail.gmail.com>
	<s5hfxfcaru3.wl%tiwai@suse.de>
	<9e4733910905110603i3d354ce9lfc74bcbeca6c6bed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1992891013-1242049549=:25064"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id F176F24831
	for <alsa-devel@alsa-project.org>;
	Mon, 11 May 2009 15:45:49 +0200 (CEST)
In-Reply-To: <9e4733910905110603i3d354ce9lfc74bcbeca6c6bed@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel mailing list <alsa-devel@alsa-project.org>, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1992891013-1242049549=:25064
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 11 May 2009, Jon Smirl wrote:

>> Right. =C2=A0This is the value to check in your case.
>
> What do think about redesigning the ALSA DMA interface to support
> detection of over and under run? Leaving the DMA engine in a loop and
> not coordinating with ALSA as to where the valid data is does not seem
> to be a safe way of exchanging data. That interface may be a source of
> the problems pulseaudio is encountering.
>
> A simple solution would be for snd_pcm_period_elapsed() to return
> physical address of the last valid sample. That would let me avoid
> playing with  s->runtime->control->appl_ptr. You could provide the
> same data in the pointer() function.

More simpler solution is to check the stream state in the low level=20
driver. If it's in DRAINING state, then end of stream is signaled from the=
=20
application and driver might not queue next buffer. We may also add=20
another callback (or use ioctl callback) to pass this stream state change=
=20
to the lowlevel driver immediately, so the driver might react more quickly=
=20
on this situation.

All other cases are bad (underruns / overruns) and I'm not sure if we can=
=20
do much. There is silence mode in the midlevel of kernel API to fill some=
=20
samples in the ring buffer ahead with silence so applications can choose=20
if last samples will be played in the underrun case or if silence will be=
=20
played.

 =09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

--8323584-1992891013-1242049549=:25064
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--8323584-1992891013-1242049549=:25064--
