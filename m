From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: sequencer queue PCM timing
Date: Thu, 13 May 2004 20:12:11 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0405132009120.1834@pnote.perex-int.cz>
References: <200405131416.54774.cannam@all-day-breakfast.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200405131416.54774.cannam@all-day-breakfast.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Chris Cannam <cannam@all-day-breakfast.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 13 May 2004, Chris Cannam wrote:

> I asked about this on the JACK list just now and was recommended to 
> bring the question here instead.  So here we are.
> 
> If I'm running JACK with output to my first (and only) PCM device, and 
> I have a JACK client running that also sets up an ALSA sequencer 
> queue with its timer set to the ALSA PCM 0-0-0 playback timer,  
> should I expect the ALSA queue's current time and the number of 
> frames processed by the JACK client to correspond?
> 
> (Ignoring rounding error and any delays in startup time or 
> measurement: I simply mean that they shouldn't drift.)
> 
> I would expect them to remain in sync, and on both of my machines here 
> they do, but I have a report from someone experiencing a quite 
> considerable drift -- the JACK frame count ends up over a second and 
> a half ahead of the ALSA timer over a ten minute period without 
> xruns.  How could that happen?

Maybe, lost interrupts can cause this. Actually, there is no correction 
in the PCM slave timer code for this situation. Can this problem be 
reproduced using a bigger period size for the JACK daemon?

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
