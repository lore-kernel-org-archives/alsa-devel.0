From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Hoping someone can help me (Assertion `frames <=
 snd_pcm_mmap_avail(pcm)' failed.)
Date: Thu, 11 Mar 2004 12:19:42 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0403111218360.1961@pnote.perex-int.cz>
References: <1078939970.13994.28.camel@Nc> <1079003467.18054.387.camel@renegade>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1079003467.18054.387.camel@renegade>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ove Kaaven <ovek@transgaming.com>
Cc: Niels Christian =?ISO-8859-1?Q?=D8rgaard?= <nc@blahzone.dk>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 11 Mar 2004, Ove Kaaven wrote:

> ons, 10.03.2004 kl. 18.32 skrev Niels Christian ?rgaard:
> > Hey ....
> > 
> > This is the nth day I'm stuck reading the ALSA-documentation over and
> > over again, and I'm at a loss figuring out whats wrong.
> > 
> > Basically, I have a running thread capturing data from an ALSA-device,
> > and within useconds I get: "samptest: pcm.c:5889: snd_pcm_mmap_commit:
> > Assertion `frames <= snd_pcm_mmap_avail(pcm)' failed." (samptest is
> > the name of my executable)
> > 
> > The reason for me being so confused is that this occures at the call
> > "snd_pcm_readi(snd_pcm_t *, void *, snd_pcm_uframes_t )", which for
> > starters ain't mmap :)  I use "snd_pcm_delay(snd_pcm_t *,
> > snd_pcm_sframes_t *)" to verify that there is sufficient data in the
> > queue, before calling readi(),
> 
> Did you remember to call snd_pcm_avail_update() right before calling
> readi()? The docs imply that snd_pcm_delay does not update the value
> returned by the "snd_pcm_mmap_avail" in the assertion, but
> snd_pcm_avail_update() does (by using the latest value from stuff like
> snd_pcm_delay or IRQ handlers, so call it after snd_pcm_delay).

This call is required only for mmap access not for r/w access.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
