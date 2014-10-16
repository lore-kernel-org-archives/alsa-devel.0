From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [RFC][PATCH 00/15 v4] OXFW driver,
	a succesor to	firewire-speakers
Date: Thu, 16 Oct 2014 23:31:06 +0900
Message-ID: <543FD6AA.5080004@sakamocchi.jp>
References: <1399991272-5807-1-git-send-email-o-takashi@sakamocchi.jp>
 <53E795BD.1070100@ladisch.de> <53E957EA.3030601@sakamocchi.jp>
 <53E9BDC2.3000801@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 34E4C261AF0
 for <alsa-devel@alsa-project.org>; Thu, 16 Oct 2014 16:31:16 +0200 (CEST)
In-Reply-To: <53E9BDC2.3000801@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, stefanr@s5r6.in-berlin.de, fenlason@redhat.com
List-Id: alsa-devel@alsa-project.org

Clemens,

Today I got my show-stopper (Griffin FireWave) for OXFW driver and
investigate it with
easy script (see the end of this message).

Currently firewire-speakers driver handles this device but there're
known issues that:
1.the device doesn't generate sounds at some combinations between
channels and rates
2.96.0kHz/2ch seems not supported.

As a result of my investigation:
The device is known to have two modes: 5.1ch surround mode and Dolby Pro
Logic II mode.

At the former mode, stream transfers 6 PCM frames. At the latter mode,
stream stransfers 2 PCM frames. The driver can switch these modes to
execute AV/C Stream Format Information command with Single
subfunction[1]. The purpose of this command is to change internal
formation of a packet. Available formations can be retrieved by AV/C
Stream Format Information command with Single subfunction[1].

$ ./firewave.sh get
Supported stream formats:
response: 000: 0c ff bf c1 00 00 00 00 ff 00 00 90 40 04 02 01
............@...
response: 010: 06 06                                           ..
response: 000: 0c ff bf c1 00 00 00 00 ff 00 01 90 40 02 02 01
............@...
response: 010: 06 06                                           ..
response: 000: 0c ff bf c1 00 00 00 00 ff 00 02 90 40 03 02 01
............@...
response: 010: 06 06                                           ..
response: 000: 0c ff bf c1 00 00 00 00 ff 00 03 90 40 05 02 01
............@...
response: 010: 06 06                                           ..
response: 000: 0c ff bf c1 00 00 00 00 ff 00 04 90 40 02 02 01
............@...
response: 010: 02 00                                           ..
response: 000: 0c ff bf c1 00 00 00 00 ff 00 05 90 40 03 02 01
............@...
response: 010: 02 00                                           ..
response: 000: 0c ff bf c1 00 00 00 00 ff 00 06 90 40 04 02 01
............@...
response: 010: 02 00                                           ..
response: 000: 0a ff bf c1 00 00 00 00 ff ff 07 ff             ............
Current stream format:
response: 000: 0c ff bf c0 00 00 00 00 ff 00 90 40 04 02 01 06
...........@....
response: 010: 06                                              .
Supported sampling rates in current number of channels:
response: 000: 0c ff 19 00 90 00 ff ff                         ........
response: 000: 0c ff 19 00 90 01 ff ff                         ........
response: 000: 0c ff 19 00 90 02 ff ff                         ........
response: 000: 08 ff 19 00 90 03 ff ff                         ........
response: 000: 0c ff 19 00 90 04 ff ff                         ........
response: 000: 08 ff 19 00 90 05 ff ff                         ........
response: 000: 08 ff 19 00 90 06 ff ff                         ........

According to this output, the available formations of this device are:
Mode A. 6ch Multi Bit Linear Audio (MBLA) data at 32.0/44.1/48.0/96.0kHz
Mode B. 2ch IEC60958 Compliant data at 32.0/44.1/48.0kHz

For the detail of MBLA and IEC 60958 Compliant data, please refer to
[2]. The mode A is equivalent to 5.1ch surround mode, and mode B is
equivalent to Dolby Pro Logic II mode. FYI, the last commands are AV/C
Plug Signal Format commands[3] and they show the device generally
supports 32.0/44.1/48.0/96.0.

