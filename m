From: Giuliano Pochini <pochini@denise.shiny.it>
Subject: Re: Maintaining sound card at a specific frequency
Date: Tue, 18 Jan 2005 18:31:28 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0501181822220.29107@denise.shiny.it>
References: <1105938846.41eb499ec3527@www3.webhosting.cx>
 <XFMail.20050118165036.pochini@shiny.it> <s5hacr6wun5.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hacr6wun5.wl@alsa2.suse.de>
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
Cc: Patrick Shirkey <pshirkey@boosthardware.com>, alsa-devel@lists.sourceforge.net, Mark Knecht <markknecht@gmail.com>
List-Id: alsa-devel@alsa-project.org



On Tue, 18 Jan 2005, Takashi Iwai wrote:

> > IMHO we should think on a good solution for this problem. Some
> > cards have many channels/voices but the sample rate is common
> > for all of them. Currently the only clean way to manage it is
> > a control that locks the sample rate at a given frequency, but
> > it isn't a nice solution because it requires explicit user
> > intervention. In the echoaudio driver I implemented a kludge
> > that automatically locks the sample frequency in order to avoid
> > unwanted rate changes.
>
> You can add a control to lock the sample rate (e.g. ICE1712).

Yep, I know, but it's not part of the pcm API: applications do not
lock the sample rate themselves. The user has to do it manually. This is
why I choosed an alternate solution. If apps were able to lock the rate it
would be very useful. It may need some help from the driver, though.


--
Giuliano.


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
