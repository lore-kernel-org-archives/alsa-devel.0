From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001702]: No sound in front speakers emu10k1
Date: Tue, 3 Jan 2006 20:39:31 +0100
Message-ID: <f3e91d748440a894898280bcda85ff3e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C7249175
	for <alsa-devel@alsa-project.org>; Tue,  3 Jan 2006 20:39:31 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1702> 
======================================================================
Reported By:                pupp3tmast3r
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1702
Category:                   hw specific configuration
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             01-03-2006 09:41 CET
Last Modified:              01-03-2006 20:39 CET
======================================================================
Summary:                    No sound in front speakers emu10k1
Description: 
Card: SBLive! Value [CT4832]
Chip: Cirrus Logic CS4297A rev 4

When playing in surroud mode with mplayer (-af surround) or audio streams
of 4 or more channels there is no front audio just rear.

This card does only 4 channels playing since is one of the very first
models.

The bug appears in versions of mplayer from 1.0pre7try2 to CVS2005-12-15
======================================================================

----------------------------------------------------------------------
 pupp3tmast3r - 01-03-06 20:13 
----------------------------------------------------------------------
>From kernel 2.6.14 (Home Build)

/proc/asound/version:

Advanced Linux Sound Architecture Driver Version 1.0.10rc1 (Mon Sep 12
08:13:09
2005 UTC).

The bug Appears even on 1.0.10driver from alsa-project.org main branch

----------------------------------------------------------------------
 pzad - 01-03-06 20:39 
----------------------------------------------------------------------
Find file emu10k1.conf. Default location is in /usr/share/confcards/. For
FC4 is in /etc/alsa/cards.

Check if in this file is this:

{
       interface PCM
       device 0
       name "EMU10K1 PCM Send Routing"
       index { @func private_pcm_subdevice }
       lock true
       optional true
       value [ 8 9 0 0 8 9 0 0 8 9 0 0 ]
}

If you don't have this in emu10k1.conf file, you have old alsa-lib and you
should upgrade alsa-lib, or copy this file from alsa-lib 1.0.10.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-03-06 09:41 pupp3tmast3r   New Issue                                    
01-03-06 09:47 pzad           Note Added: 0007400                          
01-03-06 20:10 pupp3tmast3r   File Added: asound.state                     
01-03-06 20:13 pupp3tmast3r   Note Added: 0007404                          
01-03-06 20:39 pzad           Note Added: 0007405                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
