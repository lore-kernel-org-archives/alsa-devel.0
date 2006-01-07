From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001722]: aplay deadlocks
Date: Sat, 7 Jan 2006 03:25:26 +0100
Message-ID: <f7dc648d899dd10d2932789ef2c311dd@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 84FB413A
	for <alsa-devel@alsa-project.org>; Sat,  7 Jan 2006 03:25:26 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1722> 
======================================================================
Reported By:                erador
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   1722
Category:                   aplay/arecord
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             01-07-2006 03:25 CET
Last Modified:              01-07-2006 03:25 CET
======================================================================
Summary:                    aplay deadlocks
Description: 
Installing the nVidia display driver worsens this issue. (Not sure why).
But with that running playing anything in any application in X, causes
ALSA to freeze, it cannot be unloaded, and processes cannot be killed. It
produces about 15 aplay instances, all of which are unkillable.

So I went back to the normal nv driver, sound works and things are
normal.

I was going to test out the surround40 profile, so I thought I'd play
something via aplay, it was a working mp3, I don't know if that's
supported or not? Either way it deadlocks alsa and generates lots of
deadlocked aplay instances.

I'm using the emu10k1 driver, and xorg.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-07-06 03:25 erador         New Issue                                    
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
