From: Mark Knecht <markknecht@gmail.com>
Subject: Re: Maintaining sound card at a specific frequency
Date: Tue, 18 Jan 2005 09:45:41 -0800
Message-ID: <5bdc1c8b05011809454b58899c@mail.gmail.com>
References: <1105938846.41eb499ec3527@www3.webhosting.cx>
	 <XFMail.20050118165036.pochini@shiny.it>
	 <s5hacr6wun5.wl@alsa2.suse.de>
	 <Pine.LNX.4.58.0501181822220.29107@denise.shiny.it>
Reply-To: Mark Knecht <markknecht@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0501181822220.29107@denise.shiny.it>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giuliano Pochini <pochini@denise.shiny.it>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 18 Jan 2005 18:31:28 +0100 (CET), Giuliano Pochini
<pochini@denise.shiny.it> wrote:
> 
> 
> On Tue, 18 Jan 2005, Takashi Iwai wrote:
> 
> > > IMHO we should think on a good solution for this problem. Some
> > > cards have many channels/voices but the sample rate is common
> > > for all of them. Currently the only clean way to manage it is
> > > a control that locks the sample rate at a given frequency, but
> > > it isn't a nice solution because it requires explicit user
> > > intervention. In the echoaudio driver I implemented a kludge
> > > that automatically locks the sample frequency in order to avoid
> > > unwanted rate changes.
> >
> > You can add a control to lock the sample rate (e.g. ICE1712).
> 
> Yep, I know, but it's not part of the pcm API: applications do not
> lock the sample rate themselves. The user has to do it manually. This is
> why I choosed an alternate solution. If apps were able to lock the rate it
> would be very useful. It may need some help from the driver, though.
> 
But that sort of application level control is actually what's causing
me problems. Mozilla browses around and changes the frequency of the
card, independent of what the overall system architecture requires.

Again, I think you're probably right about this issue for a completely
stand-alone system, but for a multi-PC system I think some sort of
plughw solution that resamples in software when necessary would work
better for me and Mozilla.

thanks,
Mark


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