As long as I tested, the driver (firewire-speaker) can playback and the
device successfully generates sound unless the driver attempts to
transfer packets with different number of channels against current
setting. For example, when 2ch/48.0kHz is set, then playbacks at 2ch
32.0/44.1/48.0 are successful.
Or when 6ch/32.0kHz is set, then playbacks at 6ch 32.0/44.1/48.0/96.0
are successful.

But when the driver attempt to transfer packets with different number of
channels, this operation freezes the device. The device desn't react
transactions anymore. For example:

$ ./firewave.sh set 44100 6
response: 000: 09 ff bf c0 00 00 00 00 ff 00 90 40 03 02 01 06
...........@....
response: 010: 06                                              .
$ aplay -D hw:FireWave,0 -f S32_LE -c 2 -r 44100 /dev/urandom
(the application and the device freeze)

This causes a bad effect to userspace applications, especially
PulseAudio.When connecting sound devices, PulseAudio starts any streams
to detect its channel profiles. For FireWave, PulseAudio starts two
streams: 2ch and 6ch streams. These operations can freeze the device.

For 96.0kHz/2ch, I tried this:
$ ./firewave.sh set 48000 2
response: 000: 09 ff bf c0 00 00 00 00 ff 00 90 40 04 02 01 02
...........@....
response: 010: 00                                              .
$ aplay -D hw:FireWave -f S32_LE -c 2 -r 96000 /dev/urandom

The device is expected to generate noise but it sounds nothing. Thus I
think the device doesn't support this mode.

I have a plan to include improvements for this issue to my patchset for
OXFW driver. The patchset will be posted till the beginning of next
month, I think.

[1] TA Document 2004008, AV/C Stream Format Information Specification
1.1 (working draft) (April 15, 2005, 1394TA)
[2] IEC 61883-6:2005 Consumer audio/video equipment - Digital interface -
Part 6: Audio and Music Data Transmission Protocol, Edition 2.0
[2] TA Document 2004006, AV/C Digital Interface Command Set General
Specification Version 4.2 (September 1, 2004, 1394TA)


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp

----- 8< -----
$ cat ./firewave.sh

#!/bin/bash

if [ $# -lt 1 ] || [[ $1 != "get" ]] && [[ $1 != "set" ]]; then
	echo "firewave.sh 'get'"
	echo "firewave.sh 'set' (32000|44100|48000|96000) (2|6)"
	exit
fi

if [[ $1 == get ]]; then
	echo "Supported stream formats:"

	# AV/C Stream Format Information command with List subfunction
	for i in $(seq 0 7) ; do
		./firewire-request /dev/fw1 fcp $(printf
"0x01ffbfc100000000ffff%02xff" $i)
	done

	echo "Current stream format:"

	# AV/C Stream Format Information command with Single subfunction
	./firewire-request /dev/fw1 fcp 0x01ffbfc000000000ffffffff

	echo "Supported sampling rates in current number of channels:"

	# AV/C Plug Signal Format command
	for i in $(seq 0 6); do
		./firewire-request /dev/fw1 fcp $(printf "0x02ff190090%02xffff" $i)
	done

	exit
fi

if [ ! $# -eq 3 ]; then
	echo 'Invalid number of arguments.'
	exit
fi

if   [ $2 -eq 32000 ] && [ $3 -eq 6 ]; then
	rate=2
	ch=6
	format=6
elif [ $2 -eq 44100 ] && [ $3 -eq 6 ]; then
	rate=3
	ch=6
	format=6
elif [ $2 -eq 48000 ] && [ $3 -eq 6 ]; then
	rate=4
	ch=6
	format=6
elif [ $2 -eq 96000 ] && [ $3 -eq 6 ]; then
	rate=5
	ch=6
	format=6
elif [ $2 -eq 32000 ] && [ $3 -eq 2 ]; then
	rate=2
	ch=2
	format=0
elif [ $2 -eq 44100 ] && [ $3 -eq 2 ]; then
	rate=3
	ch=2
	format=0
elif [ $2 -eq 48000 ] && [ $3 -eq 2 ]; then
	rate=4
	ch=2
	format=0
elif [ $2 -eq 96000 ] && [ $3 -eq 2 ]; then
	rate=5
	ch=2
	format=0
else
	echo "Unsupported combination between rate and channel."
	exit
fi

# AV/C Stream Format Information command with Single subfunction
./firewire-request /dev/fw1 fcp $(printf
"0x00ffbfc000000000ff009040%02x0201%02x%02x" $rate $ch $format)
