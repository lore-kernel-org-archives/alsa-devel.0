From: rm.riches@jacob21819.net (Robert M. Riches Jr.)
Subject: only 1.00 dB of playback volume change
Date: Wed, 09 Jan 2019 20:44:31 -0800
Message-ID: <20190110044431.7ED6C1E2E25@one.localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-2.mxes.net (smtp-out-2.mxes.net [205.237.194.127])
 by alsa0.perex.cz (Postfix) with ESMTP id 056C8267445
 for <alsa-devel@alsa-project.org>; Thu, 10 Jan 2019 05:44:33 +0100 (CET)
Received: from Customer-MUA (mua.mxes.net [10.0.0.1])
 by smtp.mxes.net (Postfix) with ESMTPA id 2655627555
 for <alsa-devel@alsa-project.org>; Wed,  9 Jan 2019 23:44:32 -0500 (EST)
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
List-Id: alsa-devel@alsa-project.org

(I sent this first to alsa-user and was instructed to send it to
alsa-devel, as well.)

With a new OS installation on a pre-existing machine, some of the
USB audio devices now have only 1.00 dB of playback volume
adjustment, which of course is not enough to be terribly useful.

The affected USB devices show up as "Audio Advantage MicroII" in the
output of "aplay -L".  From LSB, they show up as these:

Bus 001 Device 004: ID 0d8c:0103 C-Media Electronics, Inc. CM102-A+/102S+ Audio Controller
Bus 001 Device 003: ID 0d8c:0103 C-Media Electronics, Inc. CM102-A+/102S+ Audio Controller

I just installed Devuan Ascii on the machine.  It's running kernel
4.9.0-8-amd64 and alsa-utils version 1.1.3-1.  Doing "amixer -c 1
contents" or "amixer -c 2 contents" shows this for playback volume:

numid=3,iface=MIXER,name='PCM Playback Volume'
  ; type=INTEGER,access=rw---R--,values=2,min=0,max=255,step=0
    : values=0,0
      | dBminmax-min=-1.00dB,max=0.00dB

and

numid=3,iface=MIXER,name='PCM Playback Volume'
  ; type=INTEGER,access=rw---R--,values=2,min=0,max=255,step=0
    : values=77,77
      | dBminmax-min=-1.00dB,max=0.00dB

It looks like I'm running kernel 4.9.0-8-amd64 and alsa-utils
version 1.1.3-1.

Using alsamixer to run the controls from end to end, I cannot
perceive any difference in volume level.

In contrast, the other device I use (either HDA Intel or HDA NVidia)
has around a 60dB range according to amixer, and running the control
in alsamixer from end to end has a huge range of gain.

Previously, the exact same hardware was running Debian 7/Wheezy and
then Slackware 14.2.  With both those operating systems, the USB
sound devices had a very adequate volume control range, certainly a
whole lot more than 1dB.

Being as the USB sound devices are the ones my wife uses, I'd be
extremely grateful if somebody could point me a to way (if one
exists) to a usefully greater range of volume control.  Any
suggestions?

Assuming this qualifies as a bug, what channel should I use to
report it so it can be queued to be fixed?

Thanks,

Robert
