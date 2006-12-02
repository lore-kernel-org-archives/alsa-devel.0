From: Jan 'RedBully' Seiffert <redbully@cc.fh-luh.de>
Subject: [UDEV] Persitent ordering of ALSA-devices (was:
 [gentoo-dev] Re: udev coldplugging and /etc/init.d/modules)
Date: Sat, 02 Dec 2006 19:34:29 +0100
Message-ID: <4571C735.6050403@cc.fh-luh.de>
References: <7nhSg-2Ow-9@gated-at.bofh.it> <7nk3R-84O-35@gated-at.bofh.it>
	<7nnbg-77Q-11@gated-at.bofh.it> <7no7s-PV-23@gated-at.bofh.it>
	<4570C14B.6090107@cc.fh-luh.de> <20061202080348.GB9422@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20061202080348.GB9422@kroah.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: linux-hotplug-devel@lists.sourceforge.net
Cc: alsa-devel@lists.sourceforge.net, Greg KH <gregkh@gentoo.org>
List-Id: alsa-devel@alsa-project.org

[dropping gentoo-dev since it's OT there, writing to
linux-hotplug-devel, adding alsa-devel, keeping Greg CCed]

*spoiler*
After Gentoo switched to udev-coldplug, my two soundcards get randomly
reordered on reboot. Now I need to write a udev rule to give them a
persistent ordering, but failed to do so until now, partly because i
don't know on what key ALSA orders devices so they become card0 and 1,
hw0 and hw1, partly because this feature of udev is so new.

Greg KH wrote:
> On Sat, Dec 02, 2006 at 12:56:59AM +0100, Jan 'RedBully' Seiffert wrote:
>> OK, then maybe someone knows how to get ALSA-Devices in an persistent
>> ordering with udev-rules?
>> I was unable to find it out by my self, the documentation is a little
>> sparse on this IMHO...
> =

> Just figure out something unique for your sound devices, and create some
> rules like the other persistent rule generators do.  PCI device id
> perhaps?
> =

Writing a matching rule isn't the problem for me, something like:
SUBSYSTEM=3D=3D"sound", ATTRS{vendor}=3D=3D"0x1106", ATTRS{device}=3D=3D"0x=
3059" =A7=A7=A7
for the on board VIA and:
SUBSYSTEM=3D=3D"sound", ATTRS{vendor}=3D=3D"0x1412", ATTRS{device}=3D=3D"0x=
1712" =A7=A7=A7
for the Terratec DMX 6Fire.

My problem is at the "=A7=A7=A7". What action should i give these rules?
And as i already wrote, i do *not* need symlinks or the like. I need to
get them in the right oder from the ALSA-POV, hw0 and hw1.
That's also the point where the documentation gets sparse, not on all
the filter and start-external-program things.
(And finally, where have those rules to be placed in the order of udev
rules?)

But maybe i'm off the track and ALSA takes the ordering by /dev-name (or
sysfs name), [controlC|midiC0D|pcmC[\d]D]0 is hw0 and 1 is hw1, but that
is not obvious from /proc/asound, that looks more like i have to
influence card0 and card1, but they are not in /dev or sysfs.

> If you have problems with this, try asking on the linux-hotplug-devel
> mailing list.  The people there can help you out.  It would be good to
> have some rules for sound devices like this, as you aren't the first to
> ask about it.
> =

Looks like, that will be my next stop.
Or even better, i drive by at alsa-devel to ask which magic knob
controls ordering. Hopefully it's not the order in which the modules
call alsa_register_driver or something like that...

>> udev-coldplug bite me with my 2 soundcards (one onboard, one PCI). They
>> are randomly ordered on every reboot. I don't care which /dev/snd/*
>> names they get, ALSA uses them, the times of 'cat /dev/urandom >
>> /dev/dsp' are long gone. I *care* about, which device is snd-card-0 and
>> 1, which is hw0 and hw1, and which device gets bound to 'default'.
> =

> Yeah, I have a box around here like that too :(
> =

hmmm, ok, and did you come to a conclusion how to solve this?
Keep as is/live with it?
Every time when they change order, dive behind your PC to replug your
speaker?
Log in as root and restart /etc/init.d/alsasound? (which is little
uncomfortable for me, because of MusicPlayerDaemon. It gets stoped and
restartet automatically with alsasound, but is busted afterwards. So i
have to stop it by hand before and start it by hand afterwards)

>> Interestingly with the old coldplug the devices always had the same
>> order and (by accident? or /etc/modules.d/alsa?) the right.
> =

> PCI device order is usually quite stable, unless you start to use PCI
> hotplug, or change cards, or update your BIOS.  If you did any of that,
> then it would start to get unpredictable.
> =

No, nothing of that, same BIOS all the time, hotpluging the on board
device would be "very hotpluging" (with a soldering iron), and the
PCI-card is mounted stationary and buried behind the breakout
box-/IDE-/SCSI-ribbon cables, *no* hotplug at all.
Still, on reboot they get randomly ordered by udev-coldplug.
Or it is a "race", i have a SMP system.

Maybe i should take a look at things like "reset ESCD data" (or whatever
it was called) in the BIOS, but i don't see a reason, why it should do this.

> thanks,
> =

> greg k-h
> =

No, i have to thank you as a busy Kernel developer, for taking the time
and looking at my problem. It's an honer for me to get a mail form Greg
KH as a mere user.

Greetings
	Jan

-- =

pod* a;
pott* b;
a =3D (pod *)b;
a real podcast :-D

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
