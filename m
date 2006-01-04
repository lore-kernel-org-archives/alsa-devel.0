From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001274]: alc655: low volume
Date: Wed, 4 Jan 2006 12:47:15 +0100
Message-ID: <0e650f1ceb358009f29c0342b7e1f464@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D7233184
	for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2006 12:47:15 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1274> 
======================================================================
Reported By:                vitja
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1274
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             07-22-2005 10:46 CEST
Last Modified:              01-04-2006 12:47 CET
======================================================================
Summary:                    alc655: low volume
Description: 
I have ATI IXP400 sound in my notebook. codec is realtek's alc655. The
problem is I couldn't hear anything from internal speaker. When I plug
earphones in I hear very-very low music signal, so driver actually works
but. By the way under xp with realtek's drivers thats all right.. Is there
a way to see dump of ac97's registers under xp? May be XP driver uses some
proprietary features of alc655?
======================================================================

----------------------------------------------------------------------
 UnrealX - 01-04-06 12:25 
----------------------------------------------------------------------
Well, it seems this bug is still unfixed.
I use alsa-driver 1.0.10 and I only get this very silent sound from
headphone out.
Temporary solution didn`t help me either, when I pasted it into bash
script and executed, regs file values became all ffff`s.
Same soundcard, ATI IXP 400, using arch linux 0.7.1 pre1, all modules
loaded, alsa core is working no-problemo.



----------------------------------------------------------------------
 vitja - 01-04-06 12:47 
----------------------------------------------------------------------
I can't reproduce this bug with 2.6.14 kernel, alsa version 1.0.10rc1,
sound works ot of the box.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-22-05 10:46 vitja          New Issue                                    
07-22-05 20:32 vitja          File Added: codec                            
07-24-05 22:19 vitja          Note Added: 0005560                          
07-29-05 18:01 tiwai          Note Added: 0005583                          
07-30-05 09:11 vitja          Note Added: 0005591                          
01-04-06 12:24 UnrealX        Note Added: 0007414                          
01-04-06 12:25 UnrealX        Note Edited: 0007414                         
01-04-06 12:47 vitja          Note Added: 0007415                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
