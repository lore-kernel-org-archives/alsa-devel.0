From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000836]: Intel HDA (C-Media 9880) - alsamixer/gamix - no slider control for Surround/Center/LFE/Side
Date: Thu, 20 Jan 2005 01:07:36 +0100
Message-ID: <2af08b20d8e3b13aaf677a023699b513@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 6F30926C
	for <alsa-devel@alsa-project.org>; Thu, 20 Jan 2005 01:07:36 +0100 (MET)
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


The following issue has been REOPENED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=836> 
======================================================================
Reported By:                jbrsubscribe
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   836
Category:                   PCI - azx
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     feedback
Distribution:               Suse
Kernel Version:             2.6.8-24.10-smp
======================================================================
Date Submitted:             01-19-2005 18:19 CET
Last Modified:              01-20-2005 01:07 CET
======================================================================
Summary:                    Intel HDA (C-Media 9880) - alsamixer/gamix - no
slider control for Surround/Center/LFE/Side
Description: 
Unable to set volume control for Surround/Center/LFE/Side due to the fact
that the sliders for these entities do not function in alsamixer and
gamix. The sliders cannot be manipulated. The only functional sliders are
PCM, PC Speaker and the two (2) Capture sliders.
In KAMix, KMix and QAMix the sliders for Surround/Center/LFE/Side do not
appear at all.
======================================================================

----------------------------------------------------------------------
 tiwai - 01-19-05 18:36 
----------------------------------------------------------------------
It's not a bug.  The codec chip has really no playback volume control.

----------------------------------------------------------------------
 jbrsubscribe - 01-20-05 01:07 
----------------------------------------------------------------------
I forgot to mention that, even with the PCM slider set to the maximum
position, the CMI9880 does NOT produce any sound at all!!
The question remains - what are the other options to get the driver to
produce sound from the CMI9880?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-19-05 18:19 jbrsubscribe   New Issue                                    
01-19-05 18:19 jbrsubscribe   File Added: aadebug                          
01-19-05 18:19 jbrsubscribe   Distribution              => Suse            
01-19-05 18:19 jbrsubscribe   Kernel Version            => 2.6.8-24.10-smp 
01-19-05 18:27 jbrsubscribe   Issue Monitored: jbrsubscribe                    
01-19-05 18:36 tiwai          Status                   new => resolved     
01-19-05 18:36 tiwai          Resolution               open => not an issue
01-19-05 18:36 tiwai          Assigned To               => tiwai           
01-19-05 18:36 tiwai          Note Added: 0003311                          
01-19-05 18:36 tiwai          Assigned To              tiwai =>            
01-20-05 01:07 jbrsubscribe   Status                   resolved => feedback
01-20-05 01:07 jbrsubscribe   Resolution               not an issue => reopened
01-20-05 01:07 jbrsubscribe   Note Added: 0003320                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
