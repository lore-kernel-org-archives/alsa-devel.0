From: "Ivica Bukvic" <ico@fuse.net>
Subject: More Midisport 2x2 troubles
Date: Thu, 3 Apr 2003 00:10:26 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <000001c2f99f$56a75b80$ac1f830a@ICO>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net, linux-audio-user@music.columbia.edu
Cc: nando@ccrma.stanford.edu
List-Id: alsa-devel@alsa-project.org

Hi all,

I just upgraded to Mdk 9.1 and reinstalled all of the MIDI-related
stuff, as well as the Alsa 0.9.2 (from sources, after uninstalling Mdk's
RPM's). I also installed Fernando's modified alsasound script that
enables smart unloading of snd- modules.

The end result is that the midisport works, well sort of.

The firmware loads fine, and the midisport is properly recognized. The
problem is that I only have one MIDI port available even though this is
the 2x2 version (I had 2 ports in Mdk 9.0, usually /dev/midi(0) and
/dev/midi1). Now I only have /dev/midi.

The interesting thing is that the /proc/asound/card1/midi0 lists the
following:

Output 0
	Tx bytes 	: 0
Output 1
	Tx bytes	: 0
Input 0
	Rx bytes	: 5 (this number changes, most likely because
it's the only port that has anything hooked up to it)
Input 1
	Rx bytes	: 0

So, it seems that there are 2 I and 2 O ports, but they are all
allocated within the midi0 device according to the proc stuff (or
/dev/midi1 according to the dev stuff). If this is the case, then how do
I access the second port.

Cat /dev/midi1 only outputs stuff coming into the first port, so that
tells me something's fishy.

I am using CCRMA's hotplug 8_26_1 and ezusbmidi 2002_11_17.

There were no alterations to the kernel or any other part of the system
(apart from the alsa install and other audio software installs).

My modules.conf looks like this:

# ALSA portion
alias char-major-116 snd
alias char-major-14 soundcore
alias snd-card-0 snd-intel8x0
alias sound-slot-0 snd-card-0
alias snd-card-1 snd-hdsp
alias sound-slot-1 snd-card-1
alias snd-card-2 snd-usb-audio
alias sound-slot-2 snd-card-2
options snd major=116 cards_limit=4 device_mode=0666 device_gid=0
device_uid=0
options snd-intel8x0 index=0
options snd-hdsp index=1
options snd-usb-audio vid=0x763 pid=0x1001 index=2

# CS4205
alias sound-service-0-0 snd-mixer-oss
#alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
#alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss

#HDSP
alias sound-service-1-0 snd-mixer-oss
alias sound-service-1-1 snd-seq-oss
alias sound-service-1-3 snd-pcm-oss
alias sound-service-1-8 snd-seq-oss
alias sound-service-1-12 snd-pcm-oss

#MIDISPORT
alias sound-service-2-1 snd-seq-oss
alias sound-service-2-8 snd-seq-oss

In this situation the hdsp is not in use, so midisport assumes the 2nd
card position.

Upon midisport reconnect, the /var/log/messages spits out the following:
Apr  2 23:59:49 badass-bukvic kernel: usb.c: USB disconnect on device
00:1d.2-1 address 29
Apr  3 00:00:00 badass-bukvic kernel: hub.c: new USB device 00:1d.2-1,
assigned address 30
Apr  3 00:00:00 badass-bukvic kernel: usb.c: USB device 30 (vend/prod
0x763/0x1001) is not claimed by any active driver.
Apr  3 00:00:03 badass-bukvic /etc/hotplug/usb.agent: Setup ezusbmidi
for USB product 763/1001/1
Apr  3 00:00:03 badass-bukvic /etc/hotplug/usb.agent: Module setup
ezusbmidi for USB product 763/1001/1
Apr  3 00:00:03 badass-bukvic /etc/hotplug/usb/ezusbmidi: load
/usr/share/usb/ezusbmidi/ezusbmidi2x2.ihx for 763/1001/1 to
/proc/bus/usb/002/030
Apr  3 00:00:03 badass-bukvic kernel: usb.c: USB disconnect on device
00:1d.2-1 address 30
Apr  3 00:00:03 badass-bukvic kernel: hub.c: new USB device 00:1d.2-1,
assigned address 31
Apr  3 00:00:07 badass-bukvic /etc/hotplug/usb.agent: Setup
snd-usb-audio audio usb-midi for USB product 763/1110/1
Apr  3 00:00:07 badass-bukvic /etc/hotplug/usb.agent: ... blacklisted
module:  audio
Apr  3 00:00:07 badass-bukvic /etc/hotplug/usb.agent: ... blacklisted
module:  usb-midi
Apr  3 00:00:07 badass-bukvic /etc/hotplug/usb.agent: Setup alsasound
for USB product 763/1110/1
Apr  3 00:01:00 badass-bukvic modprobe: modprobe: Can't locate module
sound-service-2-2

(NB: what's up with the sound-service-2-2, is there such a thing?)

Upon doing this, cat /dev/midi1 is the only one that works.

Other pertinent info is (in abbreviated form):
/proc/asound/version -> ALSA=0.92 kernel=2.4.21-0.13mdk
../cards -> 0 i810, 1 2x2 (Midisport) at usb-00:1d.2-1
../card1/ has id and midi0 files only

All I also remember the last time when I was using 0.9.0 is that I had
to upgrade from CVS in order to get both ports (it was the snd-usb-audio
bug IIRC). But now, I did d/l and install 0.9.2 which should have those
fixes but I can't seem to get the second port to work. Could it be that
there's something leftover from the mdk 0.9.0 version of Alsa even after
I did rpm -e and reinstalled 0.9.2 from sources?

Any help on this issue is greatly appreciated! Sincerely,

Ivica Ico Bukvic, multimedia sculptor
http://meowing.ccm.uc.edu/~ico




-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
