From: Duncan Sands <baldrick@wanadoo.fr>
Subject: Re: init script with hotplug & usb audio
Date: Mon, 30 Sep 2002 09:55:14 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200209300955.14788.baldrick@wanadoo.fr>
References: <200209261020.25769.baldrick@wanadoo.fr> <200209270908.41909.baldrick@wanadoo.fr> <s5hk7l7l3pd.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hk7l7l3pd.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Friday 27 September 2002 19:53, Takashi Iwai wrote:
> except for the check of /proc/asound, the hotplug problem can be
> sorted to the following:
>
> 1. hotplug may be called before alsa init script.
>
> 2. hotplug needs to manage the mixer configuration of plugged /
>    unplugged devices dynamically.
>
> 3. alsa initscript itself should be independent from hotplug.
>
> they are not all but certainly a major part of the problems.
>
>
> the first one is not easy, because the network devices can belong to
> hotplug, too.  the scenario is like this:
>   many alsa files are located under /usr
>     -> a networkfs (e.g. NFS) is required before the alsa service
>       -> the network must be initialized in prior
>         -> the network base = hotplug is needed to run before alsa!
>
> the second problem is also tough.
> alsa driver needs to access the device to get the current mixer
> values, but at the remove callback of hotplug, the device was actually
> unplugged...  probably implementing cache would be necessary.

Another point to keep in mind here, is that a lot of people are now
using journaled filesystems, and may just turn off the computer
without shutting down.  You could say that they deserve what they
get, but I'm not so sure.  Imagine someone using alsamixer to change
mixer settings.  They quit alsamixer then turn off the machine.  Are
they wrong to expect the mixer settings to still be there on reboot?
After all, they "saved the settings" when they left alsamixer didn't they?

> the third one is obvious.
> i don't think it's good to let hotplug initialize the pci cards, too.
> for example, if i don't have any usb devices, i'd like to remove
> hotplug.  but if alsa initscript rely on the hotplug stuff, i cannot
> do that.  that's bad.
>
> well, still many obstacles ahead.
> i'd love to see a perfect solution :)

Duncan.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
