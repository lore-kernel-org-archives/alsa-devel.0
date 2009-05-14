From: Deweirdt Peter-Jan <deweirdt@gmail.com>
Subject: mute and unmute
Date: Thu, 14 May 2009 17:52:32 +0200
Message-ID: <50534132-7930-4128-B491-CC533D476F7B@gmail.com>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f175.google.com (mail-ew0-f175.google.com
	[209.85.219.175])
	by alsa0.perex.cz (Postfix) with ESMTP id E585B1039AC
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 17:52:34 +0200 (CEST)
Received: by ewy23 with SMTP id 23so1734284ewy.32
	for <alsa-devel@alsa-project.org>; Thu, 14 May 2009 08:52:34 -0700 (PDT)
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

Hi,

I have written a small (proof of concept)  program that is providing  
audio on all my channels on the audio. What I have noticed is that the  
"Speaker" channel gets muted every time. I don't know how or by who?

When I change with alsamixer the mute then after less then 5 sec it  
get muted. How can I debug who is muting my 'Speaker' channel.

Here is some output.

[root@localhost ~]# amixer -c 0
Simple mixer control 'Headphone',0
   Capabilities: pvolume pswitch
   Playback channels: Front Left - Front Right
   Limits: Playback 0 - 127
   Mono:
   Front Left: Playback 75 [59%] [-20.00dB] [on]
   Front Right: Playback 75 [59%] [-20.00dB] [on]
Simple mixer control 'Headphone SZCMode',0
   Capabilities: penum
   Items: 'Immediate' 'Zero Cross' 'Soft Ramp' 'Soft Ramp on Zero Cross'
   Item0: 'Soft Ramp'
Simple mixer control 'Line',0
   Capabilities: cvolume cswitch
   Capture channels: Front Left - Front Right
   Limits: Capture 0 - 63
   Front Left: Capture 51 [81%] [0.00dB] [off]
   Front Right: Capture 51 [81%] [0.00dB] [off]
Simple mixer control 'Line Input',0
   Capabilities: cvolume
   Capture channels: Front Left - Front Right
   Limits: Capture 0 - 3
   Front Left: Capture 0 [0%] [0.00dB]
   Front Right: Capture 0 [0%] [0.00dB]
Simple mixer control 'Line-In PGA Mode',0
   Capabilities: cenum
   Items: 'Differential' 'Single-ended'
   Item0: 'Differential'
Simple mixer control 'Line-Out',0
   Capabilities: pvolume pswitch
   Playback channels: Front Left - Front Right
   Limits: Playback 0 - 127
   Mono:
   Front Left: Playback 115 [91%] [0.00dB] [on]
   Front Right: Playback 115 [91%] [0.00dB] [on]
Simple mixer control 'Line-In SZCMode',0
   Capabilities: cenum
   Items: 'Immediate' 'Digital Immediate, Analog Zero Cross' 'Digital  
and Analog Soft Ramp' 'Digital Soft Ramp, Analog Zero Cross'
   Item0: 'Digital and Analog Soft Ramp'
Simple mixer control 'Line-Out SZCMode',0
   Capabilities: penum
   Items: 'Immediate' 'Zero Cross' 'Soft Ramp' 'Soft Ramp on Zero Cross'
   Item0: 'Soft Ramp'
Simple mixer control 'Mic',0
   Capabilities: cvolume cswitch
   Capture channels: Front Left - Front Right
   Limits: Capture 0 - 63
   Front Left: Capture 51 [81%] [0.00dB] [off]
   Front Right: Capture 51 [81%] [0.00dB] [off]
Simple mixer control 'Mic Input',0
   Capabilities: cvolume
   Capture channels: Front Left - Front Right
   Limits: Capture 0 - 3
   Front Left: Capture 0 [0%] [0.00dB]
   Front Right: Capture 0 [0%] [0.00dB]
Simple mixer control 'Mic PGA Mode',0
   Capabilities: cenum
   Items: 'Differential' 'Single-ended'
   Item0: 'Differential'
Simple mixer control 'Mic SZCMode',0
   Capabilities: cenum
   Items: 'Immediate' 'Digital Immediate, Analog Zero Cross' 'Digital  
