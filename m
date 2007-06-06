From: Carsten Beth <Carsten.Beth@offis.de>
Subject: Connecting two USB-Soundcard to JACK
Date: Wed, 6 Jun 2007 11:46:02 +0200
Message-ID: <200706061146.02592.Carsten.Beth@offis.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from offis3.offis.uni-oldenburg.de (offis3.OFFIS.Uni-Oldenburg.DE
	[134.106.52.239])
	by alsa0.perex.cz (Postfix) with ESMTP id 0459024402
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Jun 2007 11:47:12 +0200 (CEST)
Received: from domino.offis.uni-oldenburg.de (domino.OFFIS.Uni-Oldenburg.DE
	[134.106.51.103])
	by offis3.offis.uni-oldenburg.de (Postfix) with ESMTP id 643DF12F1E1
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Jun 2007 11:47:07 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello!

We want to connect two USB soundcards to one multichannel device at the alsa 
layer and to use that virtual device with JACK. But we don't find a way to do 
so.

The USB soundcard is self-made. It woks as a high speed USB device with sample 
rates of up to 96 KHz, has four capture and two playback cannels. The clocks 
of two cards can be synchronized at hardware level. Using one card by its own 
works perfectly both, at the alsa and at the JACK level, also as a duplex 
device. All is done with alsalib 1.0.13, jackd 0.101.1 and qjackctl 0.2.21.

Now I'm trying to build a virtual device with 8 capture and 4 playback 
channels at the alsa level. But, as it can be read at several locations, this 
only works for capture only or playback. It has been reported, that duplex 
operation is possible after patching pcm_multi.c. I have applyed the patch, 
but this has not changed anything. Now I want to ask you for support, to get 
the device running.

I made some experiments with different configurations of alsa/jackd and had 
some strange results. You can read about the results and used the asoundrc 
below. Questions, that I can't answer are 
- Why do I see just the channels of one card when using the multi plugin in 
try 2), 5) and 7)?
- Why is the processor load so high with playback only in try 2) and 3) but 
not in duplex operation?
- Why are there lots non-adible xruns with playback only in try 2) and 3)?


1) playback only with p_multi
ALSA: mmap-based access is not possible for the playback stream of this audio 
interface

2) playback only with p_multi_plug
Playback of just the 1st cards two channel.
Lot of processor load: Both cores of the Core Duo 2GHz system are at about 90% 
load.
Lot of XRUNs:
	08:01:35.514 XRUN callback (48501 skipped).
	08:01:37.517 XRUN callback (80633 skipped).
	08:01:39.519 XRUN callback (70612 skipped).
but XRUNS can't be heard.
Sometimes jackd terminates after a while:
	ALSA: could not complete playback of 256 frames: error = -32
	cycle execution failure, exiting
	DRIVER NT: could not run driver cycle
	jack main caught signal 12
	[...]
	zombified - calling shutdown handler
	[...]
	08:01:40.926 Post-shutdown script terminated with exit status=256.

3) playback only with p_multi_route
Number of channels as expected (4 channels, two from each card).
Lot of processor load, like 2)
Lot of non-adible XRUNS, like 2).
Sometimes jackd terminates after a while with the same message as in 2).

4) capture only with c_multi
ALSA: mmap-based access is not possible for the capture stream of this audio 
interface

5) capture only with c_multi_plug
Captures just two channel from the 1st card
Low processor load (near 0%)
No XRUNS.

6) capture only with c_multi_route
Number of channels as expected (8 channels, four from each card).
Low load and no XRUNS, like 5)

