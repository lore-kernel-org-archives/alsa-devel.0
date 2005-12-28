From: bugtrack@alsa-project.org
Subject: [ALSA - plugins 0001685]: Clicking noises when using the default sound channel for snd-hda-intel, which is a dmix
Date: Wed, 28 Dec 2005 11:06:33 +0100
Message-ID: <4d65464ef02b1a604debcbbe723f8fd4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2F1D118C
	for <alsa-devel@alsa-project.org>; Wed, 28 Dec 2005 11:06:34 +0100 (MET)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1685> 
======================================================================
Reported By:                closey
Assigned To:                
======================================================================
Project:                    ALSA - plugins
Issue ID:                   1685
Category:                   PCM - jack
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             12-28-2005 11:06 CET
Last Modified:              12-28-2005 11:06 CET
======================================================================
Summary:                    Clicking noises when using the default sound channel
for snd-hda-intel, which is a dmix
Description: 
Previously the 'default' pcm would only allow for one stream. Now it allows
for multiple streams through use of the dmix plugin, but this plugin
introduces clicking noises into the output - it seems when there is some
activity in the rest of the system.

Tested using aplay on a wav file.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-28-05 11:06 closey         New Issue                                    
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
