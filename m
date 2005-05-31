From: bugtrack@alsa-project.org
Subject: =?iso-8859-1?Q?[ALSA_-_driver_0000855]:_Analog_Input_doesn=B4t_work?=
Date: Tue, 31 May 2005 18:03:10 +0200
Message-ID: <741fca21be8c05a65cba20883bd8139c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 58B131AF
	for <alsa-devel@alsa-project.org>; Tue, 31 May 2005 18:03:10 +0200 (MEST)
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
Status:                     closed
Distribution:               Fedora Core 3 + Alsa 1.0.8
Kernel Version:             2.6.9 and 2.6.10 (from Fedora)
Resolution:                 won't fix
Fixed in Version:           
======================================================================
Date Submitted:             01-28-2005 13:21 CET
Last Modified:              05-31-2005 18:03 CEST
======================================================================
Summary:                    Analog Input doesn´t work
Description: 
I tried to capture some tunes with my CMI9880 (an a ASUS P5GD2). It doesn´t
care with mixer settings are made, the is simply no sound input.

Does the azx driver support line-in anyways?
======================================================================

----------------------------------------------------------------------
 tiwai - 03-22-05 22:10 
----------------------------------------------------------------------
This codec chip has no input loop-back path.  You have to do copy the audio
data from line-in to line-out in software.

----------------------------------------------------------------------
 jdthood - 03-22-05 22:13 
----------------------------------------------------------------------
OK, thanks for the explanation.

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
03-22-05 22:13 jdthood        Note Added: 0004137                          
03-22-05 22:13 jdthood        Status                   new => resolved     
03-22-05 22:13 jdthood        Resolution               open => won't fix   
05-31-05 18:03 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
