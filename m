From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Hoping someone can help me (Assertion `frames <=
 snd_pcm_mmap_avail(pcm)' failed.)
Date: Thu, 11 Mar 2004 12:25:43 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0403111224220.1961@pnote.perex-int.cz>
References: <1078939970.13994.28.camel@Nc>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1078939970.13994.28.camel@Nc>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Niels Christian =?ISO-8859-1?Q?=D8rgaard?= <nc@blahzone.dk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 10 Mar 2004, Niels Christian ?rgaard wrote:

> Hey ....
> 
> This is the nth day I'm stuck reading the ALSA-documentation over and
> over again, and I'm at a loss figuring out whats wrong.
> 
> Basically, I have a running thread capturing data from an ALSA-device,
> and within useconds I get: "samptest: pcm.c:5889: snd_pcm_mmap_commit:
> Assertion `frames <= snd_pcm_mmap_avail(pcm)' failed." (samptest is the
> name of my executable)

Can you run gdb with your code and send me backtrace?

> The reason for me being so confused is that this occures at the call
> "snd_pcm_readi(snd_pcm_t *, void *, snd_pcm_uframes_t )", which for
> starters ain't mmap :)  I use "snd_pcm_delay(snd_pcm_t *,

We use almost always mmap even for r/w access (which is emulated in 
alsa-lib).

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
