From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: channel interleaving in driver es1968
Date: Sat, 26 Jul 2003 20:16:05 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0307262014460.29791-100000@pnote.perex-int.cz>
References: <Pine.OSF.4.56.0307261928430.4835@hehi03.nbi.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.OSF.4.56.0307261928430.4835@hehi03.nbi.dk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Djamel Ouerdane <ouerdane@nbi.dk>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 26 Jul 2003, Djamel Ouerdane wrote:

> Hi,
> 
> I noticed that the jack server was not happy that my pcm had different
> channel interleaving setup for capture and playback, so I could not use
> jack (it was complaining that capture was SNDRV_PCM_INFO_NONINTERLEAVED
> and playback SNDRV_PCM_INFO_INTERLEAVED).
> 
> After a note from Paul Davis who redirected me to the alsa driver
> (es1968), I figured that changing the capture HW info in
> alsa-kernel/pci/es1968.c (from NONINTERLEAVED to INTERLEAVED) solved the
> problem. The sound is now very clean with or without using jack. The thing
> is: I'm not an expert at all and I have no clue if this is an ok fix, I
> only have my ears to tell me that now, things sound ok :) (I don't know if
> other people had the same problem with this driver and jack)

And capture (input) really works right? In stereo? I don't believe. It's 
better to use the plughw layer which will convert the samples on the fly.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
