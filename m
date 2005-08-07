From: Frank van de Pol <fvdpol@coil.demon.nl>
Subject: trouble binding multiple ice1712 devices
Date: Sun, 7 Aug 2005 22:55:51 +0200
Message-ID: <20050807205551.GA20190@obelix.int.coil.demon.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from obelix.int.coil.demon.nl (coil.demon.nl [82.161.23.179])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 559731E4
	for <alsa-devel@alsa-project.org>; Sun,  7 Aug 2005 22:55:52 +0200 (MEST)
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
Cc: linux-audio-dev@music.columbia.edu
List-Id: alsa-devel@alsa-project.org


Hi folks, 

I'm having some trouble building a working asound.conf to get my soundcards
functional using jack.

The audio hardware consists of 3 Terratec ice1712 boards: 2x EWS88/D + 1x
Phase88, hooked up using the EWS connect clock synchronisation cables.  My
goal is to get full duplex audio I/O for my home studio: 16 channels ADAT
in/out and 8 channels analogue in/out. I verified that this configuration
works from my old windows 2000 partition (using the terratec ASIO driver).

Till now I did not succeed getting this gear fully working in my linux
environment; it seems that I'm having trouble with the asound.conf to setup
the binding for the devices.

- running jack addressing the hw: devices directly works flawless; but that
  way I can only use one card at a time

- as per descriptions from the mailing list archive I tried to setup an
  aggregate device using the alsa multi type plugin. Since Jack needs to
  mmap the buffer it needs an additional route type plugin to make the
  capture stream interleaved. However, at this stage I run into a few
  issues:

	* due to the different number of ports the ice1712 has for 
          playback (12) and capture (10) I can't do full duplex I/O. 
     	* when I do a capture only from the route plugin I hear a distorted
          sound (quiet, metalic, you can hear the rhythm from the orignal
          track), which I suspect is caused by the route plugin. I can't
          verify if this effect is specific to my 64bit machine or also
          present on 32bit
        * I tried to setup different input/output for capture and playback
          using the asym plugin type, but this attempt caused jackd to kill
	  the graph after a few seconds full of xruns.

If anyone has a pointer to or copy of a working asound.conf for multitrack
recording/playback using multiple ice1712 based cards I'd be very interested
to see those.
 
Some details about the software I'm running:
	Advanced Linux Sound Architecture Driver Version 1.0.9b.
	kernel 2.6.12-gentoo-r4 on AMD64 hardware
	Jackd 0.99.0


Here's my non-functional attempt at a asound.conf for binding 2 Terratec
EWS88/D cards:

=============================================================================

# card0 is the onboard via82xx / ac97 sound
#
# card1 is a EWS88/D (ADAT 1-8)
# card2 is a EWS88/D (ADAT 9-16)
# card3 is a Phase88 (analog 17-24)
#
# card4 is a Midiman Midisport 4x4 USB Midi interface

#default
pcm.!default {
        type hw
        card 0
}

ctl.!default {
        type hw
        card 0
}



# Terratec EWS88/D hardware
#
pcm.ews_0 {
        type hw
        card 1
}
ctl.ews_0 {
        type hw
        card 1
}

pcm.ews_1 {
        type hw
        card 2
}
ctl.ews_1 {
        type hw
        card 2
}

# Aggregate of the 2 EWS88/D cards
#
ctl.ews_16 {
        type hw
        card 1
}
pcm.ews_16 {
        type multi
        slaves.a {
                pcm "ews_0"
                channels 12
        }
        slaves.b {
                pcm "ews_1"
                channels 12
        }

        bindings [
                # adat 1-8
                {slave a channel 0}
                {slave a channel 1}
                {slave a channel 2}
                {slave a channel 3}
                {slave a channel 4}
                {slave a channel 5}
                {slave a channel 6}
                {slave a channel 7}

                # spdif card 1
                #{slave a channel 8}
                #{slave a channel 9}
                #{slave a channel 10}
                #{slave a channel 11}

                # adat 9-16
                {slave b channel 0}
                {slave b channel 1}
                {slave b channel 2}
                {slave b channel 3}
                {slave b channel 4}
                {slave b channel 5}
                {slave b channel 6}
                {slave b channel 7}

                # spdif card 2
                #{slave b channel 8}
                #{slave b channel 9}
                #{slave b channel 10}
                #{slave b channel 11}
	]

}



# jack can't mmap the streams above since they are 
# scattered around at different memory locations

ctl.ews_jack {
        type hw
        card 1
}

pcm.ews_jack {
        # asym allows for different handlng of in/out devices
        type asym
        playback.pcm {
                type route
                slave.pcm "ews_16"
                ttable.0.0 1
                ttable.1.1 1
                ttable.2.2 1
                ttable.3.3 1
                ttable.4.4 1
                ttable.5.5 1
                ttable.6.6 1
                ttable.7.7 1
                ttable.8.8 1
                ttable.9.9 1
                ttable.10.10 1
                ttable.11.11 1
                ttable.12.12 1
                ttable.13.13 1
                ttable.14.14 1
                ttable.15.15 1
                #ttable.16.16 1
                #ttable.17.17 1
                #ttable.18.18 1
                #ttable.19.19 1
        }
        capture.pcm {
                type route
                slave.pcm "ews_16"
                ttable.0.0 1
                ttable.1.1 1
                ttable.2.2 1
                ttable.3.3 1
                ttable.4.4 1
                ttable.5.5 1
                ttable.6.6 1
                ttable.7.7 1
                ttable.8.8 1
                ttable.9.9 1
                ttable.10.10 1
                ttable.11.11 1
                ttable.12.12 1
                ttable.13.13 1
                ttable.14.14 1
                ttable.15.15 1
                #ttable.16.16 1
                #ttable.17.17 1
                #ttable.18.18 1
                #ttable.19.19 1
                #ttable.20.20 1
                #ttable.21.21 1
                #ttable.22.22 1
                #ttable.23.23 1
        }
}

=============================================================================


Cheers,
Frank.



-- 
+---- --- -- -  -   -    -
| Frank van de Pol                  -o)    A-L-S-A
| FvdPol@coil.demon.nl              /\\  Sounds good!
| http://www.alsa-project.org      _\_v
| Linux - Why use Windows if we have doors available?


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
