From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000331]: possible incompatibility with cpu-freq
Date: Sat, 9 Apr 2005 17:29:10 +0200
Message-ID: <011beab82a2f5aa0519dc9c090fe7a24@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 9D387220
	for <alsa-devel@alsa-project.org>; Sat,  9 Apr 2005 17:29:10 +0200 (MEST)
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


The following issue has been set as RELATED TO issue 0000535.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=331> 
======================================================================
Reported By:                souvarine
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   331
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian testing
Kernel Version:             2.6.4 - 2.6.6
======================================================================
Date Submitted:             06-10-2004 15:42 CEST
Last Modified:              04-09-2005 17:29 CEST
======================================================================
Summary:                    possible incompatibility with cpu-freq
Description: 
On my Sony VAIO PCG NV105 with kernel 2.6.4 and 2.6.6 (I have not tried
2.6.5) the sound is horrible when the systeme is not very bussy. When the
systeme is on full load the sound became clean.
After a serie of kernel recompil I found that when I disable cpu-freq I
don't have this problem any more.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000535 via82xx: &quot;codec 0 is not valid...&...
======================================================================

----------------------------------------------------------------------
 jdthood - 04-07-05 20:55 
----------------------------------------------------------------------
Do you think that the ALSA driver should itself disable cpu-freq?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-10-04 15:42 souvarine      New Issue                                    
06-10-04 15:42 souvarine      Distribution              => Debian testing  
06-10-04 15:42 souvarine      Kernel Version            => 2.6.4 - 2.6.6   
09-07-04 16:41 ichino         Issue Monitored: ichino                      
09-07-04 16:44 ichino         Issue End Monitor: ichino                    
04-07-05 20:55 jdthood        Note Added: 0004363                          
04-09-05 17:29 jdthood        Relationship added       related to 0000535  
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
