From: Andrew Burgess <aab@cichlid.com>
Subject: alsa 9.4 + SBLive! + USB iMic = hard lockup
Date: Thu, 19 Jun 2003 07:35:50 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200306191435.h5JEZow22643@athlon.cichlid.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

(I hope this doesn't appear twice, the first time bounced because
my subscription lapsed when the mailing list host switched to sourceforge)

kernel 2.4.21-rc7-ac1
alsa 9.4 (drivers, utils, libs)
Tyan dual athlon MP S2460 motherboard
(I tried it once with numcpus=1 just in case its an SMP
problem, no change)

My SBLive! is the default soundcard.

imic is defined in .asoundrc as:

  pcm.imic { 
    type hw
    card 1 
  }
  ctl.imic { 
    type hw
    card 1 
  }

I get a hard lockup (need to cycle power) when I try either:

  arecord -v -D imic --rate 44100 -f S16_LE - | aplay -v -

or

  arecord -v --rate 44100 -f S16_LE - | aplay -D imic  -v -

and then ^C to stop. Note, it runs fine until I ^C.

Running imic->imic or sblive->sblive works fine, ^C and rerun,
no problem. I've been using the SBLive! for years. I just
purchased the iMic.

It does print the "Aborted by signal Interrupt..." message
from alsa-lib twice (for arecord and aplay)

No log messages, oopses or other screen messages -- just locks up.
I have the driver configured --with-debug=full.

How may I help debug this further?

I'm able to reproduce safely now (the first time it happened
I got some filesystems corruption).

Just FYI here is the script I use to bring the system into a safe
state to crash ;-)

(I was unable to get the system to recognize the iMic when booting
in single user mode so I to bring it all the way up and then
down into single user mode. Any tips on this would be appreciated too,
I modprobed all the relevent modules and mounted usbdevfs, is there
something else?)

-------------------------------------------------------------------
#!/bin/sh
# BOOM

# need pull and reconnect the iMic cable to get it recognized?
case `cat /proc/asound/cards` in
  *iMic*) ;;
  *) echo cycle the iMic and try again; exit 1;;
esac

# need to go to single user mode?
case `runlevel` in
  *1|*S);;
  *) telinit 1; exit 1;;
esac

cd /tmp
case $0 in
  /tmp/BOOM) ;;
  *)
    # copy to /tmp so we can unmount /usr
    cp /usr/local/scripts/BOOM /tmp
    exec /tmp/BOOM
    ;;
esac

# stop stuff that doesn't always stop via telinit 1
service innd stop
service sendmail stop
killall x10
sleep 5
killall -v -9 x10
fses="/u /src /m5 /news"
for fs in $fses; do
  fuser -vmk $fs
done
sleep 5
for fs in $fses; do
  fuser -vmk -9 $fs
done
umount -av # also remounts root read-only

#OK arecord -v -D imic --rate 44100 -f S16_LE - | aplay -D imic -v -
#OK arecord -v --rate 44100 -f S16_LE - | aplay -v -
#DEATH arecord -v -D imic --rate 44100 -f S16_LE - | aplay -v -
arecord -v --rate 44100 -f S16_LE - | aplay -D imic  -v -





-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
