From: noreply@alsa-project.org
Subject: [ALSA - lib 0000353]: No sound as startup of KDE 3.2.3, errormessage in snd_pcm_hw.c
Date: Thu, 15 Jul 2004 14:20:10 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040715122010.2B20118005@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 801011EF
	for <alsa-devel@alsa-project.org>; Thu, 15 Jul 2004 14:20:10 +0200 (MEST)
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


A BUGNOTE has been added to this bug.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_advanced_page.php?bug_id=0000353
======================================================================
Reported By:                JSchmitt
Assigned To:                
======================================================================
Project:                    ALSA - lib
Bug ID:                     353
Category:                   pcm - digital audio
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             06-30-2004 19:36 CEST
Last Modified:              07-15-2004 14:20 CEST
======================================================================
Summary:                    No sound as startup of KDE 3.2.3, errormessage in snd_pcm_hw.c
Description: 
When I try to start X with KDE 3.2.3, I will get the following error
mesages:

ALSA lib pcm_hw.c:549:(snd_pcm_hw_start) SNDRV_PCM_IOCTL_START failed:
Broken pipe
ALSA lib pcm_hw.c:549:(snd_pcm_hw_start) SNDRV_PCM_IOCTL_START failed:
Broken pipe
ALSA lib pcm_hw.c:549:(snd_pcm_hw_start) SNDRV_PCM_IOCTL_START failed:
Broken pipe

I will not get any sound.
======================================================================

----------------------------------------------------------------------
 perex - 07-15-2004 14:20 CEST 
----------------------------------------------------------------------
Soundcard?

Bug History
Date Modified  Username       Field                    Change              
======================================================================
06-30-04 19:36 JSchmitt       New Bug                                      
07-06-04 18:33 JSchmitt       Bug Monitored: JSchmitt                      
07-15-04 14:20 perex          Bugnote Added: 0001433                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
