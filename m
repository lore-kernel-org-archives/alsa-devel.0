From: Adam K Kirchhoff <adamk@voicenet.com>
Subject: Re: ymfpci : four speakers with OSS-emulation
Date: Wed, 13 Mar 2002 10:13:01 -0500 (EST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.10.10203131003400.11259-100000@sorrow.ashke.com>
References: <s5h4rjkjyzs.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <s5h4rjkjyzs.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: xavier.allamigeon@free.fr, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


On Wed, 13 Mar 2002, Takashi Iwai wrote:

> At Wed, 13 Mar 2002 09:29:58 -0500 (EST),
> Adam K Kirchhoff wrote:
> > 
> > 
> > On Wed, 13 Mar 2002, Takashi Iwai wrote:
> > 
> > > At Wed, 13 Mar 2002 08:01:02 -0500 (EST),
> > > Adam K Kirchhoff wrote:
> > > > 
> > > > The solution the Jaroslav gave in that e-mail actually requires changes to
> > > > the ymfpci driver, as I understand it.  Last time I pulled code from CVS,
> > > > this hadn't been done yet.  From the sound of it (based on your
> > > > experience) it looks like it still hasn't been done.  At the moment, I
> > > > don't really understand Alsa (or sound drivers in general) well enough to
> > > > make the change myself, nor do I really have the time to pick up that
> > > > knowledge at the moment.
> > > > 
> > > > However, it's also my impression from Jaroslav's explanation that this
> > > > would simply duplicate the output from the fron channel on the rear
> > > > channel. Can someone let me know if this is correct?
> > > 
> > > if you only need duplication, this can be done on alsa-lib without
> > > changing the driver itself.
> > 
> > <snip>
> > 
> > What would be required if you're looking for more than duplication?
> 
> dunno.  depending on what you want ;)
> for example, if you need dynamic volume/pan controls for each channel,
> then alsa-lib cannot do it.  its routing function is static only.

Well, this is largely what comes to mind (speaking as one who has a
limited understanding of sound drivers)...

When playing mp3s with a SB Live (using the Alsa drivers) I'm quite
certain that each channel, and each speaker on the channel, is outputting
sound quite independent of the other speakers/channels.  In other words,
the left and right front speakers, and the left and right rear speakers
are independent of each other.  This also works when playing games such as
UnrealTournament.  You can tell whether someone is coming up behind you
from the left or the right.  Make sense so far?

Now, this also works with the ymfpci OSS drivers (the commercial ones,
anyway) as well as the BeOS drivers for the card, so it doesn't seem to be
a limitation of the hardware (though please correct me if I'm wrong).

Now, I'm going to assume here that the ymfpci driver would need some
significant work to be able to do this, correct?

Adam



_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
