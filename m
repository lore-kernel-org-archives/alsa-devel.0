From: "Ivica Bukvic" <ico@fuse.net>
Subject: RE: [Alsa-devel] Interesting problem with hotplug and Midisport 2x2 on Mdk 9.0
Date: Thu, 27 Feb 2003 13:48:24 -0500
Sender: alsa-user-admin@lists.sourceforge.net
Message-ID: <000301c2de90$cefded80$aa1f830a@ICO>
References: <s5h65r5k2uc.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-admin@lists.sourceforge.net>
In-Reply-To: <s5h65r5k2uc.wl@alsa2.suse.de>
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: 'Takashi Iwai' <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net, mandrakeexpert@mandrakesoft.com
List-Id: alsa-devel@alsa-project.org

Actually, now that I have reinstalled the src.rpm package of hotplug
8_26_2002 (from sourceforge), I do get both the 2 midi ports and audio
(crashes still occur). I've now discovered two more interesting issues:

1) Upon booting and installing the midisport 2x2 for the first time
(regardless whether that is at boot time or afterwards), I get 2 midi
ports and everything is ok. If I then disconnect and reconnect it,
everything is still ok, but now I only have 1 midi port. Seems like only
the first time is a charm. This is no biggie, since I've overcome the
major problems, but still may point to some kind of a bug in (I presume)
Alsa.

2) The other rather important observation is that the crash (kernel
oops) occurs, when I omit the /sbin/modprobe -r snd-usb-midi line from
the Jaroslav's script as you have suggested (this has happened several
times and every time I comment it out, the thing crashes with the same
interrupt handler async oops, while the system remains rock solid
regardless of numbers of reconnects when the thing is not commented
out).

It makes me wonder whether that call to remove a module that does not
exist gives the kernel enough time to clean up something usb-related on
its side before invoking the removal of the module, therefore avoiding
the oops (the second line /sbin/modprobe -r snd-usb-audio). It would be
perhaps a good idea to do a small sleep command there and see whether
that would work as well as the above-mentioned removal of the
non-existent module (but I don't know how to put one there since I am
not that good with shell scripts -- any ideas are welcome though).

Still, the issue of reconnect giving you only 1 midi port remains. :-)

Note: mandrake-expert developers, if you need the script and config
e-mailed in order to have Mandrake 9.0 auto-detect alsasound devices and
dynamically load them, please contact me and I'll e-mail them to ya.

Ico




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
