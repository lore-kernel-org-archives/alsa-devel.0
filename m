From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001785]: ice1712 driver -cs8427 SPDIF chip not always set up correctly
Date: Wed, 1 Feb 2006 23:28:21 +0100
Message-ID: <96b5960e6c22647623ad9638a72d260f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6A9AD19D
	for <alsa-devel@alsa-project.org>; Wed,  1 Feb 2006 23:28:21 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1785> 
======================================================================
Reported By:                alanmann
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1785
Category:                   PCI - ice1712
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             01-26-2006 23:27 CET
Last Modified:              02-01-2006 23:28 CET
======================================================================
Summary:                    ice1712 driver -cs8427 SPDIF chip not always set up
correctly
Description: 
There are regular occasions when SPDIF IN operates spuriously, on Terratec
DMX6fire (& presumably others, like delta1010LT?).

At start-up or when changing between non-spdif master clock settings,
Digital Input stream has incorrect signal present, real enough to be
recorded with audacity.  The cause is errors in writing to the cs8427
spdif chip.  Will add notes with my findings.
======================================================================

----------------------------------------------------------------------
 nostar - 01-27-06 22:15 
----------------------------------------------------------------------
I will add my cards behavior here, since I have more to describe that I
didn't add to the list. First, the descripion I posted:

When trying to use SPDIF In as the clock source, I have to keep toggling
between any Int clock setting and SPDIF IN over and over, getting usually
static or barely audible audio (I've got audio coming from my digital
mixer into the SPDIF In during this procedure so I know when I get the
right sync), untill eventually i'll hit it dead on and it will be synced
perfectly (or very close, with an occasional pop). This behavior is the
same with and without your test removed from the driver code.  I wonder if
you might try doing this too, toggling back n forth between any Int clock
setting and SPDIF In (without jack running of course so the changes will
actually take), using an external SPDIF signal coming in and spdif out
going to somewhere audible (directly to digital monitors, receiver, etc)
to make sure your problem is really fixed?  Of course you can only do this
if you have the means available.

Also, In Envy24control mixer, I see (and hear) no audio on the level
meters for SPDIF In if I am set on any of the internal clock settings. 
Once I set the master clock source to SPDIF In, then the signals appear on
the level meters, and the noise/static is heard, at which time I start the
toggle procedure described above untill I get an audio.

----------------------------------------------------------------------
 alanmann - 02-01-06 23:28 
----------------------------------------------------------------------
Good progress

1. re out.txt -it does the job, but when routine is called at
initialisation is_spdif_master(ice) does not return the correct value (is
always 0).  It is OK though as later on in startup it is repeated with the
correct value.  As an alternative, to avoid ambiguity at startup, consider
'bug1785-spdif-init-1.0.11rc2.diff, which has an extra parameter in the
new function, and a different name.  Neither of these patches applies to
1.0.10 & earlier due to ice1712_t changes (I have an altered patch
available).

2. Neither of the above makes any difference to the end result without
changes to cs8427.c snd_cs8427_reset, since in L319 it sets the AES3 bit
(always) sourcing the clock from AES3 receiver, during internal clock freq
changes.  The line may be unneccesary altogether, but
bug1785-cs8427-reset-AES3-changes.diff tests the bit at first and sets it
back at the end.

The combination of these 2  bug1785 patches resolves this problem AFAICT.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-26-06 23:27 alanmann       New Issue                                    
01-26-06 23:41 alanmann       Note Added: 0007795                          
01-26-06 23:50 alanmann       Note Edited: 0007795                         
01-27-06 10:10 alanmann       Note Added: 0007797                          
01-27-06 14:30 perex          File Added: out.txt                          
01-27-06 14:44 perex          File Deleted: out.txt                        
01-27-06 14:44 perex          File Added: out.txt                          
01-27-06 14:45 perex          Note Added: 0007801                          
01-27-06 14:46 perex          Note Edited: 0007801                         
01-27-06 21:48 nostar         Note Added: 0007806                          
01-27-06 22:00 nostar         Issue Monitored: nostar                      
01-27-06 22:15 nostar         Note Added: 0007807                          
02-01-06 23:28 alanmann       Note Added: 0007864                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
