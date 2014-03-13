From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Low volume ad1983
Date: Thu, 13 Mar 2014 21:20:46 +0800
Message-ID: <CAN8ccibdwRr5q1yXsrt+4pBJkfd+=3p0Z6vmLGC97sUgBkmung@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f44.google.com (mail-qa0-f44.google.com
 [209.85.216.44])
 by alsa0.perex.cz (Postfix) with ESMTP id C88EA2651E3
 for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2014 14:20:47 +0100 (CET)
Received: by mail-qa0-f44.google.com with SMTP id f11so970656qae.3
 for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2014 06:20:46 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: sam chan <schan@cs.ucr.edu>, Clemens Ladisch <cladisch@googlemail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

>>sam chan wrote:
>> i'm having a problem with sound volume being too low.
>> i **think** it's due to the levels of my channel map being
>> too low.....

>The channel map specifies which channel goes to which
>physical output.

>> my alsa-info...
>> http://www.alsa-project.org/db/?f=3ba6278df3c6c4abe5196ad37f8015de7223ca8e

>> Simple mixer control 'Master',0
>>   Mono: Playback 37 [59%] [-39.00dB] [on]

>That is pretty low.

>> Simple mixer control 'Loopback Mixing',0
>>   Item0: 'Enabled'

>Why is this enabled?

seem driver bug

1) Should the volume control and playback switch of line out be named
as Front instead of PCM ?


Node 0x05 [Pin Complex] wcaps 0x400185: Stereo Amp-Out
  Control: name="PCM Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="PCM Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Line Out Jack", index=0, device=0
  Amp-Out caps: ofs=0x3d, nsteps=0x3f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x23 0x23]
  Pincap 0x00000017: OUT Detect Trigger ImpSense
  Pin Default 0x01014010: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Green
    DefAssociation = 0x1, Sequence = 0x0

2) dB max of virtual master playback volume is different from the
slave when slave dbmax of slaves  > 0


	control.1 {
		iface MIXER
		name 'PCM Playback Volume'
		value.0 61
		value.1 61
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 63'
			dbmin -9150
			dbmax 300
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.3 {
		iface MIXER
		name 'Headphone Playback Volume'
		value.0 61
		value.1 61
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 63'
			dbmin -9150
			dbmax 300
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.5 {
		iface MIXER
		name 'Speaker Playback Volume'
		value 61
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 63'
			dbmin -9150
			dbmax 300
			dbvalue.0 0
		}
	}
	control.17 {
		iface MIXER
		name 'Master Playback Volume'
		value 37
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 63'
			dbmin -9450
			dbmax 0
			dbvalue.0 -3900
		}
	}
