From: Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: Some problems with 0.9beta11 drivers
Date: Sun, 24 Mar 2002 23:03:50 -0800 (PST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0203242300300.4328-100000@cmn37.stanford.edu>
References: <Pine.LNX.4.33.0203242147220.9245-100000@mcmillan.cadence.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <Pine.LNX.4.33.0203242147220.9245-100000@mcmillan.cadence.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Ken McMillan <mcmillan@cadence.com>
Cc: Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>, Paul Davis <pbd@Op.Net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> > > Actually, I think I found the problem. I was using the maximum number
> > > of playback and captures channels reported by the device. For
> > > "plughw", this number is apparently 10000, rather than the actual
> > > number the hardware supports! I guess what I have to do is open the
> > > "hw" device first to get the actual number of channels, then open
> > > "plughw" with that number of channels. 
> > 
> > That would work in the "default" alsa configuration. It does not work in 
> > the generic case as the hw and plughw default devices might be pointing to 
> > completely different hardware (for example "hw" might be pointing to the 
> > second card in a system, a 24 channel Hammerfall, and "plughw" might point 
> > to the first card, a stereo Ensoniq 64 :-)
> 
> I *do* need to know the physical number of channels, since I
> have a little mutitrack recording app, and a GUI that lets the user
> select a source channel for each track. It would be a bit silly to
> have to ask the user how many channels there are before putting up the
> GUI. Anyway, it sounds like I should just use the "hw" device and
> forego the plugins. 

That's what I ended up doing for the alsa support in snd. 

There are a couple of workarounds that can be programmed in the asoundrc 
file to enable a plug pcm to not use the channel mixing conversion (don't 
remember exactly how now, look in the archives) but it is not something 
you can control from your code. 

-- Fernando
