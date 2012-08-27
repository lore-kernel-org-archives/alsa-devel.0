From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [pulseaudio-discuss] Documentation for how
	rewinding works
Date: Mon, 27 Aug 2012 09:41:18 +0800
Message-ID: <CAN8ccibMVLUjmfRpBcBGGQK1P4C4aWiYQ8GoDGLfGS6Nk9wmGg@mail.gmail.com>
References: <1345374419.4864.64.camel@laptop>
 <CAN8cciY=T4vXbwW-Hsz7dDkrCoLgMyvHKStnzhzf_XBSss50fg@mail.gmail.com>
 <1345612571.16615.20.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com
 [209.85.216.179])
 by alsa0.perex.cz (Postfix) with ESMTP id E7CC5265E16
 for <alsa-devel@alsa-project.org>; Mon, 27 Aug 2012 03:41:19 +0200 (CEST)
Received: by qcse14 with SMTP id e14so2158306qcs.38
 for <alsa-devel@alsa-project.org>; Sun, 26 Aug 2012 18:41:19 -0700 (PDT)
In-Reply-To: <1345612571.16615.20.camel@laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tanu Kaskinen <tanuk@iki.fi>, clemens@ladisch.de
Cc: alsa-devel@alsa-project.org, General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org

> > >
> > it seem that the alsa sink is more complicated than your figure.
>
> The fact that there's a region in the beginning of the sink buffer that
> shouldn't be rewound is an implementation detail of alsa sink, and does
> not need to be taken into account in the general rewind handling. The
> alsa sink is able to take care of it internally.
>
> > Refer to figure 14 HD Audio DMA and buffering , section 4.6 Energy
> > Efficient HA audio mechanism
> >
> > most sound cards have fixed size FIFO buffer instead of dynamic FIFO and
> > minimum transfer size(brust) similar to hda controller which
snd_pcm_rewind
> > cannot rewind any audio data in those first in first out buffer.
> >
> >
http://cgit.freedesktop.org/pulseaudio/pulseaudio/commit/src/modules/alsa?id=4df443bbe682055a41e7c2248877dcc7682a69b8
>
> Thanks for bringing that commit into attention, because it seems to
> introduce a new bug (although judging from the commit message, Pierre
> was aware of it and considered it a feature): the code doesn't take
> tsched_watermark into account anymore when doing rewinds. The point of
> tsched_watermark is to ensure that pulseaudio has enough time to fill
> the sink buffer. If it's ignored when rewinding, it's likely that there
> will be an underrun when refilling the sink buffer, if tsched_watermark
> is greater than rewind_safeguard.

how about those sound cards which minimum latency is much higher than that
of pulse plugin

http://thread.gmane.org/gmane.linux.alsa.devel/89157/focus=89167

snd-ymfpci update the hwptr at 5.33 ms interval while pulse plugin claim to
support as low as 1ms

does the driver need to add another constraints which restrict the period
bytes to be multiple of 1024 at 48000Hz in addition to forcing the driver
to run at 48000Hz since hwptr only change at period boundary ?

with minimum period of 3 , the minimum buffer time of snd-ymfpci is 16ms

can pa server reject the pulse client when it request latency lower than
16ms (minimum period * minimum period time of the sound driver)?

>
> > 1) do the server really need to rewind when there is only one pulse
client ?
>
> Yes. The sink buffer may have up to 2 seconds of audio from the one
> pulse client, and if you then change the software volume of the sink (or
> sink input, doesn't matter), you will have to rewrite the sink buffer
> contents unless you want to wait 2 seconds until the volume change
> becomes audible.

when module-suspend-on-idle is loaded pa server close the sink after 5
seconds of no activity for power saving  and reopen the sink when another
appllication connect to play audio,  does it mean that rewind is not
necessary in this situation ?
