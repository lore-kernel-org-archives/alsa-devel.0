From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: PCM hw mixing with volume
Date: Sun, 7 Mar 2004 17:41:52 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0403071739310.1926@pnote.perex-int.cz>
References: <1078671074.18057.17.camel@renegade>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1078671074.18057.17.camel@renegade>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ove Kaaven <ovek@transgaming.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, 7 Mar 2004, Ove Kaaven wrote:

> We have some games that want to mix several dynamic sound streams.
> That's easy enough at first glance, just snd_pcm_open() for each stream
> they want to output (and do software mixing when that fails). However,
> it seems that they want each stream to have independent volume and pan
> controls.
> 
> As far as I can tell, this is possible to do on SB Live and Audigy by
> messing with the "EMU10K1 PCM Send" volume controls, but this is pretty
> device-specific and few other hw-mixing ALSA drivers seem to have
> exposed such a feature. (And software plugins are not of interest.)
> 
> Are you planning to standardize such features or design a
> device-independent API for it? (And my manager wants to know which ALSA
> release this might get implemented in...)

I'm working on this issue right now, but I cannot estimate the release 
time, because my work is hightly interrupted with the ALSA maintenance
issues.

Hopefully, the API will be functional in a few months.

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
