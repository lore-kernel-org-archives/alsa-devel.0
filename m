From: Mark Hubbard <mark@egghead.free-online.co.uk>
Subject: Re: Prodigy 7.1 ?
Date: Wed, 15 Oct 2003 15:35:00 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200310151535.00442.mark@egghead.free-online.co.uk>
References: <3FF3EBB8.6020503@aei.ca> <1066221700.7989.63.camel@caernarfon> <s5hzng2irjx.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hzng2irjx.wl@alsa2.suse.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wednesday 15 Oct 2003 14:00, Takashi Iwai wrote:
> At Wed, 15 Oct 2003 13:41:40 +0100,
>
> Liam Girdwood wrote:
> > Hi,
> >
> > Unfortunately WM8770 driver development is not in my immediate to do
> > list. However, I do remember someone had done some work on the 8770
> > (possibly on the Aureon Terratec card). You may want to look at this as
> > a starting point for your driver.
>
> yes, it's in aureon.c, which is based also on ice1724 chip.
> hacking this code would be the first step.
>
> > You will also have to write some code for your audio controller chip
> > (ICE1724). This chip controls and sends/receives audio data to the
> > WM8770 codec. If your lucky, this chip may also be part of another
> > driver.
>
> the problem is that each ice1724 board is implemented with different
> GPIO use.  furthermore, ice1724 has 24 (i forgot the exact number)
> GPIO pins, while ice1712 has only 8.  it makes already difficult to
> check the pin connection.  the help of the board vendor is most likely
> needed.
>
>
> Takashi
>

The Prodigy 7.1 is identically the same card as the Aureon Space 7.1....just 
different firmware and digital coaxial instead of toslink.



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
