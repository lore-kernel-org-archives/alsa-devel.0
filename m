From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000160]: snd-cmi8330 produces no sound
Date: Sat, 19 Mar 2005 09:37:19 +0100
Message-ID: <441ead2a7548b0de90ea197a33eeccca@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id AAE4F1F9
	for <alsa-devel@alsa-project.org>; Sat, 19 Mar 2005 09:37:19 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=160> 
======================================================================
Reported By:                sb73542
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   160
Category:                   ISA - cmi8330
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Slackware
Kernel Version:             2.4.25
======================================================================
Date Submitted:             03-27-2004 05:32 CET
Last Modified:              03-19-2005 09:37 CET
======================================================================
Summary:                    snd-cmi8330 produces no sound
Description: 
Hi, I'm trying to use my onboard cmi8330 soundcard with ALSA.  alsaconf
detectseverything correctly, but unfortunately no sound.  These are the
devices that appear under /dev/snd :
controlC0  
pcmC0D0c   
pcmC0D0p   
timer

I've been trying to use set this up with arts, and it when I overide the
defaults to any of the above, it says it's an invalid device, and can't be
written to.  The alsa docs list as a bug for this card: "Is broken".  Any
fixes?  Thanks for the help!
======================================================================

----------------------------------------------------------------------
 jdthood - 03-19-05 09:37 
----------------------------------------------------------------------
Submitter: Have you had better luck with more recent ALSA releases?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-27-04 05:32 sb73542        New Issue                                    
03-27-04 05:32 sb73542        Distribution              => Slackware       
03-27-04 05:32 sb73542        Kernel Version            => 2.4.25          
03-19-05 09:37 jdthood        Note Added: 0004022                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
