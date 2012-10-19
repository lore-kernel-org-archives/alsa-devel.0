From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: softvol master has preference over virtual master in
	amixer
Date: Fri, 19 Oct 2012 11:15:29 +0800
Message-ID: <CAN8cciZJpZQHsz1oYZZ8sVHRKo5hxdNBuKyDZsJPtho9V3ifNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com
 [209.85.216.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 14A40261732
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2012 05:15:30 +0200 (CEST)
Received: by mail-qc0-f179.google.com with SMTP id b14so13275qcs.38
 for <alsa-devel@alsa-project.org>; Thu, 18 Oct 2012 20:15:30 -0700 (PDT)
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
Cc: pulseaudio-discuss@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

does softvol plugin "master" has any preference over vmaster in amixer ?

http://www.alsa-project.org/db/?f=44b26f5cd37f33bfef2871ff1fd250301bdb5364

control.32 {
iface MIXER
name 'Master Playback Volume'
value 64
comment {
access 'read write'
type INTEGER
count 1
range '0 - 64'
dbmin -6400
dbmax 0
dbvalue.0 0
}
}

control.42 {
iface MIXER
name Master
value.0 255
value.1 255
comment {
access 'read write user'
type INTEGER
count 2
range '0 - 255'
tlv '0000000100000008ffffec1400000014'
dbmin -5100
dbmax 0
dbvalue.0 0
dbvalue.1 0
}

Card hw:0 'Intel'/'HDA Intel at 0xfeaf8000 irq 43'
  Mixer name: 'Realtek ALC887-VD'
  Components: 'HDA:10ec0887,10438445,00100302'
  Controls      : 42
  Simple ctrls  : 22
Simple mixer control 'Master',0
  Capabilities: pvolume pswitch pswitch-joined penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 255 [100%] [191.00dB] [on]
  Front Right: Playback 255 [100%] [191.00dB] [on]
Simple mixer control 'Headphone',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 64
  Mono:
  Front Left: Playback 64 [100%] [0.00dB] [on]
  Front Right: Playback 64 [100%] [0.00dB] [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 255 [100%] [0.00dB]
  Front Right: Playback 255 [100%] [0.00dB]

https://launchpadlibrarian.net/119782219/Symptom_PulseAudioLog.txt

Oct 15 10:49:11 xaser pulseaudio[1601]: [pulseaudio] alsa-util.c: Unable to
load mixer: Invalid argument
Oct 15 10:49:11 xaser pulseaudio[1601]: [pulseaudio] alsa-util.c: Unable to
load mixer: Invalid argument
Oct 15 10:49:11 xaser pulseaudio[1601]: [pulseaudio] alsa-util.c: Unable to
load mixer: Invalid argument
Oct 15 10:49:11 xaser pulseaudio[1601]: [pulseaudio] alsa-util.c: Unable to
load mixer: Invalid argument
Oct 15 10:49:12 xaser pulseaudio[1601]: [pulseaudio] alsa-util.c: Unable to
load mixer: Invalid argument
Oct 15 10:49:12 xaser pulseaudio[1601]: [pulseaudio] alsa-util.c: Unable to
load mixer: Invalid argument
Oct 15 10:49:12 xaser pulseaudio[1601]: [pulseaudio] alsa-util.c: Unable to
load mixer: Invalid argument
Oct 15 10:49:12 xaser pulseaudio[1601]: [pulseaudio] alsa-util.c: Unable to
load mixer: Invalid argument
Oct 15 10:49:12 xaser pulseaudio[1601]: [pulseaudio] alsa-util.c: Unable to
load mixer: Invalid argument
Oct 15 10:49:12 xaser pulseaudio[1601]: [pulseaudio] alsa-util.c: Unable to
load mixer: Invalid argument