7) duplex with p_multi_plug and c_multi_plug
Playback and capture works just for the 1st card (two playback and 4 capture 
channels).
Low processor load, like 2)
Lot of XRUNs, but less the 2) (and now the XRUNS can be heard). Here is a 
snip:
	**** alsa_pcm: xrun of at least 0.010 msecs
	11:34:00.013 XRUN callback (9 skipped).
	**** alsa_pcm: xrun of at least 0.014 msecs
	11:34:02.037 XRUN callback (11 skipped).
	**** alsa_pcm: xrun of at least 0.018 msecs
	**** alsa_pcm: xrun of at least 0.016 msecs
	11:34:04.069 XRUN callback (11 skipped).
	**** alsa_pcm: xrun of at least 0.016 msecs
	11:34:06.099 XRUN callback (11 skipped).
	**** alsa_pcm: xrun of at least 0.018 msecs
	**** alsa_pcm: xrun of at least 0.013 msecs
	11:34:08.116 XRUN callback (12 skipped).
Sometimes jackd terminates after a while with the same message as in 2).

8) duplex with p_multi_route and c_multi_route
Exactly the same as in 7) expect for the number of channels. Now all channels 
are available (four playback and four capture channels)


Here the used asoundrc:

#####################################
# 1st USB card
#####################################

pcm.usb0 {
    type hw
    card 1
}

ctl.usb0 {
    type hw           
    card 1
}



#####################################
# 2nd USB card
#####################################

pcm.usb1 {
    type hw
    card 2
}

ctl.usb1 {
    type hw           
    card 2
}



pcm.p_multi {
    type multi;
    slaves.a.pcm "usb0";
    slaves.a.channels 2;
    slaves.b.pcm "usb1";
    slaves.b.channels 2;

    bindings.0.slave a;
    bindings.0.channel 0;
    bindings.1.slave a;
    bindings.1.channel 1;
    bindings.2.slave b;
    bindings.2.channel 0;
    bindings.3.slave b;
    bindings.3.channel 1;
}

ctl.p_multi {
        type hw;
        card 1;
}



pcm.c_multi {
    type multi;
    slaves.a.pcm "usb0";
    slaves.a.channels 4;
    slaves.b.pcm "usb1";
    slaves.b.channels 4;

    bindings.0.slave a;
    bindings.0.channel 0;
    bindings.1.slave a;
    bindings.1.channel 1;
    bindings.2.slave a;
    bindings.2.channel 2;
    bindings.3.slave a;
    bindings.3.channel 3;

    bindings.4.slave b;
    bindings.4.channel 0;
    bindings.5.slave b;
    bindings.5.channel 1;
    bindings.6.slave b;
    bindings.6.channel 2;
    bindings.7.slave b;
    bindings.7.channel 3;
}
ctl.c_multi {
        type hw;
        card 1;
}



pcm.p_multi_plug {
        type plug;
        slave.pcm "p_multi";
        ttable.0.0 1;
        ttable.1.1 1;
        ttable.2.2 1;
        ttable.3.3 1;
}

ctl.p_multi_plug {
        type hw;
        card 1;
}



pcm.c_multi_plug {
        type plug;
        slave.pcm "c_multi";
        ttable.0.0 1;
        ttable.1.1 1;
        ttable.2.2 1;
        ttable.3.3 1;
        ttable.4.4 1;
        ttable.5.5 1;
        ttable.6.6 1;
        ttable.7.7 1;
}

ctl.c_multi_plug {
        type hw;
        card 1;
}



pcm.p_multi_route {
        type route;
        slave.pcm "p_multi";
        ttable.0.0 1;
        ttable.1.1 1;
        ttable.2.2 1;
        ttable.3.3 1;
}
ctl.p_multi_route {
        type hw;
        card 1;
}



pcm.c_multi_route {
        type route;
        slave.pcm "c_multi";
        ttable.0.0 1;
        ttable.1.1 1;
        ttable.2.2 1;
        ttable.3.3 1;
        ttable.4.4 1;
        ttable.5.5 1;
        ttable.6.6 1;
        ttable.7.7 1;
}
ctl.c_multi_route {
        type hw;
        card 1;
}


Thank you
    Carsten Beth

-- 
Dipl.-Inform. Carsten Beth
OFFIS - Institute for Information technology
R&D Division Embedded Hardware-/Software-Systems
Escherweg 2 - 26121 Oldenburg - Germany - http://www.offis.de/
Phone: +49-441-9722-241 - Fax: +49-441-9722-282
