From: Adam K Kirchhoff <adamk@voicenet.com>
Subject: Re: YMF754 with front & rear output?
Date: Wed, 20 Feb 2002 10:16:53 -0500 (EST)
Message-ID: <Pine.LNX.4.10.10202201014410.4013-100000@sorrow.ashke.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <Pine.LNX.4.31.0202201608260.487-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


On Wed, 20 Feb 2002, Jaroslav Kysela wrote:

> On Wed, 20 Feb 2002, Adam K Kirchhoff wrote:
> 
> >
> > On Wed, 20 Feb 2002, Takashi Iwai wrote:
> >
> > > At Wed, 20 Feb 2002 08:50:23 -0500 (EST),
> > > Adam K Kirchhoff wrote:
> > > >
> > > >
> > > > On Wed, 20 Feb 2002, Takashi Iwai wrote:
> > > >
> > > > > At Mon, 18 Feb 2002 22:45:07 EST (-0500),
> > > > > Adam K Kirchhoff wrote:
> > > > > >
> > > > > >
> > > > > > I'm curious if anyone has gotten one of the ymfpci cards to work with
> > > > > >
> > > > > > front and rear output with the OSS emulation?  Is it even supported at
> > > > > >
> > > > > > this point?
> > > > >
> > > > > (please note i myself didn't test the following:)
> > > > >
> > > > > the rear pcm assigned to device #2.  so at first please check whether
> > > > > the driver really supports rear speakers by playing via hw:0,2, i.e.
> > > >
> > > > It does....  Alsa has natively supported both the front and rear channels
> > > > for a number of months now, iirc.
> > > >
> > > > > 	% aplay -Dhw:0,2 foo.wav
> > > >
> > > > Yep.  That works fine.
> > > >
> > > > One of the first things I'm noticing now, however, is that the only Alsa
> > > > application that seems to use the rear speakers is aplay, and only when
> > > > specified.  For example, alsaplayer will still only use the front
> > > > speakers.
> > >
> > > it's a problem of alsaplayer.  doesn't work "alsaplayer -d hw:0,2" ?
> >
> > Good question...  That's something I haven't tried.  I'll give it a shot
> > when I get home.
> >
> > However, here's the thing...  alsaplayer uses both the front and rear
> > outputs with the SB Live! by default.  No need to specify one or the
> > other.
> >
> > Now, I understand that since so many more people have SB Live! cards
> > driver development obviously isn't going to focus on the ymfpci cards as
> > much, but I'm curious if this is something that can eventually be enabled?
> > Is it an issue with the yamaha hardware?
> 
> Yamaha hardware has some contraints. The signal route for rear speakers is
> shared with the S/PDIF path, so you cannot use them at same time
> simultaneously.

That's interesting.  I wasn't aware of that.  Of course, I've never
actually tried to use them at the same time, but that's certainly good to
know.

> It's no problem for us to add a new control for the rear
> device (hw:0,2) which can control front speakers as well. We can also
> invert hw:0,2 and hw:0,0 after that change, so the default working mode
> will be "use front & rear speakers".

That would be perfect.  I'm curious though, is this also how it's done
with the the emu10k1 drivers?

Adam


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
