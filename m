From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000243]: the duration option does not work in arecord and aplay too
Date: Sun, 20 Mar 2005 13:27:13 +0100
Message-ID: <0b35db31dceca183631e93828bff7814@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 80C43250
	for <alsa-devel@alsa-project.org>; Sun, 20 Mar 2005 13:27:13 +0100 (MET)
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
Status:                     new
======================================================================
Date Submitted:             04-28-2004 01:31 CEST
Last Modified:              03-20-2005 13:27 CET
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
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
