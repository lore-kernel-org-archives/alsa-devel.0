From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Interesting problem with hotplug and Midisport 2x2 on
 Mdk 9.0
Date: Mon, 03 Mar 2003 16:32:46 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0303031619020.9822-100000@studcom.urz.uni-halle.de>
References: <3E605E78.9070501@boosthardware.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <3E605E78.9070501@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Patrick Shirkey wrote:
> Patrick Shirkey wrote:
> > Takashi Iwai wrote:
> >>> I see it too with the quattro and another user has reported it with
> >>> the audigy. It would be nicer if we didn't have to remember to unload
> >>> the usb-audio driver before hotplugging. Is it possible to make that
> >>> happen.
> >>
> >> then there is still a bug in this regard.
> >> are you using MIDI on quattro, too?
> >
> > It is automatically used. Clemens would have to explain as I cannot
> > remember the exact details.

MIDI input always has a URB submitted.

> I another bug I was just reminded of is that if I remove the alsa
> modules while the usb device is still switched on I get a complete hang
> where I have to restart with alt+sysreq+b

All these crashes look like the bug which has been fixed on 13th January,
so it should work with 0.9.0rc7. Nothing like this happens with my devices
(UA-1A and SC-8820), and I regularly plug/unplug them and load/unload the
drivers during debugging.


HTH
Clemens




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
