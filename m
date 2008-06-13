From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: What does snd_pcm_delay() actually return?
Date: Fri, 13 Jun 2008 15:06:09 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0806131453280.1798@tm8103-a.perex-int.cz>
References: <20080609190225.GA4534@tango.0pointer.de>
	<s5h1w333o7r.wl%tiwai@suse.de>
	<20080612205225.GB20818@tango.0pointer.de>
	<s5hd4mlhlau.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0806130958000.1798@tm8103-a.perex-int.cz>
	<48524882.6050606@superbug.co.uk> <g2tq3q$969$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id CC2D624499
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jun 2008 15:06:11 +0200 (CEST)
In-Reply-To: <g2tq3q$969$1@ger.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Colin Guthrie <gmane@colin.guthr.ie>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 13 Jun 2008, Colin Guthrie wrote:

> James Courtier-Dutton wrote:
> > Jaroslav Kysela wrote:
> >> On Fri, 13 Jun 2008, Takashi Iwai wrote:
> >>
> >>   
> >>> - Add some new API functions,
> >>>     
> >> I would prefer to extend the current API than to change meaning of hw_ptr 
> >> to handle extra latencies.
> >>
> >>   
> > I would prefer the definition of snd_pcm_delay() to be:
> > Before the next sample is written to the buffer, snd_pcm_delay() returns 
> > the expect time delay, in frames, indicating the time the next sample 
> > will reach the speakers.
> > This is what snd_pcm_delay() was introduced into the ALSA api for. I 
> > remember, because it was added as a result of me requesting it.
> > 
> > 
> > Then implement a totally different api call to help with under run timings.
> 
> Big +1
> 
> You also have to think of the use cases currently out there.
> 
> * World + Dog uses it as James (and Lennart) states.
> * Wine uses it sans latency.

The comment for snd_pcm_delay() in alsa-lib is clear and it's what James 
wrote. If only one app interprets this wrongly, then I agree it would be 
better not to change original meaning.

Then we have snd_pcm_avail_update(). Although it is stated in comment that 
this function is useless for non-mmap mode, it's quite clear that returns 
number of available frames to be handled (r/w) by application.

The easiest method would be just to remove "useless for non-mmap" from 
comments for snd_pcm_avail_update() and suggest to application developers:

1) overall latency is returned by snd_pcm_delay()
2) ring buffer filling is controlled by snd_pcm_avail_update(), for 
   non-mmap access is usage of this function optional

As mentioned, it will need to fix some drivers mixing software output FIFO 
with ring buffer (USB, PCMCIA)..

Opinions?

					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
