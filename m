From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000332]: Unable to enable 'Mic as Center/LFE'
Date: Thu, 31 Mar 2005 20:23:44 +0200
Message-ID: <b5c236e8609eebd4affd434f947804b7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id EA6A21D5
	for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2005 20:23:44 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=332> 
======================================================================
Reported By:                Johan Gorter
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   332
Category:                   alsamixer
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             06-11-2004 09:12 CEST
Last Modified:              03-31-2005 20:23 CEST
======================================================================
Summary:                    Unable to enable 'Mic as Center/LFE'
Description: 
In the alsa versions I have used thus far (1.0.3 and 1.0.5) I am unable to
enable the 'Mic as Center/LFE' option of my onboard AC '97. Alsamixer
cannot change its value from 0 and record / mute is also disabled. I
tracked the problem by using alsactl to store the settings. This results
in a file where this option (nr 47 on my system) is an Integer with the
comment that the value may be from 0 to 0. On other systems I found out
that this is supposed to be a Boolean which can be switched on and off.
======================================================================

----------------------------------------------------------------------
 jdthood - 03-20-05 15:45 
----------------------------------------------------------------------
Submitter: Please test the latest ALSA release and report whether or not
this remains a problem.  If it is still a problem, please tell us what
sound card you have and what ALSA modules you are using.  Also send your
asound.state file.

----------------------------------------------------------------------
 jdthood - 03-31-05 20:23 
----------------------------------------------------------------------
Submitter: Please test the latest ALSA release and report whether or not
this remains a problem. If it is still a problem, please tell us what
sound card you have and what ALSA modules you are using. Also send your
asound.state file.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-11-04 09:12 Johan Gorter   New Issue                                    
01-22-05 03:26 rhal           Issue Monitored: rhal                        
03-20-05 15:45 jdthood        Note Added: 0004093                          
03-31-05 20:23 jdthood        Note Added: 0004284                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
