From: <ico@fuse.net>
Subject: snd-hdsp+cardbus=distortion -- the saga continues (cardbus driver=culprit?)
Date: Fri, 26 Mar 2004 18:15:17 +0000
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040326181517.CZPI16557.smtp2.fuse.net@smtp.fuse.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
To: linux-audio-user@music.columbia.edu, alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: ico@fuse.net
List-Id: alsa-devel@alsa-project.org

Hi all,

NOTE: I am cc-ing this to the kernel list in hope someone there might h=
ave a better insight in this. For the kernel people who intend to respo=
nd to this, I would greatly appreciate it if you could CC me, as I am n=
ot subscribed to the kernel list.

Summary:
snd-hdsp (RME Multiface cardbus pro-audio soundcard) works in Linux but=
 the sound is trashed (distorted). In Windows on the same notebook, eve=
rything works fine. The problem has been now reported on 2 completely d=
ifferent notebooks (Acer 1400 with 02 cardbus and my eMachines m6805 wi=
th ENE CB1410 cardbus controller). I suspect at this point that the cul=
prit is most likely the cardbus driver (yenta_socket in my case).
---------------------


After digging some more I am absolutely confident that my problem with =
the hdsp_multiface+laptop(cardbus) is definitely not only similar but i=
dentical to the problem Tim Blechmann reported in January. The scary pa=
rt is that my laptop is completely different brandname than his and use=
s entirely different cardbus (IIRC he has Acer 1400 with the O2 cardbus=
; I have eMachines m6807 with ENE CB1410 cardbus).

I think that this now has to have something to do with the current stat=
e of the kernel cardbus drivers (pcmcia-cs has not been updated since D=
ecember so I would assume that they are no better than the ones that ar=
e found in the kernel) and possibly the updated hdsp driver (although n=
ot entirely sure on this last one).

Here's the current scoop on the problem:

Windows XP -- stuff works great, everything as expected. The only thing=
 is that when the computer goes to standby/hibernate, upon resuming the=
 sound is all distorted (just like Tim reported it -- slower, full of a=
rtifacts, but you can still discern the original sound's content); this=
 most likely has to do with the crappy BIOS my notebook has (esp. in re=
spect to the ACPI and APIC -- DSDT table is trashed etc.). After distor=
tion occurs, overclocking the computer seems to speed the sound up brin=
ging it closer to the desired playback speed but the artifacts remain. =
Miller Puckette suggested that perhaps the hdsp is not getting proper c=
lock info from the CPU, something that I have not investigated as of ye=
t as I do not currently have access to an external equipment that would=
 provide Word Clock functionality. Although this also sounds a bit weir=
d as the soundcard works just fine upon first boot (prior to suspending=
 the computer). No matter how many times I reconnect the card and/or me=
ss with it before suspending the computer, everything continues to work=
 as expected.

Linux:
Mandrake Community 10.0
Kernel 2.6.3
Plenty of RAM and other junk
IRQ for cardbus and hdsp is shared on 11 (them sharing the same irq IIR=
C should be normal behavior)
Alsa 1.0.2 and 1.0.3 tested (1.0.2 came with the system, 1.0.3 compiled=
 from source)
Latest Jack and alsaplayer packages compiled from source

Hw:0 onboard via82xx
Hw:1 snd-hdsp

ACPI and APIC are disabled due to BIOS issues with the laptop and becau=
se even with the pci=3Dnoacpi flag in lilo the system still freezes whe=
n inserting cardbus. I saw somewhere a kernel patch that would enable u=
se of cardbus with a limited acpi presence (pci=3Dnoacpi) but have not =
tried using it just yet mainly since presence of acpi should not have a=
ny positive bearing on resolving this issue (if anything, it would make=
 it even worse due to IRQ shuffling).

Modprobing goes without a hitch, pcmcia service automatically starts, t=
he cardbus interface using yenta_socket driver. Snd-hdsp also works wit=
hout a hitch and configuring the soundcard is all ok (hdsploader, hdspc=
onf, hdspmixer all check-out fine).

aplay =96D plughw:1 (or plughw:hw:1 forget the exact syntax =96 current=
ly booted into Windoze) <soundfile>  plays the sound distorted similarl=
y like in Windows after resume.

Jackd =96d alsa =96d hw:1 with various flags and sampling rates of eith=
er 44100 or 48000 works without any dropouts. Just like with Tim, no di=
stortion is coming through until the sound is played. During the sound =
playback, the distortion is identical to the one during the playback wi=
thout jackd.

Connecting simple clients like jack_metro plays stuff, but distorted.

Alsaplayer when connected via jackd also works but again distorted. I h=
ave to put the playback at 200% speed to get the right =93tempo=94 of t=
he song but the sound of the song=92s singer is now very high-pitched (=
chipmunk?). Distortion persists no matter what.

Reconnecting cardbus and all that works but the distorted sound persist=
s.

Hdspmixer shows the sound levels as expected and they reflect the fact =
that the sound is being played slower than it should be and that it is =
distorted.

Messing with hdspconf during playback makes no difference. Adjusting th=
e sampling rate though does alter the sound of distortion when playing =
(just like in Tim=92s case), but does not alleviate it.

/var/log/syslog lists no complaints and/or problems. (I will check more=
 thoroughly for the boot-time stuff).

I am aware of the fact that the BIOS is somewhat trashed (manufacturer=92=
s fault) but not to the point where machine does not behave normally, e=
sp. in Windows.

Some have suggested switching distros, but my understanding is that Tim=
 was running gentoo and I am running Mandrake and we=92re both having t=
he same problem=85

Tim, I believe also used 2.4 kernel without success, as well as pre-1.0=
 Alsa drivers.

---------------------------------------

TODO:
1) provide detailed lspci
2) thoroughly check /var/log/syslog for anything suspicious
3) try pcmcia-cs (most likely won=92t work as Tim already tried that an=
d it made no difference on his laptop, also the package wasn=92t update=
d since Dec.)
4) try playback with an external Word Clock source
5) provide downloadable examples of the distorted sounds
6) Pester alsa-dev, lau, and kernel/pcmcia people to death begging for =
help :-)
7) Pester eMachines to update BIOS (I may retire before this one happen=
s, though)
8) Something else?

I would appreciate any help with this one especially now that we know t=
hat the problem is not related to one particular notebook/cardbus contr=
oller=85

I will provide additional info as soon as I get home (sometime early ne=
xt week).

Many thanks!

Best wishes,

Ivica Ico Bukvic, composer & multimedia sculptor
http://meowing.ccm.uc.edu/~ico/
ico@fuse.net
