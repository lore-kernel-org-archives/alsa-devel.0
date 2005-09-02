From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001375]: amixer cannot find the pcm simple control
Date: Fri, 2 Sep 2005 19:54:27 +0200
Message-ID: <ad07f4de887413dafb4ec778fccfa583@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A5D8E168
	for <alsa-devel@alsa-project.org>; Fri,  2 Sep 2005 19:54:27 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1375> 
======================================================================
Reported By:                pearma
Assigned To:                tiwai
======================================================================
Project:                    ALSA - utils
Issue ID:                   1375
Category:                   amixer
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             08-29-2005 03:32 CEST
Last Modified:              09-02-2005 19:54 CEST
======================================================================
Summary:                    amixer cannot find the pcm simple control
Description: 
my sound card is detected as snd_ens1731.
it works find under FC3,but have no sound under FC4.
the amixer just cannot find the pcm simple control of it.
and i believe this caused my soundcard failed to output any sound.
======================================================================

----------------------------------------------------------------------
 tiwai - 09-02-05 19:54 
----------------------------------------------------------------------
Fixed in the recent version.  Try 1.0.10rc1.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-29-05 03:32 pearma         New Issue                                    
09-02-05 19:54 tiwai          Status                   new => resolved     
09-02-05 19:54 tiwai          Resolution               open => fixed       
09-02-05 19:54 tiwai          Assigned To               => tiwai           
09-02-05 19:54 tiwai          Note Added: 0006019                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
