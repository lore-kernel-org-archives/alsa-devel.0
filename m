From: Niels Mayer <nielsmayer@gmail.com>
Subject: Re: Alsamixer-Qt4 0.4.0 released
Date: Sun, 8 Aug 2010 13:54:18 -0700
Message-ID: <AANLkTin0b0yBvVeVEGrWdkXUYh1J5Hwvj7Hu29iw3oV2@mail.gmail.com>
References: <4C595A52.7030401@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f172.google.com (mail-qy0-f172.google.com
	[209.85.216.172])
	by alsa0.perex.cz (Postfix) with ESMTP id BBA7024495
	for <alsa-devel@alsa-project.org>;
	Sun,  8 Aug 2010 22:54:19 +0200 (CEST)
Received: by qyk1 with SMTP id 1so1511792qyk.17
	for <alsa-devel@alsa-project.org>; Sun, 08 Aug 2010 13:54:18 -0700 (PDT)
In-Reply-To: <4C595A52.7030401@gmx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Sebastian H." <vand2@gmx.de>
Cc: alsa-user@lists.sourceforge.net, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This mixer is a major improvement over alsamixergui and alsamixer.
Unfortunately with envy24-based soundcards, it doesn't do the right
thing w/r/t the ice1712's built-in digital mixer (
http://nielsmayer.com/envy24control/envy24mixer-architecture.png ).
There's up to eight pairs of input monitors and PCM output monitors
that feed the mixer through L/R sliders that look like:
http://nielsmayer.com/envy24control/Mudita24-102-Monitor-Inputs.png
http://nielsmayer.com/envy24control/Mudita24-102-Monitor-Outputs.png
(Application shown in screenshots is envy24control modification known
as "mudita24"
 http://nielsmayer.com/envy24control/mudita24-1.0.3.tar.gz . )

In alsamixer-qt4, both the left and right sides of these attenuators
are controlled simultaneously, rather than individually. Likewise, the
mutes are controlled simultaneously when they should be individually
controllable left and right. Note that each of these controls has a
front left capture and a front right capture that must be controlled
individually. Furthermore, there appears to be a bug alsamixer-qt4 in
that it takes the value for the left setting for one channel (ie.
shows 100%) and then for the next it takes the setting for the right
(i.e. shows 0%). This gives an alternating pattern of sliders and
mutes that doesn't correspond to the alsa values. Of course, once
alsamixer-qt4 changes the values, then you have to go back in
envy24control and fix all values where left and right sides got set to
same value. http://nielsmayer.com/envy24control/Screenshot-Alsamixer-Qt4.png
is what it looks like.
(Btw "Delta IEC958 Input Status" should not be "writeable" -- it's a
status indicator, but in alsamixer-qt4, it doesn't turn on when then
digital input has signal).

 Here are the associated controls from 'amixer -c M66' from an M-audio
Delta 66.

(1) L/R monitor/mix of IEC958 digital input:

Simple mixer control 'IEC958 Multi',0
  Capabilities: cvolume cswitch penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 96
  Front Left: Capture 93 [97%] [on]
  Front Right: Capture 0 [0%] [off]
Simple mixer control 'IEC958 Multi',1
  Capabilities: cvolume cswitch penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 96
  Front Left: Capture 0 [0%] [off]
  Front Right: Capture 93 [97%] [on]

(2) L/R Monitoring of four analog inputs (ice1712 supports up to eight)

Simple mixer control 'H/W Multi',0
  Capabilities: cvolume cswitch penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 96
  Front Left: Capture 96 [100%] [0.00dB] [on]
  Front Right: Capture 0 [0%] [-144.00dB] [off]
Simple mixer control 'H/W Multi',1
  Capabilities: cvolume cswitch penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 96
  Front Left: Capture 0 [0%] [-144.00dB] [off]
  Front Right: Capture 96 [100%] [0.00dB] [on]
Simple mixer control 'H/W Multi',2
  Capabilities: cvolume cswitch penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 96
  Front Left: Capture 92 [96%] [-6.00dB] [on]
  Front Right: Capture 0 [0%] [-144.00dB] [off]
Simple mixer control 'H/W Multi',3
  Capabilities: cvolume cswitch penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 96
  Front Left: Capture 35 [36%] [-91.50dB] [off]
  Front Right: Capture 92 [96%] [-6.00dB] [on]

(3) L/R monitoring of 10PCM outs: channels 0-7 and one SPDIF pair at 8,9:

Simple mixer control 'Multi',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 96
  Mono:
  Front Left: Playback 96 [100%] [0.00dB] [on]
  Front Right: Playback 0 [0%] [-144.00dB] [off]
Simple mixer control 'Multi',1
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 96
  Mono:
  Front Left: Playback 0 [0%] [-144.00dB] [off]
  Front Right: Playback 96 [100%] [0.00dB] [on]
Simple mixer control 'Multi',2
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 96
  Mono:
  Front Left: Playback 96 [100%] [0.00dB] [off]
  Front Right: Playback 0 [0%] [-144.00dB] [off]
Simple mixer control 'Multi',3
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 96
  Mono:
  Front Left: Playback 46 [48%] [-75.00dB] [off]
  Front Right: Playback 96 [100%] [0.00dB] [off]
Simple mixer control 'Multi',4
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 96
  Mono:
  Front Left: Playback 93 [97%] [-4.50dB] [on]
  Front Right: Playback 0 [0%] [-144.00dB] [off]
Simple mixer control 'Multi',5
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 96
  Mono:
  Front Left: Playback 0 [0%] [-144.00dB] [off]
  Front Right: Playback 93 [97%] [-4.50dB] [on]
Simple mixer control 'Multi',6
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 96
  Mono:
  Front Left: Playback 96 [100%] [0.00dB] [on]
  Front Right: Playback 0 [0%] [-144.00dB] [off]
Simple mixer control 'Multi',7
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 96
  Mono:
  Front Left: Playback 0 [0%] [-144.00dB] [off]
  Front Right: Playback 96 [100%] [0.00dB] [on]
Simple mixer control 'Multi',8
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 96
  Mono:
  Front Left: Playback 96 [100%] [0.00dB] [on]
  Front Right: Playback 0 [0%] [-144.00dB] [off]
Simple mixer control 'Multi',9
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 96
  Mono:
  Front Left: Playback 0 [0%] [-144.00dB] [off]
  Front Right: Playback 96 [100%] [0.00dB] [on]

-- Niels
http://nielsmayer.com
