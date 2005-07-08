From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000243]: the duration option does not work in arecord and aplay too
Date: Fri, 8 Jul 2005 10:34:34 +0200
Message-ID: <d67beb4e98a0c02c2260ff5046aadac3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3ACAE17A
	for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2005 10:34:34 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=243> 
======================================================================
Reported By:                Nibble
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   243
Category:                   aplay/arecord
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             04-28-2004 01:31 CEST
Last Modified:              07-08-2005 10:34 CEST
======================================================================
Summary:                    the duration option does not work in arecord and
aplay too
Description: 
when using that option: -d 1 or any other number for seconds arecord and
aplay don't stop. The only way to stop recording is Ctrl+C.
======================================================================

----------------------------------------------------------------------
 jdthood - 09-24-04 05:41 
----------------------------------------------------------------------
Works for me

$ arecord -d5 foo.wav
Recording WAVE 'foo.wav' : Unsigned 8 bit, Rate 8000 Hz, Mono
$ arecord --version
arecord: version 1.0.6 by Jaroslav Kysela <perex@suse.cz>

----------------------------------------------------------------------
 jdthood - 03-20-05 13:27 
----------------------------------------------------------------------
This can be closed.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-28-04 01:31 Nibble         New Issue                                    
09-24-04 05:41 jdthood        Note Added: 0001855                          
03-20-05 13:27 jdthood        Note Added: 0004083                          
03-22-05 09:44 jdthood        Status                   new => resolved     
07-08-05 10:34 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
