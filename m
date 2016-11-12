From: Christian Quentin <christian.quentin@orange.fr>
Subject: working with a Tascam US-122mkII
Date: Sat, 12 Nov 2016 18:46:13 +0100
Message-ID: <5d70e7e5-bb61-2574-b133-3864b913a629@orange.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from 3.mo1.mail-out.ovh.net (3.mo1.mail-out.ovh.net [46.105.60.232])
 by alsa0.perex.cz (Postfix) with ESMTP id BC594260083
 for <alsa-devel@alsa-project.org>; Sat, 12 Nov 2016 18:46:14 +0100 (CET)
Received: from player726.ha.ovh.net (b7.ovh.net [213.186.33.57])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id 0AC5F1737A
 for <alsa-devel@alsa-project.org>; Sat, 12 Nov 2016 18:46:14 +0100 (CET)
Received: from [10.0.0.14] (194-172-190-109.dsl.ovh.fr [109.190.172.194])
 (Authenticated sender: christian.quentin@transparence-c.com)
 by player726.ha.ovh.net (Postfix) with ESMTPSA id A73E32A0072
 for <alsa-devel@alsa-project.org>; Sat, 12 Nov 2016 18:46:13 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Hi all,

I'm currently trying to use a Tascam US-122mkII sound card with Linux. 
I've made the following attempts:

  * with a Debian-Wheezy-based distro (called Tango Studio) which is
    stopped now => I can use the Tascam card
  * with a Debian-Jessie-based distro (called Librazik) which
    development is active => I cannot use the Tascam card


I'm able to use the card with Tango Studio but I would prefer to use the 
Librazik as there's a community maintaining it.

  * In Debian Wheezy, the card is identified as US122L
  * In Debian Jessie, the card is identified as US122mkII which looks
    promising but it's not fully functional



These are the steps we went through with the linuxmao.org team :
== checking the kernel version ==
**********************************************************************************
Debian Wheezy
cat /proc/version
**********************************************************************************
Linux version 3.2.0-4-realtime-amd64 (debian-kernel@lists.debian.org) 
(gcc version 4.6.3 (Debian 4.6.3-14) ) #1 SMP PREEMPT RT Debian 
3.2.57-3+tstudio.2

**********************************************************************************
Debian Jessie
cat /proc/version
**********************************************************************************
Linux version 4.6.0-1-lzk-bl-amd64 (debian-kernel@lists.debian.org) (gcc 
version 4.9.2 (Debian 4.9.2-10) ) #1 SMP PREEMPT Debian 4.6.2-2librazik1 
(2016-06-29)



== checking the sound card detected ==

**********************************************************************************
Debian Wheezy
cat /proc/asound/cards
**********************************************************************************
0 SB <http://linuxmao.org/SB>: HDA-Intel - HDA ATI SB
HDA ATI SB at 0xfebfc000 irq 17
1 US122L <http://linuxmao.org/US122L>: USB US-122L - TASCAM US-122L
TASCAM US-122L (644:8021 if 0 at 001/002)

**********************************************************************************
Debian Jessie :
cat /proc/asound/cards
**********************************************************************************
0 SB <http://linuxmao.org/SB>: HDA-Intel - HDA ATI SB
HDA ATI SB at 0xfebfc000 irq 17
1 MKII <http://linuxmao.org/MKII>: USB-Audio - US122 MKII
TASCAM US122 MKII at usb-0000:00:13.5-1, high speed




== creating a ~/.asoundrc file ==

I was instructed to create an .asoundrc file

**********************************************************************************

 1. got from http://www.nabble.com/tascam-us122l-and-ccrma-td24036395.html
 2. thanks to Karsten


 1. The usb_stream plugin configuration


pcm.!usb_stream {
@args CARD <http://linuxmao.org/CARD>
@args.CARD {
type string
default "0"
}

type usb_stream

card $CARD
}

ctl.!usb_stream {
@args CARD <http://linuxmao.org/CARD>
@args.CARD {
type string
default "0"
}

type hw

card $CARD
}
**********************************************************************************



== starting Jack server ==
I'm using QjackCtl to start the Jack server with the following parameters:

**********************************************************************************
Debian Wheezy
QjackCtl -> Settings -> Parameters -> "Interface" : usb_stream:1
**********************************************************************************
=> Jack server starts OK

**********************************************************************************
Debian Jessie
QjackCtl -> Settings -> Parameters -> "Interface" : usb_stream:1
**********************************************************************************
=> Jack server does not start
I've tried to remove the .asoundrc : Jack server does not start either

**********************************************************************************
Debian Jessie
QjackCtl -> Settings -> Parameters -> "Interface" : hw:MKII US122 MKII 
(hw:1)
(this value is already in the drop-down list of interfaces
**********************************************************************************
=> Jack server starts with the following message :

**********************************************************************************
hw:MKII|hw:MKII|1024|2|48000|0|0|nomon|swmeter|-|32bit
ALSA: Cannot open PCM device alsa_pcm for capture. Falling back to 
playback-only mode
**********************************************************************************

The result is I can use the sound card to play sounds but cannot get any 
input from it (I'm trying to get MIDI events)


The linuxmao.org team thinks there might be a change in the ALSA driver 
in the latest releases.
What do you think?

Thanks for your help

Christian
