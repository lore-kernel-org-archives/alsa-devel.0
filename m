From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: alsasound init script (Re: possible problems with
 rc6 aplay )
Date: Fri, 20 Dec 2002 17:10:27 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0212201700430.5232-100000@studcom.urz.uni-halle.de>
References: <s5hadj0vi85.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hadj0vi85.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Mark Knecht <markknecht@attbi.com>, Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>, Paul Davis <paul@linuxaudiosystems.com>, Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Mark Knecht wrote:
> > I was wondering what would happen in this process if someone had two r
> > three identical USB devices, like the MidiMan 2X2? OR also two identical
> > cards like the RME HDSP 9652?
>
> when a module is loaded and two or more identical (or supported)
> devices are connected, the module will initialize the all such devices
> at once.
>
> for multiple devices, you can specify the options separated by commas,
>
> > It is important that the system recognize the same hardware as the same
> > sound device every time the machine booted, and whether the machine is
> > warm or cold booted.
>
> in the case of usb, it's not 100% sure, because it's anyway
> hotpluggable.  but usually the order of probing is identical, so it's
> ok.

It is possible to force USB devices to a specific index with the vid/pid
parameters for the vendor/product id, even when hotplugging.
However, this won't work when you hotplug two identical devices (with the
same product id).


Clemens



-------------------------------------------------------
This SF.NET email is sponsored by:  The Best Geek Holiday Gifts!
Time is running out!  Thinkgeek.com has the coolest gifts for
your favorite geek.   Let your fingers do the typing.   Visit Now.
T H I N K G E E K . C O M        http://www.thinkgeek.com/sf/
