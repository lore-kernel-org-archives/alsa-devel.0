From: Andy Wingo <wingo@pobox.com>
Subject: Re: Some problems with 0.9beta11 drivers
Date: Sun, 24 Mar 2002 23:28:37 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020325042836.GE32064@jesus>
References: <200203250325.WAA27492@renoir.op.net> <Pine.LNX.4.33.0203242003540.9245-100000@mcmillan.cadence.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0203242003540.9245-100000@mcmillan.cadence.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, 24 Mar 2002, Ken McMillan wrote:

> Actually, I think I found the problem. I was using the maximum number
> of playback and captures channels reported by the device. For
> "plughw", this number is apparently 10000, rather than the actual
> number the hardware supports! I guess what I have to do is open the
> "hw" device first to get the actual number of channels, then open
> "plughw" with that number of channels. 

This is something of a FAQ, it seems to come up every month or so (at
least it has since i asked it a few months ago ;-) -- the answer is that
plughw can do lots of conversion for you, and downmixing (not sure if
that's the proper term) 10000 channels into 1 or 2 is certainly
plausible, i suppose.

So that probably sounds pretty silly to you, and it did to me too, but
the essence of the answer is that you have no business knowing how many
channels the hardware supports. Like it or not, that's the way it is.
The flexibility of alsa devices, given the asoundrc, is so large that
concepts like 'how many channels does this device support' can be
meaningless sometimes.

good luck,

wingo.
