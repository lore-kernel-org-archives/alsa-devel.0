From: Anders Torger <torger@ludd.luth.se>
Subject: Re: Starting playback/capture exactly the same time (was: Repeatable exact I/O-delay)
Date: Sun, 28 Jul 2002 16:26:49 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020728142645.D328C902@mail.it4u.net>
References: <Pine.LNX.4.21.0207281418001.661-100000@summer.quitte>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.it4u.net (mail.it4u.net [81.8.150.196])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id QAA29608
	for <alsa-devel@alsa-project.org>; Sun, 28 Jul 2002 16:27:20 +0200
In-Reply-To: <Pine.LNX.4.21.0207281418001.661-100000@summer.quitte>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Tim Goetze <tim@quitte.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sunday 28 July 2002 14.40, you wrote:
> Anders Torger wrote:
> >On Saturday 27 July 2002 17.18, you wrote:
> >> Anders Torger wrote:
> >> >Does anyone have any comments on this? Is repeatable exact
> >> > I/O-delay possible to achieve today with current hardware (and
> >> > ALSA)?
> >>
> >> It is the normal mode of operation for memory-mapped IO.
> >
> >Is it really? How do I trigger play exactly X samples after I
> > trigger capture? To copy samples exactly X samples into a buffer is
> > simple, the problem is to tell the sound card to synchronise the
> > playback ptr with the capture ptr, that is "start running the
> > playback ptr exactly X samples after the capture ptr started". The
> > window of X samples is then used by the software to do its magic.
>
> The way you'd do this is to link the capture and playback streams of
> the device you use with snd_pcm_link(). They will start together and
> stay in sync (unless the hardware is broken by design). Instead of
> starting playback exactly 4096 frames later, you prime the playback
> stream with 4096 silent frames before starting it. At the first
> interrupt issued, there will be 2048 frames to be read from the
> capture stream and 2048 to write to playback. You'd read the input
> signal, write another 2048 silent frames, and from the next interrupt
> on you'll always have 2048 frames of processed signal to write, and
> 2048 input frames to feed to the FIR.

Thanks. I'll try this. Not only the hardware can be broken, but also 
the driver I suppose. It seems like not all have support for 
snd_pcm_link(), for example my driver for RME96 (I have to do some 
maintenance work on that soon).

> Implementing memory-mapped IO isn't exactly what you do in a day.
> jackit.sf.net or the shortly-to-be-released library I'm working on
> will do it for you. Just replace 'interrupt' above with a 'process'
> callback and you don't have to care about the exact workings of
> mmap'd ALSA at all.

This is great, but I don't see why this particular thing would require 
memory-mapped I/O. If one makes sure to write 4096 silent frames first 
start playback/capture using snd_pcm_link(), it should work with 
snd_pcm_read/write too, shouldn't it?

/Anders Torger


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
