From: bugtrack@alsa-project.org
Subject: =?iso-8859-1?Q?[ALSA_-_driver_0000855]:_Analog_Input_doesn=B4t_work?=
Date: Wed, 16 Mar 2005 14:48:32 +0100
Message-ID: <463140b1a7393d9e33e32ab06142be18@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2F08D211
	for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2005 14:48:32 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=855> 
======================================================================
Reported By:                Tom
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   855
Category:                   PCI - azx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 3 + Alsa 1.0.8
Kernel Version:             2.6.9 and 2.6.10 (from Fedora)
======================================================================
Date Submitted:             01-28-2005 13:21 CET
Last Modified:              03-16-2005 14:48 CET
======================================================================
Summary:                    Analog Input doesn´t work
Description: 
I tried to capture some tunes with my CMI9880 (an a ASUS P5GD2). It doesn´t
care with mixer settings are made, the is simply no sound input.

Does the azx driver support line-in anyways?
======================================================================

----------------------------------------------------------------------
 jdthood - 03-11-05 00:48 
----------------------------------------------------------------------
See http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=297624 .
Any similarity to your problem?

----------------------------------------------------------------------
 tiwai - 03-16-05 14:48 
----------------------------------------------------------------------
Try 1.0.9rc1.  The driver was renamed to snd-hda-intel.
Many bugs of this driver have been fixed.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-28-05 13:21 Tom            New Issue                                    
01-28-05 13:21 Tom            Distribution              => Fedora Core 3 + Alsa
1.0.8
01-28-05 13:21 Tom            Kernel Version            => 2.6.9 and 2.6.10
(from Fedora)
01-31-05 14:10 Tom            Issue Monitored: Tom                         
01-31-05 14:10 Tom            Issue End Monitor: Tom                       
03-11-05 00:48 jdthood        Note Added: 0003876                          
03-16-05 14:48 tiwai          Note Added: 0003958                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
