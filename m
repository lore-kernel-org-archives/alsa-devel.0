From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: underun problems
Date: Thu, 30 Mar 2006 16:37:25 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0603301633250.11712@tm8103.perex-int.cz>
References: <442A54E9.5050303@tiger.com.pl> <s5hfyl0qa74.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hfyl0qa74.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Maciek Kaminski <maciejka@tiger.com.pl>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 30 Mar 2006, Takashi Iwai wrote:

> At Wed, 29 Mar 2006 11:35:37 +0200,
> Maciek Kaminski wrote:
> > 
> > I get voice data over network, at the moment I can't implement jitter 
> > buffer so I have to play exactly what I get. The problem is how to 
> > manage underuns that happen when data arrives late. I tried to use 
> > silence threshold but that does not seem to help. Question is: what to 
> > do  to make silence substitution work? I was suggested to set the 
> > silence size to boundary value that also does not seem to work...
> > Are the any other strategies to silence underruns?
> 
> The silence_* stuff has basically nothing to do with underrun
> conditions.  They are for automatic silencing the data area that have
> been played.
> 
> The underrun condition is set up via stop_threshold parameter.
> Setting it to boundary means that the sound keeps running even if
> underrun occurs.  It's what dmix is doing.
> 
> This free-run mode is, though, a bit tricky.  Since it never reports
> XRUN, you have to check and compare hwptr and applptr, reset reset the
> applptr appropriately by yourself.

It's not required - you can continue work as no XRUN occured, but there is 
bigger chance to get clicks for playback because you will write old data 
to some areas. It's better to "snd_pcm_forward()" appl_ptr to the actual
hw_ptr and then feed samples from this position.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
