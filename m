From: "Ivica Ico Bukvic" <ico@fuse.net>
Subject: RE: Major problem with RME HDSP/Multiface and a 64-bit AMD laptop -- SOLVED!!! (partially)
Date: Sat, 20 Mar 2004 21:47:21 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040321024721.EUMC1963.smtp3.fuse.net@64BitBadass>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: 
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: george@synthax.com, support@synthax.de, linux-audio-dev@music.columbia.edu, linux-audio-user@music.columbia.edu, alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all!

After some tinkering with the drivers, I've done unthinkable :-) -- the
cardbus now works flawlessly in Windoze (for Linux read below).

What I basically did is investigated the current driver in Windoze for the
carbus and it came up as a "generic cardbus interface." I was by now aware
that the exact cardbus chipset is/was ENE C1410. So I did some searching on
the Google for the driver and came up with HP's driver download page for one
of their laptops (mine is eMachines m6807). So, I said what the heck, at
this point I just might as well go ahead and try it. So I downloaded the
driver (link:
http://h18007.www1.hp.com/support/files/hpcpqnk/us/download/18388.html)
installed it, it went without a hitch and asked me to reboot. Upon rebooting
the device manager listed the pcmcia interface as the "ENE C1410 Cardbus
Interface." So far, so good! Upon reconnecting the RME HDSP and playing the
sound, the sound was absolutely flawless at 3ms latency!!! Yay!

Now, I need to do more testing to see exactly what are the real limits of
the cardbus, but as of right now, everything seems to be working fine. This
laptop is a real gem after all (for $1400 is simply unbeatable, especially
considering that the voodoopc sells the exact same chasis with a bit faster
processor for $3200!).

However, there is one aspect that is yet to be resolved, and that is Linux +
cardbus issue. With the hardware concerns now being out of the way
(obviously driver upgrade in Windoze has proven that it was software-based),
this leads me to believe that the Linux kernel's yenta_socket module that is
currently being used for this particular ENE C1410 cardbus is apparently not
quite compatible with it. Hence, whoever has any access to the kernel/pcmcia
module developers/maintainers, I would greatly appreciate it if you could
please forward this info to them, as it may prove to be valuable.

Anyhow, I guess this time around the story has a happy ending after all.
Many thanks to everyone for your assistance in this matter! At least in
Linux it is simply a matter of time until the drivers are properly tweaked
(unless ACPI/APIC has also something to do with it).

Best wishes,

Ivica Ico Bukvic, composer & multimedia sculptor
http://meowing.ccm.uc.edu/~ico/
 




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
