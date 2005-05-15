From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001110]: Some switch is missing
Date: Sun, 15 May 2005 16:13:17 +0200
Message-ID: <2111b78515a47a1ff72e7a429cd5bf90@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 13477207
	for <alsa-devel@alsa-project.org>; Sun, 15 May 2005 16:13:17 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1110> 
======================================================================
Reported By:                technik
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1110
Category:                   PCI - es1938
Reproducibility:            always
Severity:                   tweak
Priority:                   normal
Status:                     new
Distribution:               mandriva , suse 9.2
Kernel Version:             2.6
======================================================================
Date Submitted:             05-14-2005 10:40 CEST
Last Modified:              05-15-2005 16:13 CEST
======================================================================
Summary:                    Some switch is missing
Description: 
When you open mixer(kmix, alsamixer or other) you can't muteing micropone,
line and other record source. It's a big problem when you using internet
telephone like skype. When you speak to mic you hear your voice an your
friend, and you can't make lauder becouse mic and speker interference.
======================================================================

----------------------------------------------------------------------
 technik - 05-15-05 16:07 
----------------------------------------------------------------------
When J set "mic volume" to 0 level the level of "record source mic" is set
to 0 too. In "kmix" potentiometer for playback and record is only one and
this is a problem.

----------------------------------------------------------------------
 tiwai - 05-15-05 16:13 
----------------------------------------------------------------------
Then it's a bug of kmix.  ES1938 has separate "Mic Playback Volume" and
"Mic Capture Volume".  Try alsamixer, for example.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-14-05 10:40 technik        New Issue                                    
05-14-05 10:40 technik        Distribution              => mandriva , suse 9.2
05-14-05 10:40 technik        Kernel Version            => 2.6             
05-15-05 15:38 tiwai          Note Added: 0004660                          
05-15-05 16:07 technik        Note Added: 0004664                          
05-15-05 16:13 tiwai          Note Added: 0004665                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
