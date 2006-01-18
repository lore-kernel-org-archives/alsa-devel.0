From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001341]: No volume control
Date: Wed, 18 Jan 2006 04:34:36 +0100
Message-ID: <f8925180dd0feddef4614bcf4a44ad05@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 23D0F156
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2006 04:34:37 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1341> 
======================================================================
Reported By:                chui101
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1341
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Arch
Kernel Version:             2.6.12-ARCH
======================================================================
Date Submitted:             08-16-2005 12:51 CEST
Last Modified:              01-18-2006 04:34 CET
======================================================================
Summary:                    No volume control
Description: 
Initially, there was no sound, but to enable sound output the "IEC958
Capture Monitor" switch must be turned off.

Once there is sound, there is no way to control the volume. All the volume
sliders in the playback tab of the GNOME Volume Control are functionless.
PCM appears as a switch, perhaps it should be a slider?
======================================================================

----------------------------------------------------------------------
 rlrevell - 01-17-06 23:22 
----------------------------------------------------------------------
Takashi-san,

This patch is still sitting in my tree.  I guess we have to identify which
codecs need softvol enabled by default.  Can we do anything about this
without the /proc/asound/card0/codec97#0/* file from the user?

----------------------------------------------------------------------
 chui101 - 01-18-06 04:34 
----------------------------------------------------------------------
Sorry, i kind of pushed this on the back burner and then completely
forgot.
Here's the contents of the files (attached)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-16-05 12:51 chui101        New Issue                                    
08-16-05 12:51 chui101        Distribution              => Arch            
08-16-05 12:51 chui101        Kernel Version            => 2.6.12-ARCH     
08-16-05 12:54 chui101        Note Added: 0005827                          
08-16-05 12:58 chui101        Issue Monitored: chui101                     
08-18-05 18:12 chui101        Note Added: 0005849                          
08-19-05 02:33 rlrevell       File Added: atiixp-softvol.patch                  
 
08-19-05 02:35 rlrevell       Note Added: 0005862                          
08-26-05 14:49 tiwai          Note Added: 0005950                          
01-17-06 23:22 rlrevell       Note Added: 0007703                          
01-18-06 04:34 chui101        Note Added: 0007705                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
