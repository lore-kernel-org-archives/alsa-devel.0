From: bugtrack@alsa-project.org
Subject: =?iso-8859-1?Q?[ALSA_-_driver_0000855]:_Analog_Input_doesn=B4t_work?=
Date: Tue, 22 Mar 2005 22:10:19 +0100
Message-ID: <fef151dd13b099f3c6ed5e796f684690@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B3F0C28D
	for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2005 22:10:19 +0100 (MET)
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
Last Modified:              03-22-2005 22:10 CET
======================================================================
Summary:                    Analog Input doesn´t work
Description: 
I tried to capture some tunes with my CMI9880 (an a ASUS P5GD2). It doesn´t
care with mixer settings are made, the is simply no sound input.

Does the azx driver support line-in anyways?
======================================================================

----------------------------------------------------------------------
 jdthood - 03-22-05 22:01 
----------------------------------------------------------------------
The submitter reports that 1.0.9rc1 does not fix the problem.
He still can't listen to line in unless he copies /dev/dsp 
back to /dev/dsp.

----------------------------------------------------------------------
 tiwai - 03-22-05 22:10 
----------------------------------------------------------------------
This codec chip has no input loop-back path.  You have to do copy the audio
data from line-in to line-out in software.

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
03-22-05 22:01 jdthood        Note Added: 0004134                          
03-22-05 22:10 tiwai          Note Added: 0004136                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
