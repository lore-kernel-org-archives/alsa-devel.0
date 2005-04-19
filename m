From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001061]: can't test audio with aplay using 16-bit signed LE format; 1.0.7 however works
Date: Tue, 19 Apr 2005 18:45:56 +0200
Message-ID: <163c72f7299fbe631c6506fe8c5d8686@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 464B720F
	for <alsa-devel@alsa-project.org>; Tue, 19 Apr 2005 18:45:57 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1061> 
======================================================================
Reported By:                ukr
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1061
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 3
Kernel Version:             Linux 2.6.11
======================================================================
Date Submitted:             04-18-2005 03:24 CEST
Last Modified:              04-19-2005 18:45 CEST
======================================================================
Summary:                    can't test audio with aplay using 16-bit signed LE
format; 1.0.7 however works
Description: 
I usually test my speakers with aplay using

aplay -t raw -f S16_LE -c 6 -r 48000 -Dsurround51

With 1.0.8, when I do this, nothing goes to any of the speakers. However,
when I revert to alsa-driver 1.0.7, it works correctly. I have Intel ICH5
audio with Realtek ALC650F chip with 5.1 channel audio.

Thanks,
            Uday.
======================================================================

----------------------------------------------------------------------
 tiwai - 04-19-05 17:58 
----------------------------------------------------------------------
OK, then could you attach /etc/asound.state and
/proc/asound/card0/codec97#0/ac97* files on 1.0.9rc2 for debugging?

For testing, use speaker-test to eliminate unknown factors.

Rear-right channel problem was fixed recently.  It should be OK on
1.0.9rc2.

The noise on 1.0.9rc2 looks strange.  It might be due to dmix plugin, but
still this doesn't explain what really happens there.  Anyway, always use
the same ALSA driver version with the alsa-lib.

----------------------------------------------------------------------
 ukr - 04-19-05 18:45 
----------------------------------------------------------------------
Okay, I now have 1.0.9rc2 versions of both alsa-driver and alsa-lib. I
found that the custom output devices in my .asoundrc are what that are
giving strange noises with 1.0.9rc2 but not with older versions. Here is
my .asoundrc:

pcm.intel8x0 {
    type hw
    card 0
}

ctl.intel8x0 {
    type hw
    card 0
}

pcm.ch51dup {
         slave.pcm surround51
         slave.channels 6
         type route
         ttable.0.0 1
         ttable.1.1 1
         ttable.0.2 0.5
         ttable.1.2 0.5
         ttable.0.3 0.5
         ttable.1.3 0.5
         ttable.0.4 1
         ttable.1.5 1
}

pcm.ch40dup {
         type route
         slave.pcm surround41
         slave.channels 4
         ttable.0.0 1
         ttable.1.1 1
         ttable.0.2 0.5
         ttable.1.2 0.5
         ttable.0.3 1
         ttable.1.4 1
}

Both ch51dup and surround51 give strange noises with xmms; however, when I
changed my output device to "hw:0,0", I get correct output on the two
channels. I have uploaded /etc/asound.state and
/proc/asound/card0/codec97#0/ac97* files (all three concatenated) after I
had set to surround51 and when I was getting that strange noise. 

Also when I tested with speaker-test the following way:

speaker-test -D surround51 -c 6 -s <number>

I found that Rear Left and Rear Right were interchanged with Center and
LFE respectively i.e. for 5 and 6, output was on rear left and right, but
speaker-test was showing them as center and lfe respectively. I am using
1.0.9rc2 version of alsa-utils too.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-18-05 03:24 ukr            New Issue                                    
04-18-05 03:24 ukr            Distribution              => Fedora Core 3   
04-18-05 03:24 ukr            Kernel Version            => Linux 2.6.11    
04-19-05 02:30 ukr            Issue Monitored: ukr                         
04-19-05 17:39 tiwai          Note Added: 0004524                          
04-19-05 17:52 ukr            Note Added: 0004530                          
04-19-05 17:58 tiwai          Note Added: 0004531                          
04-19-05 18:45 ukr            Note Added: 0004538                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
