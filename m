From: Jan 'RedBully' Seiffert <redbully@cc.fh-luh.de>
Subject: Re: [UDEV] Persitent ordering of ALSA-devices
Date: Mon, 04 Dec 2006 17:47:34 +0100
Message-ID: <45745126.9060401@cc.fh-luh.de>
References: <7nhSg-2Ow-9@gated-at.bofh.it> <7nk3R-84O-35@gated-at.bofh.it>
	<7nnbg-77Q-11@gated-at.bofh.it> <7no7s-PV-23@gated-at.bofh.it>
	<4570C14B.6090107@cc.fh-luh.de> <20061202080348.GB9422@kroah.com>
	<4571C735.6050403@cc.fh-luh.de>
	<1165231299.10319.278726991@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1165231299.10319.278726991@webmail.messagingengine.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: linux-hotplug-devel@lists.sourceforge.net, alsa-devel@lists.sourceforge.net, Greg KH <gregkh@gentoo.org>
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
> Jan 'RedBully' Seiffert wrote:
>> After Gentoo switched to udev-coldplug, my two soundcards get randomly
>> reordered on reboot. Now I need to write a udev rule to give them a
>> persistent ordering, but failed to do so until now, partly because i
>> don't know on what key ALSA orders devices so they become card0 and 1,
>> hw0 and hw1, partly because this feature of udev is so new.
> 
> ALSA's card ordering mechanism predates udev and isn't compatible with
> it.
> 
*sigh* ;(

> The ALSA framework has its own internal card list (that is shown in
> /proc/asound/cards).  Drivers can be instructed to take a specific card
> number with the 'index' option, and this is the only official way of
> reordering cards.
> 

I want to thank you and Marco for the clarification. After reading
Marcos mail, i slabbed my forehead like: "Ahh, yes, the index option".
Only saw it once on an old SuSE in the conf-files on the PC of my brother.
I now solved the problem for me with:
options snd-ice1712 index=0
options snd-via82xx index=1
in /etc/modules.d/alsa (which then migrates to the automatic generated
/etc/modprobe.conf, on gentoo).
Now, after several reboots, it seems to work, also with udev-coldplug
(which is tricky, because it happens so early, even before module autoload).


> It is, in theory, possible to rename the device files, but you have to
> be aware that
> 1) all devices files of one card must be renamed consistently, i.e,
>    the card number in the controlC*/hwdepC*D*/rawmidiC*D*/pcmC*D*p/
>    pcmC*D*c files (the number after the "C") must be the same for all
>    device files belonging to each card; and
> 2) enumerating cards will no longer work correctly (the card number
>    returned by ALSA will still be the number specified with the index
>    parameter), i.e., card names/descriptions will be wrong when a
>    program tries to show them.
> 
> 

Renaming the device files in a consistent manner shouldn't be the
problem. Sure, the udev-rules would get a little bit longer, but still
possible (or call out to a program which gives the right name back).

But why should i do it, if it does not influence ALSA (the expected
way), only confuses it? And the main target, getting a persistent 'hw0'
etc. and 'default' isn't achieved by it. (especially since my ice1712
needs a lot of magic added (sample rate converter, buffer, dmix), thats
why i want it to be the 'default' device)

I only see one problem for this in the future:
I was able to distinguish the cards by module. But what happens, if
someone has the same card several times (same module)?
Rely on PCI bus ordering? A new PCI quirk for your mainboard to handle a
transparent bridge and then? Multithreaded probing anyone?
(You can strongly object to a feature like this, but it is desirable
from a users POV, like starting [xkg]dm as early as possible, to bring
the user a login screen, while cups and foo and bar still starting in
the background).

Please keep in mind, that Linux is predestinated for such use ;) Drivers
which can handle several instances of the same card (and if not, you can
fix it), ALSA as a fine API, good latency with mostly every card,
continued improvements to the core kernel, directly available to the
user (thanks to stable-API-nonsense.txt *everything* can be
fixed/improved, even if it means a transition for everyone), to raise
(IPC) performance and lower latency in every subsystem (pushed forward
by people with other kind of problems, like > 1k processors (go SGI,
go;), not only "the sound freaks") and RT for the extra fun to build a
cheap recording machine for example.
But i think i don't tell anyone news on this, and i extravagate...

> Regards,
> Clemens
> 
With best wishes and thanks to all who helped,
	Jan

PS: Sorry for any shortcomings in my english, don't had the time to
proof read it 20 times.
-- 
Coffeecup empty - Userpanic!

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
