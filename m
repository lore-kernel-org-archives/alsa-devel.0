From: bugtrack@alsa-project.org
Subject: [ALSA - firmware 0000778]: xbox parameter sets AC97_SCAP_DETECT_BY_VENDOR wrongly
Date: Fri, 18 Mar 2005 11:33:06 +0100
Message-ID: <99886fa182bc91b2e2ff028fb9105057@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id F3B1D23B
	for <alsa-devel@alsa-project.org>; Fri, 18 Mar 2005 11:33:06 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=778> 
======================================================================
Reported By:                julian
Assigned To:                
======================================================================
Project:                    ALSA - firmware
Issue ID:                   778
Category:                   
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             01-02-2005 18:53 CET
Last Modified:              03-18-2005 11:33 CET
======================================================================
Summary:                    xbox parameter sets AC97_SCAP_DETECT_BY_VENDOR
wrongly
Description: 
the xbox parameter was designed to avoid failed detection of the AC97
codec.
according to the header file AC97_SCAP_DETECT_BY_VENDOR is a flag to ALLOW
detection. Therefore AC97_SCAP_DETECT_BY_VENDOR should be set in scaps if
the xbox 
parameter is false, not true.

The logic in ac97-codec is not consistent either.

To avoid bad AC97 probes, either AC97_SCAP_AUDIO or AC97_SCAP_SKIP_AUDIO
should be set if the xbox parameter is set.
======================================================================

----------------------------------------------------------------------
 tiwai - 01-07-05 18:27 
----------------------------------------------------------------------
Could elaborate which elements should be ignored and should be there?

----------------------------------------------------------------------
 chrb - 03-18-05 11:33 
----------------------------------------------------------------------
There is a bug report for this on gentoo bugzilla
http://bugs.gentoo.org/show_bug.cgi?id=80989

Also discussed on xbox-linux-user
http://sourceforge.net/mailarchive/message.php?msg_id=10500378

Can someone please fix this so we can close all of these bug reports :)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-02-05 18:53 julian         New Issue                                    
01-02-05 18:53 julian         File Added: x                                
01-02-05 18:56 julian         Issue Monitored: julian                      
01-02-05 20:21 julian         Note Added: 0003047                          
01-03-05 16:58 julian         Note Added: 0003069                          
01-03-05 17:31 julian         Note Deleted: 0003047                        
01-03-05 17:36 julian         Note Edited: 0003069                         
01-03-05 17:36 julian         Note Edited: 0003069                         
01-07-05 18:27 tiwai          Note Added: 0003111                          
03-18-05 11:33 chrb           Note Added: 0003992                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
