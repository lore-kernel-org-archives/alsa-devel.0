From: Mark Knecht <markknecht@gmail.com>
Subject: Re: Maintaining sound card at a specific frequency
Date: Tue, 18 Jan 2005 09:43:12 -0800
Message-ID: <5bdc1c8b050118094326c48e6b@mail.gmail.com>
References: <1105938846.41eb499ec3527@www3.webhosting.cx>
	 <XFMail.20050118165036.pochini@shiny.it>
	 <s5hacr6wun5.wl@alsa2.suse.de>
	 <5bdc1c8b05011809013ebf438e@mail.gmail.com>
	 <s5h651uwtp9.wl@alsa2.suse.de>
	 <5bdc1c8b050118091257553af5@mail.gmail.com>
	 <s5h4qhewtdu.wl@alsa2.suse.de>
Reply-To: Mark Knecht <markknecht@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h4qhewtdu.wl@alsa2.suse.de>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 18 Jan 2005 18:15:41 +0100, Takashi Iwai <tiwai@suse.de> wrote:
> At Tue, 18 Jan 2005 09:12:44 -0800,
> Mark Knecht wrote:
> >
> > On Tue, 18 Jan 2005 18:08:50 +0100, Takashi Iwai <tiwai@suse.de> wrote:
> > > At Tue, 18 Jan 2005 09:01:21 -0800,
> > > Mark Knecht wrote:
> > > >
> > > > On Tue, 18 Jan 2005 17:48:30 +0100, Takashi Iwai <tiwai@suse.de> wrote:
> > > > > At Tue, 18 Jan 2005 16:50:36 +0100 (CET),
> > > > > Giuliano Pochini wrote:
> > > > > >
> > > > > >
> > > > > > On 17-Jan-2005 Patrick Shirkey wrote:
> > > > > >
> > > > > > >> I guess I'm wondering if there isn't some .asoundrc magic that could
> > > > > > >> be done in my Linux account on this machine that would tell all
> > > > > > >> applications (other than Jack for now) to use some virtual device that
> > > > > > >> handles all frequencies. If that virtual device was the default and
> > > > > > >> the resampling (for Mozilla/games/whatever) was done in software and
> > > > > > >> the sound cards frequency was never changed then I think things would
> > > > > > >> work much better.
> > > > > > >>
> > > > > > >
> > > > > > > I think you can use default as the device name in .asoundrc and it
> > > > > > > will be used as the default device for all apps.
> > > > > >
> > > > > > IMHO we should think on a good solution for this problem. Some
> > > > > > cards have many channels/voices but the sample rate is common
> > > > > > for all of them. Currently the only clean way to manage it is
> > > > > > a control that locks the sample rate at a given frequency, but
> > > > > > it isn't a nice solution because it requires explicit user
> > > > > > intervention. In the echoaudio driver I implemented a kludge
> > > > > > that automatically locks the sample frequency in order to avoid
> > > > > > unwanted rate changes.
> > > > >
> > > > > You can add a control to lock the sample rate (e.g. ICE1712).
> > > > >
> > > > >
> > > > > Takashi
> > > > >
> > > >
> > > > That could be a good solution if it would also set the initial
> > > > frequency of the card.
> > >
> > > The system clock of HDSP can be set via control API.  So, it works
> > > like:
> > >         amixer cset iface=PCM,name="Sample Clock Source" "Internal 48.0 kHz"
> > >
> > > If this works like you want, only the locking is missing...
> > >
> >
> > Unfortunately it set it to Autosync, not 48K. I tried 44.1K also but
> > it jsut stays at Autosync. Here's what I see in the terminal:
> 
> Ah, my mistake.  Try
>         amixer cset iface=PCM,name="Sample Clock Source" 3
> 

Yes, that works fine, so I'll add that to rc.local or someplace like that.

I suppose that there must be some way to do this with the hdspmixer
settings? Currently I have to run hdspmixer once to get the card
turned on at all. Can I somehow capture the current settings into a
file and then execute a bunch of commands to get things set up
slightly after boot?

thanks,
Mark


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
