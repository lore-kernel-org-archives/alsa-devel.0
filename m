From: Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: Some problems with 0.9beta11 drivers
Date: Sun, 24 Mar 2002 21:24:45 -0800 (PST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0203242046160.4328-100000@cmn37.stanford.edu>
References: <20020325042836.GE32064@jesus>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <20020325042836.GE32064@jesus>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Andy Wingo <wingo@pobox.com>
Cc: Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> > Actually, I think I found the problem. I was using the maximum number
> > of playback and captures channels reported by the device. For
> > "plughw", this number is apparently 10000, rather than the actual
> > number the hardware supports! I guess what I have to do is open the
> > "hw" device first to get the actual number of channels, then open
> > "plughw" with that number of channels. 
> 
> This is something of a FAQ, it seems to come up every month or so (at
> least it has since i asked it a few months ago ;-) -- the answer is that
> plughw can do lots of conversion for you, and downmixing (not sure if
> that's the proper term) 10000 channels into 1 or 2 is certainly
> plausible, i suppose.

It is going to keep happening more frequently as more people write for the
alsa api. Eventually it might sink in that there is a problem with the api
that needs to be solved.

> So that probably sounds pretty silly to you, and it did to me too, but
> the essence of the answer is that you have no business knowing how many
> channels the hardware supports. Like it or not, that's the way it is.

Even after all this time it still sounds silly to me (sorry). I think I
should be able to know how many channels the hardware supports if I want
to - when it is possible, of course. It is no bussiness of the driver to
withhold information from the programmer, the information in question is
there, I suppose. We either need:

a) an api for querying the devices that make up a plug pcm. If it is not
possible to map things neatly to devices the api should say, "sorry, can't
do that" - but in 99% of the cases it would be able to point to a hardware
device and say: "that's what's behind the plug pcm". 

b) a way to add plug conversions one by one to a hw pcm (or remove
conversions from a plug pcm - in this case removing channel mixing - if
such a thing exists as an entity - would reveal the real number of
channels we have to play with).

> The flexibility of alsa devices, given the asoundrc, is so large that
> concepts like 'how many channels does this device support' can be
> meaningless sometimes.

Sure, this may not be practical in some cases, but in 99% of the
configurations the concept of "number of channels" is perfectly well
defined and should be something I can get from the api. 

"b" is most probably the easiest to do. Jaroslav hinted a long time ago (I
seem to remember) that the foundation for that is already there. Obviously
the man-hours needed to write the code are not so easy to come by :-)

-- Fernando