and Analog Soft Ramp' 'Digital Soft Ramp, Analog Zero Cross'
   Item0: 'Digital and Analog Soft Ramp'
Simple mixer control 'IEC958',0
   Capabilities: pswitch pswitch-joined cswitch cswitch-joined
   Playback channels: Mono
   Capture channels: Mono
   Mono: Playback [off] Capture [off]
Simple mixer control 'IEC958 Default PCM',0
   Capabilities: pswitch pswitch-joined
   Playback channels: Mono
   Mono: Playback [on]
Simple mixer control 'Analog In',0
   Capabilities: cswitch cswitch-joined cswitch-exclusive
   Capture exclusive group: 0
   Capture channels: Mono
   Mono: Capture [on]
Simple mixer control 'Analog In',1
   Capabilities: cswitch cswitch-joined cswitch-exclusive
   Capture exclusive group: 0
   Capture channels: Mono
   Mono: Capture [on]
Simple mixer control 'Digital Input 1',0
   Capabilities: cvolume
   Capture channels: Front Left - Front Right
   Limits: Capture 0 - 2
   Front Left: Capture 0 [0%] [0.00dB]
   Front Right: Capture 0 [0%] [0.00dB]
Simple mixer control 'Digital Input 2',0
   Capabilities: cvolume
   Capture channels: Front Left - Front Right
   Limits: Capture 0 - 2
   Front Left: Capture 0 [0%] [0.00dB]
   Front Right: Capture 0 [0%] [0.00dB]
Simple mixer control 'Digital Mic',0
   Capabilities: cswitch cswitch-joined cswitch-exclusive
   Capture exclusive group: 0
   Capture channels: Mono
   Mono: Capture [off]
Simple mixer control 'Digital Mic',1
   Capabilities: cswitch cswitch-joined cswitch-exclusive
   Capture exclusive group: 0
   Capture channels: Mono
   Mono: Capture [off]
Simple mixer control 'Speakers',0
   Capabilities: pvolume pswitch
   Playback channels: Front Left - Front Right
   Limits: Playback 0 - 127
   Mono:
   Front Left: Playback 100 [79%] [-7.50dB] [off]
   Front Right: Playback 100 [79%] [-7.50dB] [off]
Simple mixer control 'Speakers SZCMode',0
   Capabilities: penum
   Items: 'Immediate' 'Zero Cross' 'Soft Ramp' 'Soft Ramp on Zero Cross'
   Item0: 'Soft Ramp'
[root@localhost ~]#



No I unmute the "Speaker" channel:

[root@localhost ~]# amixer set -c 0 Speakers unmute; date
Simple mixer control 'Speakers',0
   Capabilities: pvolume pswitch
   Playback channels: Front Left - Front Right
   Limits: Playback 0 - 127
   Mono:
   Front Left: Playback 100 [79%] [-7.50dB] [on]
   Front Right: Playback 100 [79%] [-7.50dB] [on]
Thu May 14 16:20:57 EDT 2009
[root@localhost ~]# amixer get -c 0 Speakers; date
Simple mixer control 'Speakers',0
   Capabilities: pvolume pswitch
   Playback channels: Front Left - Front Right
   Limits: Playback 0 - 127
   Mono:
   Front Left: Playback 100 [79%] [-7.50dB] [on]
   Front Right: Playback 100 [79%] [-7.50dB] [on]
Thu May 14 16:20:58 EDT 2009
[root@localhost ~]# amixer get -c 0 Speakers; date
Simple mixer control 'Speakers',0
   Capabilities: pvolume pswitch
   Playback channels: Front Left - Front Right
   Limits: Playback 0 - 127
   Mono:
   Front Left: Playback 100 [79%] [-7.50dB] [off]
   Front Right: Playback 100 [79%] [-7.50dB] [off]
Thu May 14 16:21:00 EDT 2009
[root@localhost ~]# amixer get -c 0 Speakers; date
Simple mixer control 'Speakers',0
   Capabilities: pvolume pswitch
   Playback channels: Front Left - Front Right
   Limits: Playback 0 - 127
   Mono:
   Front Left: Playback 100 [79%] [-7.50dB] [off]
   Front Right: Playback 100 [79%] [-7.50dB] [off]
Thu May 14 16:21:01 EDT 2009
[root@localhost ~]#
