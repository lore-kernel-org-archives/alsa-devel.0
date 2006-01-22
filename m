From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001770]: GUS.conf needs updating
Date: Sun, 22 Jan 2006 16:05:48 +0100
Message-ID: <98c8ba5442f48bc41ce0f6b35cdd835b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 86939150
	for <alsa-devel@alsa-project.org>; Sun, 22 Jan 2006 16:05:48 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1770> 
======================================================================
Reported By:                bcook
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1770
Category:                   ISA - GUS (classic, max, extreme, interwave)
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu
Kernel Version:             2.6.16-rc1
======================================================================
Date Submitted:             01-22-2006 16:05 CET
Last Modified:              01-22-2006 16:05 CET
======================================================================
Summary:                    GUS.conf needs updating
Description: 
When playing PCM sound with snd-gusclassic, alsa lib reports the
following:

ALSA lib pcm.c:1959:(snd_pcm_open_conf) Invalid type for PCM default
definition (id: default, value: cards.pcm.default)
aplay: main:533: audio open error: Invalid argument
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-22-06 16:05 bcook          New Issue                                    
01-22-06 16:05 bcook          Distribution              => Ubuntu          
01-22-06 16:05 bcook          Kernel Version            => 2.6.16-rc1      
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
