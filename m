From: Mark Knecht <markknecht@comcast.net>
Subject: Re: Two sound cards, only sound out of one
Date: Tue, 26 Aug 2003 09:13:27 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1061914407.2317.9.camel@Wizard.knechthome.com>
References: <20030824121353.06de39c8.erikd-alsa@mega-nerd.com>
	 <20030824095120.49055.qmail@web40613.mail.yahoo.com>
	 <20030824203749.27d69196.erikd-alsa@mega-nerd.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030824203749.27d69196.erikd-alsa@mega-nerd.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Erik de Castro Lopo <erikd-alsa@mega-nerd.com>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 2003-08-24 at 03:37, Erik de Castro Lopo wrote:

> Errr, headphones actually. Do you think speakers would be better? :-)

:-) Yes. ;-)
> 
> Jokes aside, card0 works just as I would expect it to and card1 is
> completely silent.

Erik,
   As I've watched this thread I wonder how sure you are that amixer
settings for the second card are actually going to the second card? Are
you able to set different volume and mute settings for the two cards and
show that they are truly different values?

   Also, I've had real problems recently with aplay, and unfortunately
haven't gotten much response on the couple of reflectors that I've asked
questions on, so I wouldn't be surprised if some of this isn't more
aplay problems.

   My experience with aplay is:

1) It plays stereo files only to channels 1 and 2, which isn't so bad.

2) It plays mono files to ALL channels

Personally I wouldn't be surprised if it turned out part of the problem
hee was that aplay was sending no data to the second card.

   Have you tried a two card virtual setup yet? That and something like
qjackconnect would be good for making sure you were sending data to the
second card. I'd try this and not worry about the clocking issues, or
give the second card a clock based on the first card's outputs if you
have the right hardware. (spdif clocks, etc.)

Good luck,
Mark
> 
> Erik



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
