From: Steven Edwards <cureadvocate@gmail.com>
Subject: CA0106 mic not working, logs attached
Date: Wed, 25 Mar 2009 20:52:54 -0400
Message-ID: <ab44b6810903251752g29f1bd1bp8fb338e505c18915@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.246])
	by alsa0.perex.cz (Postfix) with ESMTP id 61C45103856
	for <alsa-devel@alsa-project.org>; Thu, 26 Mar 2009 01:53:13 +0100 (CET)
Received: by an-out-0708.google.com with SMTP id d40so249856and.2
	for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2009 17:53:12 -0700 (PDT)
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

Dear ALSA,

I installed Ubuntu 8.10 yesterday, updating ALSA to 1.0.19 to mute my
speakers when the headset is plugged in.  I unchecked the mute below the
Microphone slider, maximized the volume, clicked Close.  Sound Recorder
detected nothing, so I returned to Volume Control->Recording and noticed
that Microphone stayed checked.  Repeat x3, same results.

I then tried the PulseAudio setup outlined by markbuntu at:

http://ubuntuforums.org/showthread.php?t=843012

That failed, so I tried soundrecorder's ALSA upgrade script at:

http://ubuntuforums.org/showthread.php?t=1046137

This (sudo bash ./AlsaUpgrade-1.0.x-rev-1.16.sh -di) killed all sound and
aplay -l detected no sound cards.  Restore (sudo bash ./
AlsaUpgrade-1.0.x-rev-1.16.sh -r) didn't restore my speakers, so I ran
alsa-info.sh:

http://www.alsa-project.org/db/?f=5a408b2a5328279dbac25a54ce34f6ae707e7cf6

Next, retrying the update script didn't restore my speakers either.
alsa-info.sh:

http://www.alsa-project.org/db/?f=bd33dc839806cd151e21bdfe4c32bf02a0a9aa57

Finally, (sudo ./configure && sudo make && sudo make install) restored my
speakers' ability to output sound, but the mic still isn't recording sound.
The original problem--Volume Recorder not accepting/remembering/allowing my
unmuted Microphone--remains.  alsa-info.sh:

http://www.alsa-project.org/db/?f=5e4bcbc453960ece52e3bf21fb475c768b50f979

I don't know where to go next.  I hope the reports help and that you will be
able to help me.

Best,

Steven
