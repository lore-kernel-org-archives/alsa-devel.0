From: Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: Some problems with 0.9beta11 drivers
Date: Sun, 24 Mar 2002 21:31:25 -0800 (PST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0203242125480.4328-100000@cmn37.stanford.edu>
References: <Pine.LNX.4.33.0203242003540.9245-100000@mcmillan.cadence.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <Pine.LNX.4.33.0203242003540.9245-100000@mcmillan.cadence.com>
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

On Sun, 24 Mar 2002, Ken McMillan wrote:
> Actually, I think I found the problem. I was using the maximum number
> of playback and captures channels reported by the device. For
> "plughw", this number is apparently 10000, rather than the actual
> number the hardware supports! I guess what I have to do is open the
> "hw" device first to get the actual number of channels, then open
> "plughw" with that number of channels. 

That would work in the "default" alsa configuration. It does not work in 
the generic case as the hw and plughw default devices might be pointing to 
completely different hardware (for example "hw" might be pointing to the 
second card in a system, a 24 channel Hammerfall, and "plughw" might point 
to the first card, a stereo Ensoniq 64 :-)

At this point there is no generic solution to finding out the underlying
hardware capabilities of a plug pcm, to be able to autoconfigure software.  
As Paul suggests, search the archives for the long thread on this last
fall...

-- Fernando
