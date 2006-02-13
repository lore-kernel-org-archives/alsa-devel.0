From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001725]: SB Audigy SE Not Working with Quake 4, Doom 3
Date: Mon, 13 Feb 2006 19:58:26 +0100
Message-ID: <cd5c09735272a3f5afccf820e543ff5d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BF6CD196
	for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2006 19:58:26 +0100 (MET)
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


The following issue has been set as DUPLICATE OF issue 0001188.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1725> 
======================================================================
Reported By:                malk271
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1725
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     acknowledged
Distribution:               Fedora Core 3
Kernel Version:             2.6.12-1.1381_FC3
======================================================================
Date Submitted:             01-08-2006 17:35 CET
Last Modified:              02-13-2006 19:58 CET
======================================================================
Summary:                    SB Audigy SE Not Working with Quake 4, Doom 3
Description: 
On FC3, I have compiled and installed alsa-driver-1.0.11rc2 and
alsa-lib-1.0.11rc2 in order to be able to use a recently purchased Audigy
SE.

Regular playback is working (speaker-test and aplay both work, as does
Amarok with Alsa selected for playback). Skype playback does work, but is
horribly choppy (unusable really), unlike my other card, an old SB Live!
1024 player.

However, the Audigy SE does not work with Quake 4 and Doom 3. There is
some output, but it is just a collection of random sounds. I have tried
both stereo and 5.1 configurations. Also, output must be sent through the
plug plugin or the games complain about a sampling mismatch (48KHz found
but 44.1KHz required).

======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0001188 quake3 crashes, capture not working
======================================================================

----------------------------------------------------------------------
 rlrevell - 01-08-06 21:48 
----------------------------------------------------------------------
Can you reproduce the problem with an app we have the source code to?

----------------------------------------------------------------------
 rlrevell - 01-08-06 21:49 
----------------------------------------------------------------------
"Also, output must be sent through the plug plugin or the games complain
about a sampling mismatch (48KHz found but 44.1KHz required)."

This is not a bug - the card can only do 48KHz in hardware.  Apps should
use the "default" device, not "hw:x,x".

----------------------------------------------------------------------
 malk271 - 01-09-06 09:47 
----------------------------------------------------------------------
> This is not a bug - the card can only do 48KHz in hardware. Apps
> should use the "default" device, not "hw:x,x".

There are two cards in my computer. Using the "default" device selects
card 0, not card 1 (the card I am trying to use). Also, the Q4 / Doom 3
FAQ indicate that this  should not happen any more -- I realise that this
is not necessarily an Alsa issue.

----------------------------------------------------------------------
 malk271 - 01-09-06 09:48 
----------------------------------------------------------------------
> Can you reproduce the problem with an app we have the source code to?

I don't know. I guess my point is that the card is not working with the
apps I am using.

----------------------------------------------------------------------
 jcdutton - 01-09-06 11:04 
----------------------------------------------------------------------
This is a known problem. Any snd-ca0106 based sound card will not work with
Doom3 or Quake 4.
Support for this requires a sound card buffer abstraction layer to be
added to alsa-lib. I.e. hardware buffer size different from application
buffer size.

This feature in alsa-lib is unlikely to be implemented any time soon.

----------------------------------------------------------------------
 jcdutton - 01-09-06 11:05 
----------------------------------------------------------------------
Acknowledged, but unlikely to be fixed any time soon.

----------------------------------------------------------------------
 rlrevell - 01-09-06 14:41 
----------------------------------------------------------------------
So does the design of this hardware exposes a limitation in the design of
ALSA, or would you say the hardware is just broken?  Are you saying it
can't even generate interrupts at the period boundary at 44.1 KHz?  Does
the hardware design depend on some Windows feature (like sub HZ timers)?

I guess there were no soundcards with a similar design when ALSA was
written?

----------------------------------------------------------------------
 avuton - 02-13-06 19:43 
----------------------------------------------------------------------
Is this also why programs cannot mmap /dev/dsp for oss emulation?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-08-06 17:35 malk271        New Issue                                    
01-08-06 17:35 malk271        Distribution              => Fedora Core 3   
01-08-06 17:35 malk271        Kernel Version            => 2.6.12-1.1381_FC3
01-08-06 21:48 rlrevell       Note Added: 0007527                          
01-08-06 21:49 rlrevell       Note Added: 0007528                          
01-09-06 09:47 malk271        Note Added: 0007532                          
01-09-06 09:48 malk271        Note Added: 0007533                          
01-09-06 11:04 jcdutton       Note Added: 0007534                          
01-09-06 11:05 jcdutton       Note Added: 0007535                          
01-09-06 11:05 jcdutton       Status                   assigned => acknowledged
01-09-06 14:41 rlrevell       Note Added: 0007536                          
01-31-06 10:56 avuton         Issue Monitored: avuton                      
02-13-06 19:43 avuton         Note Added: 0008060                          
02-13-06 19:58 rlrevell       Relationship added       duplicate of 0001188
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
