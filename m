From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000589]: ICH5 S/PDIF audio drops out occasionally
Date: Wed, 24 Nov 2004 17:55:21 +0100
Message-ID: <fc69bccf0240a2c1f08cafb83e7c236d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id F3D782E3
	for <alsa-devel@alsa-project.org>; Wed, 24 Nov 2004 17:55:21 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=589> 
======================================================================
Reported By:                squarooticus
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   589
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Debian Unstable (sid)
Kernel Version:             2.6.7
======================================================================
Date Submitted:             10-21-2004 02:42 CEST
Last Modified:              11-24-2004 17:55 CET
======================================================================
Summary:                    ICH5 S/PDIF audio drops out occasionally
Description: 
I'm using the on-board audio of my Abit IC7-MAX3 ("Intel Corp. 82801EB/ER
(ICH5/ICH5R) AC'97 Audio Controller (rev 02)") with ALSA driver
snd_intel8x0 for my home theater setup.  In every application I've tried,
which includes mythtv, xine, and ogg123, through both native alsa and OSS
emulation, the audio output from the S/PDIF port drops out for a second
every so often---maybe once a minute, or every few minutes; it's not
periodic.

I don't know whether analog output also drops out, since I don't have
analog output hooked up or enabled.

This is with the CVS build as of October 19.  My asound.conf is:

pcm.krose-dmix {
  type dmix
  ipc_key 3516
  ipc_key_add_uid yes
  slave {
        pcm "hw:0,4"
        period_time 0
        period_size 4096
        #buffer_size 16384
        buffer_size 131072
        period_time 84000
        buffer_time 340000
        rate 48000
        channels 2
  }
  bindings.0 0
  bindings.1 1
}

pcm.dsp0 {
  type plug
  slave.pcm "krose-dmix"
}

ctl.mixer0 {
 type hw
 card 0
}

pcm.!default {
 type plug
 slave.pcm "krose-dmix"
}

I can't find any options to compile in debug logging: I'm not really sure
what the cause of the drop out is, e.g., buffer underrun, PCI contention,
etc.  I'm happy to spend time to try to debug this, but I need a starting
point.

Of course, it'd also be great to know if anyone has ever seen this kind of
behavior before.  I don't believe the SPD/IF port is turning itself off
because the receiver doesn't blip, which normally it would if the input
were to disappear temporarily.

The CPU is a 3.2G P4 with hyperthreading turned on.  I never see the CPU
usage go above 50%.

Interestingly, I see similar behavior on my dual Opteron machine with an
AMD-8111 audio controller using the same driver (snd_intel8x0).  I never
had this problem with the emu10k1 driver when I was using SB Lives, but I
have run into PCI slot limitations in my HTPC, so I have to use mobo
audio.

Suggestions?
======================================================================

----------------------------------------------------------------------
 squarooticus - 11-24-04 16:33 
----------------------------------------------------------------------
So, when I do this, I don't actually see xruns in dmesg or
/var/log/messages for the behavior I'm referring to in this bug.  (I see
them at other times, but that's a different issue.)  So either my hardware
is screwed up and is occasionally dropping the toslink signal, or there's
some kind of reset going on in the driver or firmware that's not being
reported.  Is there anything I can do short of replacing my motherboard?

----------------------------------------------------------------------
 squarooticus - 11-24-04 17:55 
----------------------------------------------------------------------
I've been trolling around the abit forums, and I found this:

http://forum.abit-usa.com/showthread.php?s=&threadid=37896&highlight=ic7max3+sound+cuts+out

There are several other posts indicating similar problems.  What do you
make of this?  Is my motherboard just b0rk3d?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-21-04 02:42 squarooticus   New Issue                                    
10-21-04 02:42 squarooticus   Distribution              => Debian Unstable (sid)
10-21-04 02:42 squarooticus   Kernel Version            => 2.6.7           
10-21-04 23:40 squarooticus   Issue Monitored: squarooticus                    
10-27-04 16:54 squarooticus   Note Added: 0002275                          
11-10-04 12:26 tiwai          Note Added: 0002367                          
11-12-04 06:23 squarooticus   Note Added: 0002392                          
11-15-04 20:24 squarooticus   Note Added: 0002419                          
11-16-04 02:50 squarooticus   Note Added: 0002423                          
11-16-04 05:14 squarooticus   Note Added: 0002424                          
11-18-04 17:51 tiwai          Note Added: 0002452                          
11-24-04 16:33 squarooticus   Note Added: 0002571                          
11-24-04 17:55 squarooticus   Note Added: 0002575                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
