From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Dummy module and sample rates
Date: Sat, 10 Oct 2015 15:59:34 +0800
Message-ID: <CAN8ccia=mU9qT8+puAbprAguF-4W4_6FP8z+P7s9_jbcU1AL6w@mail.gmail.com>
References: <56029069.60700@weiss.ch> <56039FF3.3030203@ladisch.de>
 <5603D532.9080201@weiss.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f52.google.com (mail-oi0-f52.google.com
 [209.85.218.52])
 by alsa0.perex.cz (Postfix) with ESMTP id A786426517C
 for <alsa-devel@alsa-project.org>; Sat, 10 Oct 2015 09:59:35 +0200 (CEST)
Received: by oiar126 with SMTP id r126so15703510oia.0
 for <alsa-devel@alsa-project.org>; Sat, 10 Oct 2015 00:59:34 -0700 (PDT)
In-Reply-To: <5603D532.9080201@weiss.ch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Uli Franke <uli.franke@weiss.ch>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>
> >> I fiddled around with the Dummy module and it seems to be the thing
> >> we're looking for. I observed a rather strange behavior though:
> >>
> >> I set the hw params sample rate to 44k1 without error, but a subsequent
> >> call of snd_pcm_start returns EPIPE. When setting hw params sample rate
> >> to 4k this does not happen.
> >
> > In theory, this error code is returned if you didn't write any samples
> > into the buffer before starting.
> >
> > An underrun is possible too, but should be reported later AFAIK.
> > Could you check if a larger buffer size helps?
>
> I checked if this is actually an XRun, as this is the official error
> code. But even recover didn't have any effect.
>
> When I write samples before starting the stream, snd_pcm_start returns
>
>    File descriptor in bad state (-77)
>
> which is obvious as the state of the stream changes from PREPARED to
> RUNNING.
>
> I tried to increase the buffer but with no effect.
>
> No error occurs when I just write samples and omit the snd_pcm_start. I
> just read some examples and got the impression that this seems to be
> common practice anyhow. But up to now all my ALSA interfacing programs
> actively started the stream and I never had any similar effect.
>
> You can find a small test program here:
>
> http://460c9235de50fe3b.paste.se/

Your program did not setup sw_params but start pcm stream by
snd_pcm_start() without snd_pcm_write() any data
