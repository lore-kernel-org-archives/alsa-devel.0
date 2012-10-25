From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: 191dB Master Playback Volume
Date: Thu, 25 Oct 2012 16:14:28 +0800
Message-ID: <CAN8cciY3MO9oj2T266RW=hkgUp+A9EdQjQZorOByzqJf0FPuyg@mail.gmail.com>
References: <CAN8cciYQxEeyVHvS_WfQAJ1tDqkn0RgFY4RcC2AKqb5LgJgLow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f44.google.com (mail-qa0-f44.google.com
 [209.85.216.44])
 by alsa0.perex.cz (Postfix) with ESMTP id A120F265347
 for <alsa-devel@alsa-project.org>; Thu, 25 Oct 2012 10:14:29 +0200 (CEST)
Received: by mail-qa0-f44.google.com with SMTP id 25so3722754qao.17
 for <alsa-devel@alsa-project.org>; Thu, 25 Oct 2012 01:14:29 -0700 (PDT)
In-Reply-To: <CAN8cciYQxEeyVHvS_WfQAJ1tDqkn0RgFY4RcC2AKqb5LgJgLow@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: 1066814@bugs.launchpad.net, alsa-devel@alsa-project.org, pulseaudio-discuss@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

>> Something wild is merged in his system.  It has a wrong "Master"
>> control without suffix.  Also a strange "Pre-Amp" control is found
>> there, too.  The string doesn't fix in kernel or alsa-lib codes at
>> all.

> The softvol master volume must have been from a try > with asound.rc
config, but it didn't help.
> Here is updated alsa-info script without asound.rc:
> http://www.alsa-project.org/db/?f=ab5362501881befcdaee94e44278820d43bf92f1

> Meanwhile, in order to test sound, I have tried
> severeal live distros including: Ubuntu/Lubuntu 12.10,
> Mint, Crunchbang and the result is the same: no
> sound or sound that is very low with a lot of noise.

> Tried to update alsa to 1.0.25 following this tutorial:
> http://ubuntuforums.org/showthread.php?t=1681577
> but that also failed, resulting with "no driver to compile".

> Don't know what else to try, and cannot believe that
> after more than 7 years with Linux now when I finally
> have completely Intel based computer the sound is
> making this much trouble.

it is not easy to remove the softvol since it is recreated by "alsactl
restore" and you still have those softvol controls and a 191dB Master
playback volume

there must be a bug in alsa lib when you have a stereo softvol master and a
mono virtual master playback volume

when both softvol without suffix "playback volume" ,
the capability of pre-amp is volume(global)  but master is pvolume

Amixer output
!!-------------

!!-------Mixer controls for card 0 [Intel]

Card hw:0 'Intel'/'HDA Intel at 0xfeaf8000 irq 43'
  Mixer name: 'Realtek ALC887-VD'
  Components: 'HDA:10ec0887,10438445,00100302'
  Controls      : 43
  Simple ctrls  : 22
Simple mixer control 'Master',0
  Capabilities: pvolume pswitch pswitch-joined penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 255 [100%] [191.00dB] [on]
  Front Right: Playback 255 [100%] [191.00dB] [on]

Simple mixer control 'Pre-Amp',0
  Capabilities: volume penum
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 5
  Front Left: 5 [100%]
  Front Right: 5 [100%]

control.32 {
comment.access 'read write'
comment.type INTEGER
comment.count 1
comment.range '0 - 64'
comment.dbmin -6400
comment.dbmax 0
iface MIXER
name 'Master Playback Volume'
value 64
}

control.40 {
comment.access 'read write user'
comment.type INTEGER
comment.count 2
comment.range '0 - 255'
comment.tlv '0000000100000008ffffec1400000014'
comment.dbmin -5100
comment.dbmax 0
iface MIXER
name 'PCM Playback Volume'
value.0 255
value.1 255
}

control.42 {
comment.access 'read write user'
comment.type INTEGER
comment.count 2
comment.range '0 - 5'
comment.tlv '0000000100000008fffffe0c000001f4'
comment.dbmin -500
comment.dbmax 2000
iface MIXER
name Pre-Amp
value.0 5
value.1 5
}
control.43 {
comment.access 'read write user'
comment.type INTEGER
comment.count 2
comment.range '0 - 255'
comment.tlv '0000000100000008ffffec1400000014'
comment.dbmin -5100
comment.dbmax 0
iface MIXER
name Master
value.0 255
value.1 255
