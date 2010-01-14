From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: alsa-sink.c: ALSA woke us up to write new data to
	the device, but there was actually nothing to write!
Date: Thu, 14 Jan 2010 08:39:15 +0800
Message-ID: <4f3252891001131639r32839116g725dce03f75846e1@mail.gmail.com>
References: <4B4E1464.3090801@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f198.google.com (mail-pz0-f198.google.com
	[209.85.222.198])
	by alsa0.perex.cz (Postfix) with ESMTP id C9A89103815
	for <alsa-devel@alsa-project.org>; Thu, 14 Jan 2010 01:39:16 +0100 (CET)
Received: by pzk36 with SMTP id 36so16099982pzk.5
	for <alsa-devel@alsa-project.org>; Wed, 13 Jan 2010 16:39:15 -0800 (PST)
In-Reply-To: <4B4E1464.3090801@gmx.de>
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

2010/1/14 Konrad Schlichtherle <kconny@gmx.de>

> Hello,
>
> sometimes it occure that my speakers do not play sound although the
> speakers should play music with VLC. Then i took a look at
> /var/log/messages and found this:
>
> Jan 13 17:01:39 riker pulseaudio[3335]: alsa-sink.c: ALSA woke us up to
> write new data to the device, but there was actually nothing to write!
> Jan 13 17:01:39 riker pulseaudio[3335]: alsa-sink.c: Most likely this is
> a bug in the ALSA driver 'snd_hda_intel'. Please report this issue to
> the ALSA developers.
> Jan 13 17:01:39 riker pulseaudio[3335]: alsa-sink.c: We were woken up
> with POLLOUT set -- however a subsequent snd_pcm_avail() returned 0 or
> another value < min_avail.
>
> The output of utils_alsa-info.sh is there:
> http://www.alsa-project.org/db/?f=1767e9bc745724a67c908549d20c137375d0605e
>
> I didn't know wether this is a bug or a misconfiguration of my openSUSE
> 11.2
>
> Konrad
> _


you better upgraded to 1.0.22.1 since there are some patches for HDA VIA
codec

provide a full pulseaudio log using the latest pulseaudio git  and a test
case which can reproduce the bug

pulseaudio -k; pulseaudio -vvvvv

!!ALSA Version
!!------------

Driver version:     1.0.20
Library version:    1.0.22
Utilities version:  1.0.22


Independent HP mode ON seem allow the front panel green jack to be used
independent of the rear panel green jack (HDA multi streaming )


	control.15 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 OFF
		comment.item.1 ON
		iface MIXER
		name 'Independent HP'
		value ON
	}

You have two subdevices on playback device 0 and capture device 0

http://pulseaudio.org/ticket/743


!!Aplay/Arecord output
!!------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: NVidia [HDA NVidia], device 0: VT1708B Analog [VT1708B Analog]
  Subdevices: 1/2
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
card 0: NVidia [HDA NVidia], device 1: VT1708B Digital [VT1708B Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: NVidia [HDA NVidia], device 0: VT1708B Analog [VT1708B Analog]
  Subdevices: 2/2
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
