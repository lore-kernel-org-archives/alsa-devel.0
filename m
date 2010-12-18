From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Handling non-buffer-sized MMAP requests
Date: Sat, 18 Dec 2010 08:32:47 +0800
Message-ID: <AANLkTi=nd76edFVHB9G-C7+CBYsqk4MKACxtyiJSLGzB@mail.gmail.com>
References: <6e2495d80bd7915f371b984cc4b4a503.squirrel@master.museresearch.com>
	<4D05DFB9.3080407@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f42.google.com (mail-bw0-f42.google.com
	[209.85.214.42])
	by alsa0.perex.cz (Postfix) with ESMTP id CCFBB10391A
	for <alsa-devel@alsa-project.org>; Sat, 18 Dec 2010 01:32:50 +0100 (CET)
Received: by bwz13 with SMTP id 13so1678040bwz.29
	for <alsa-devel@alsa-project.org>; Fri, 17 Dec 2010 16:32:50 -0800 (PST)
In-Reply-To: <4D05DFB9.3080407@ladisch.de>
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

2010/12/13 Clemens Ladisch <clemens@ladisch.de>

> louis@museresearch.com wrote:
> > Hi everyone, I'm having some difficulty improving a full-duplex MMAP ALSA
> > routine.  ALSA sometimes reports more samples available for input than my
> > buffer can take, or asks for more samples than I have available.  Is this
> > a buffer overrun/underrun?
>
> Yes.  (And this should happen only when you've disabled stopping on
> an xrun, so you've asked for it.  :-)
>
> > If I restart the streams in the case that too
> > much input is available (on the assumption that it's an xrun) it seems to
> > happen at the drop of a hat and makes things worse.  If I discard the
> > excess input, that doesn't work well either.
> >
> > What is the appropriate way to deal with this situation?
>
> The best way would be to prevent this situation from happening, i.e.,
> read the captured data from the buffer before it overflows.
>
> (In the case of capturing, latency does _not_ depend on the buffer size,
> so you should make the buffer as big as possible.)
>
>
Refer to http://thread.gmane.org/gmane.linux.alsa.devel/66826/focus=66954

you mention that snd_pcm_forward can be used to recover from an underrun
condition for playback

In underrun/overrun of playback/capture , the hardware pointer is ahead of
the application pointer

Can snd_pcm_forward be used to recover from overrun in  capture when
automatic stop is disabled ?

Why does  Pulseaudio server request rewind at  the end of underrun ?

D: protocol-native.c: Requesting rewind due to *end of underrun*
