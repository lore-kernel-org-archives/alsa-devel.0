From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001821]: snd_rawmidi_read is blocking for "virtual" midi, even with SND_RAWMIDI_NONBLOCK flag
Date: Sun, 5 Feb 2006 16:37:23 +0100
Message-ID: <c79a98031272b078c9f88273f1aa4898@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 276811C1
	for <alsa-devel@alsa-project.org>; Sun,  5 Feb 2006 16:37:24 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1821> 
======================================================================
Reported By:                mkp
Assigned To:                perex
======================================================================
Project:                    ALSA - lib
Issue ID:                   1821
Category:                   rawmidi - raw MIDI interface
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             02-05-2006 15:47 CET
Last Modified:              02-05-2006 16:37 CET
======================================================================
Summary:                    snd_rawmidi_read is blocking for "virtual" midi,
even with SND_RAWMIDI_NONBLOCK flag
Description: 
when opening rawmidi device with 
snd_rawmidi_open(&handler, NULL, "virtual", SND_RAWMIDI_NONBLOCK);
snd_rawmidi_read() is blocking, while according to the documentation it
should return -EAGAIN.
======================================================================

----------------------------------------------------------------------
 mkp - 02-05-06 16:17 
----------------------------------------------------------------------
same thing with 1.0.11rc3

----------------------------------------------------------------------
 perex - 02-05-06 16:37 
----------------------------------------------------------------------
Thanks. I've fixed this problem in CVS. You can find a patch in
bugfix.patch file.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-05-06 15:47 mkp            New Issue                                    
02-05-06 15:47 mkp            File Added: rawmidi.c                        
02-05-06 15:52 perex          Note Added: 0007935                          
02-05-06 16:17 mkp            Note Added: 0007936                          
02-05-06 16:36 perex          File Added: bugfix.patch                     
02-05-06 16:37 perex          Status                   new => resolved     
02-05-06 16:37 perex          Resolution               open => fixed       
02-05-06 16:37 perex          Assigned To               => perex           
02-05-06 16:37 perex          Note Added: 0007938                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
