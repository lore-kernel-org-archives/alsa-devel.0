From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001821]: snd_rawmidi_read is blocking for "virtual" midi, even with SND_RAWMIDI_NONBLOCK flag
Date: Sun, 5 Feb 2006 15:47:35 +0100
Message-ID: <a19e1ff32cf9964715b4cde612c1fa0e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2375D1B4
	for <alsa-devel@alsa-project.org>; Sun,  5 Feb 2006 15:47:36 +0100 (MET)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1821> 
======================================================================
Reported By:                mkp
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1821
Category:                   rawmidi - raw MIDI interface
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             02-05-2006 15:47 CET
Last Modified:              02-05-2006 15:47 CET
======================================================================
Summary:                    snd_rawmidi_read is blocking for "virtual" midi,
even with SND_RAWMIDI_NONBLOCK flag
Description: 
when opening rawmidi device with 
snd_rawmidi_open(&handler, NULL, "virtual", SND_RAWMIDI_NONBLOCK);
snd_rawmidi_read() is blocking, while according to the documentation it
should return -EAGAIN.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-05-06 15:47 mkp            New Issue                                    
02-05-06 15:47 mkp            File Added: rawmidi.c                        
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
