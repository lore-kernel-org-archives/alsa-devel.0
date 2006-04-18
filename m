From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0002012]: aplay.c has incorrect syntax in error message
Date: Tue, 18 Apr 2006 15:26:10 +0200
Message-ID: <cee2fc0ec0a65b71d602cf92dee292b5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CCF18219
	for <alsa-devel@alsa-project.org>; Tue, 18 Apr 2006 15:26:10 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2012> 
======================================================================
Reported By:                jaime
Assigned To:                tiwai
======================================================================
Project:                    ALSA - utils
Issue ID:                   2012
Category:                   aplay/arecord
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             04-09-2006 10:14 CEST
Last Modified:              04-18-2006 15:26 CEST
======================================================================
Summary:                    aplay.c has incorrect syntax in error message
Description: 
aplay.c line 920:
fprintf(stderr, _("         please, try the plug plugin (-Dplug:%s)\n"),
snd_pcm_name(handle));

This outputs:
"please, try the plug plugin (-Dplug:hw:0,0)"

Using the recommended syntax returns:

ALSA lib conf.c:3824:(parse_args) Unknown parameter 1
ALSA lib conf.c:3946:(snd_config_expand) Parse arguments error: No such
file or directory
ALSA lib pcm.c:2099:(snd_pcm_open_noupdate) Unknown PCM plug:hw:0,0
aplay: main:544: audio open error: No such file or directory

The syntax should be:
-Dplughw:0,0
(without the colon after the word "plug")

======================================================================

----------------------------------------------------------------------
 tiwai - 04-18-06 15:26 
----------------------------------------------------------------------
Fixed on CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-09-06 10:14 jaime          New Issue                                    
04-18-06 15:26 tiwai          Status                   new => resolved     
04-18-06 15:26 tiwai          Resolution               open => fixed       
04-18-06 15:26 tiwai          Assigned To               => tiwai           
04-18-06 15:26 tiwai          Note Added: 0009335                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
