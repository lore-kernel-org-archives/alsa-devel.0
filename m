From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000435]: No current support for the ICH6R & ALC880 devices
Date: Wed, 19 Jan 2005 16:50:07 +0100
Message-ID: <2be7ccf205f8408576733bacc2f4a4dc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 7CF0F26D
	for <alsa-devel@alsa-project.org>; Wed, 19 Jan 2005 16:50:07 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=435> 
======================================================================
Reported By:                snaketails
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   435
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Distribution:               Gentoo
Kernel Version:             2.6.7
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             08-12-2004 02:50 CEST
Last Modified:              01-19-2005 16:50 CET
======================================================================
Summary:                    No current support for the ICH6R & ALC880 devices
Description: 
As this is a new mobo, there is no driver configuration that supports this
newer buss interface devices, so there is no sound from the mobo.
The inability for the mobo to run SATA under Linux is not an issue here,
as I am using the SiS SATA driver, only issue is sound
======================================================================

----------------------------------------------------------------------
 jdthood - 12-12-04 14:02 
----------------------------------------------------------------------
"Crackling sound" also reported at http://bugs.debian.org/281546

----------------------------------------------------------------------
 tiwai - 12-15-04 16:12 
----------------------------------------------------------------------
Fixed in the latest CVS version of azx driver.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-12-04 02:50 snaketails     New Issue                                    
08-12-04 02:50 snaketails     Distribution              => Gentoo          
08-12-04 02:50 snaketails     Kernel Version            => 2.6.7           
08-12-04 07:32 pzad           Note Added: 0001551                          
08-13-04 02:03 snaketails     Note Added: 0001560                          
08-16-04 06:01 snaketails     Note Added: 0001569                          
08-18-04 04:28 snaketails     Note Added: 0001575                          
08-18-04 11:53 tiwai          Note Added: 0001576                          
08-23-04 06:33 snaketails     Note Added: 0001610                          
12-12-04 14:02 jdthood        Note Added: 0002815                          
12-15-04 16:12 tiwai          Status                   new => resolved     
12-15-04 16:12 tiwai          Resolution               open => fixed       
12-15-04 16:12 tiwai          Assigned To               => tiwai           
12-15-04 16:12 tiwai          Note Added: 0002826                          
12-15-04 16:12 tiwai          Assigned To              tiwai =>            
01-19-05 16:50 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
