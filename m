From: "Ivica Bukvic" <ico@fuse.net>
Subject: Interesting problem with hotplug and Midisport 2x2 on Mdk 9.0
Date: Thu, 27 Feb 2003 13:00:10 -0500
Sender: alsa-user-admin@lists.sourceforge.net
Message-ID: <000201c2de8a$1237dfe0$aa1f830a@ICO>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-admin@lists.sourceforge.net>
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net, mandrakeexpert@mandrakesoft.com
Cc: 'Fernando Pablo Lopez-Lezcano' <nando@ccrma.Stanford.EDU>
List-Id: alsa-devel@alsa-project.org

Hi all,

This is my latest finding. Thanks to the script I got from Jaroslav, I
am now able to hotplug my midisport 2x2 whenever I wish to do so.
However, there is an interesting problem surrounding Mdk9.0.

If I use the planet ccrma's hotplug ver. 2002_8_26 (by forcing upgrade
of the mdk's), I get the fxload and all the goodies making the midisport
work right out-of-the-box. However, with one huge flaw: 

When I unplug the midisport (after having the alsasound hotplug script
installed), my kernel oops and system freezes telling me something about
"disabling interrupt handler." (if someone tells me where I can track
this information log I will be happy to forward it). So, I am simply not
allowed to unplug the device.

In addition my /var/log/messages relatively often spits out the
following message:
<date> <host> kernel: usb-uhci.c: interrupt, status 3, frame#
<some_number>

I've tracked down the problem to the /sbin/modprobe -r snd-usb-midi (and
snd-usb-audio). If I move this thing somewhere else in the alsasound
hotplug script (like purging it at load-time and then reloading the
driver, rather than on disconnect) then the freeze occurs at that point.
When I comment it out, no freezes occur. So, I am pretty sure that is
the culprit.


On the other hand, if I downgrade to Mdk's hotplug ver. 2002_4_01, then
no oops occur (except one has to put alsasound.usermap and
ezusbmidi.usermap to /etc/hotplug/usb.usermap.local, since this older
version does not support usb sub-dir placing of usermaps. However in
this case my midisport offers me only 1 I/O device (even though it is
2x2), as opposed to the ccrma's which rightly gives me 2. (both report
locating 2 I and 2 o devices in /var/log/messages log, but only ccrma's
offers both devices via /dev/midi*).

I tried diff-ing the files from the two rpm packages to see if I am able
to locate the place where this dramatic change occurs, but found that
most of the files involved in the two packages are rather similar, if
not the same, major difference being the support of the usb/ subdir for
storing module scripts.

So, what gives?

Anyone has a clue? What is so different between the two packages that
one causes kernel oops/freeze, while the other one gives me only one i/o
midi port?

The files contained within each package are mostly files located in
/etc/hotplug dir, some man stuff, and fxload and hotplug from the /sbin/
dir (fxload being present in later hotplug package, while for the older
one, I extracted only that file from the ccrma's package and put it in
the right place).

In addition to this, I just noticed that the same message is showing up
in my /var/log/messages when using the mdk's package, so that one most
likely is not the problem, or at least not associated with this issue...

Any help is greatly appreciated! Sinceerely,

Cc: mdk bug reports


Ivica Ico Bukvic, composer, multimedia sculptor,
programmer, webmaster & computer consultant 
http://meowing.ccm.uc.edu/~ico 
============================ 
"To be or not to be" - Shakespeare
"To be is to do"     - Socrates
"To do is to be"     - Sartre
"Do be do be do"     - Sinatra
"2b || ! 2b"         - ?
"I am"               - God




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
