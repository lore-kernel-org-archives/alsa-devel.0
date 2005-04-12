From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001046]: after some time, the alsa system is not accessible
Date: Tue, 12 Apr 2005 16:25:03 +0200
Message-ID: <6c77f0d5f2948c665c99b50e94464731@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3168B1BC
	for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2005 16:25:04 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1046> 
======================================================================
Reported By:                wilsotc
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1046
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               gentoo
Kernel Version:             2.6.11-r5
======================================================================
Date Submitted:             04-12-2005 16:05 CEST
Last Modified:              04-12-2005 16:25 CEST
======================================================================
Summary:                    after some time, the alsa system is not accessible
Description: 
If I remote SSH an aplay command, the problem can occur.

This command:
ssh USERNAME@host.com 'aplay /usr/kde/3.3/share/sounds/KDE_Notify.wav'

from a remote system can cause the problem to occur.  The command will
produce audio for weeks, then subsequent commands will cause an error that
looks like this:

ALSA lib confmisc.c:550:(snd_determine_driver) could not open control for
card 0
ALSA lib conf.c:3463:(_snd_config_evaluate) function snd_func_card_driver
returned error: Permission denied
ALSA lib confmisc.c:387:(snd_func_concat) error evaluating strings
ALSA lib conf.c:3463:(_snd_config_evaluate) function snd_func_concat
returned error: Permission denied
ALSA lib confmisc.c:945:(snd_func_refer) error evaluating name
ALSA lib conf.c:3463:(_snd_config_evaluate) function snd_func_refer
returned error: Permission denied
ALSA lib conf.c:3932:(snd_config_expand) Evaluate error: Permission
denied
ALSA lib pcm.c:2068:(snd_pcm_open_noupdate) Unknown PCM default

the user is a member of the audio group as evidenced by the many
successful audio commands prior to the error.
======================================================================

----------------------------------------------------------------------
 tiwai - 04-12-05 16:25 
----------------------------------------------------------------------
It's likely a problem of udev.

Check the file /dev/snd/controlC0 and /dev/snd/pcmC0D0p files exist and
have the proper permissions.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-12-05 16:05 wilsotc        New Issue                                    
04-12-05 16:05 wilsotc        Distribution              => gentoo          
04-12-05 16:05 wilsotc        Kernel Version            => 2.6.11-r5       
04-12-05 16:25 tiwai          Note Added: 0004446                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
