From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: How to lock the sample rate ?
Date: Sat, 6 Mar 2004 11:59:45 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0403061157220.1881@pnote.perex-int.cz>
References: <20040306115426.6b48eaaf.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040306115426.6b48eaaf.pochini@shiny.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giuliano Pochini <pochini@shiny.it>
Cc: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 6 Mar 2004, Giuliano Pochini wrote:

> On the Echoaudio cards the sample rate is a global setting, so I need a way
> to prevent an app to change the rate if someone else already set it (the
> card han several devices/subdevices). I was thinking to put a simple
> "if (IsAudioOpen()) rate_min=rate_max=current_rate;" in pcm_open callback,
> but this solution is racy.

Yes, but I don't see a better solution for "auto" rate settings.
Also, it would be probably good to create a control which can "fix" the 
rate to a value (ICE1712 driver already has this feature).

> Also what am I supposed to do about external clock ? I can't read its
> value and it teoretically can change at any moment.

Yes, I return an error when the rate is other than agreed with 
application in the PDAudioCF driver. I think that it's only valid
solution. But if you cannot obtain the rate from hardware, then
it might be problematic.

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
