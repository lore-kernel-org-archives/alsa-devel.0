From: Ludovico Cavedon <ludovico.cavedon@gmail.com>
Subject: Getting the correct capture mixer
Date: Wed, 29 Apr 2009 00:08:23 -0700
Message-ID: <49F7FCE7.3050803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.243])
	by alsa0.perex.cz (Postfix) with ESMTP id BAB86244F2
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Apr 2009 09:08:27 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id k29so695153rvb.32
	for <alsa-devel@alsa-project.org>; Wed, 29 Apr 2009 00:08:26 -0700 (PDT)
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
I am working on fixing some audio related bugs of a VoIP application
(qutecom) which, like most VoIP applications, allows the user to change
the playback and recording volume.

For playback volume I am opening the "Master" mixer element.

However I am not able to figure out how the application should get the
correct mixer for playback. Is there any rule?
For example, my sound card has two capture volumes, one "Int Mic" and
one "Ext Mic". I guess I should choose on the basis of what is the
user-selected mic. In fact there are also two mutually exclusive
switches "IntMic" and "ExtMic". But how should the application
understand that?

Here part of the output of amixer, my sound card is
"Intel [HDA Intel], device 0: CONEXANT Analog [CONEXANT Analog]"
----------------------------
Simple mixer control 'Ext Mic',0
  Capabilities: pvolume cvolume pswitch cswitch
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 20 Capture 0 - 23
  Front Left: Playback 0 [0%] [-30.00dB] [off] Capture 0 [0%] [0.00dB] [off]
  Front Right: Playback 0 [0%] [-30.00dB] [off] Capture 0 [0%] [0.00dB]
[off]
Simple mixer control 'ExtMic',0
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Mono
  Mono: Capture [off]
Simple mixer control 'Int Mic',0
  Capabilities: pvolume cvolume pswitch cswitch
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 20 Capture 0 - 23
  Front Left: Playback 0 [0%] [-30.00dB] [off] Capture 0 [0%] [0.00dB] [off]
  Front Right: Playback 0 [0%] [-30.00dB] [off] Capture 0 [0%] [0.00dB]
[off]
Simple mixer control 'IntMic',0
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Mono
  Mono: Capture [on]
------------------------

As an aside, it looks like that the capture volume has no effect, as
well all as the cswitches and pswitches of "Int Mic" and "Ext Mic".

Thanks,
Ludovico
