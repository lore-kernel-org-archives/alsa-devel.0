From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000306]: compiles, but no sound comes out
Date: Wed, 20 Oct 2004 00:38:01 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041019223801.96B9B18009@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 01430327
	for <alsa-devel@alsa-project.org>; Wed, 20 Oct 2004 00:38:01 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000306
======================================================================
Reported By:                Quietti
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     306
Category:                   PPC - powermac
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             self-compiled 2.6.6 vanilla.
======================================================================
Date Submitted:             05-25-2004 20:35 CEST
Last Modified:              10-20-2004 00:38 CEST
======================================================================
Summary:                    compiles, but no sound comes out
Description: 
This is a plain vanilla kernel 2.6.6, which uses ALSA 1.0.4.

The kernel compiles fine, the snd_powermac module loads without any error,
but no sound comes up.

Running alsamixer gives me a mixer screen where none of the sliders can be
moved.
======================================================================

----------------------------------------------------------------------
 tiwai - 05-28-2004 21:18 CEST 
----------------------------------------------------------------------
to be sure: the mixer value cannot be changed via amixer program?

----------------------------------------------------------------------
 Quietti - 05-28-2004 21:37 CEST 
----------------------------------------------------------------------
Yes, that fails too.  For example:

root@omena:/home/q-funk# amixer set CD 80%
Simple mixer control 'CD',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 100
  Front Left: Playback 80 [80%]
  Front Right: Playback 80 [80%]
root@omena:/home/q-funk# amixer get CD
Simple mixer control 'CD',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 100
  Front Left: Playback 0 [0%]
  Front Right: Playback 0 [0%]
root@omena:/home/q-funk#

That has always failed on this hardware using ALSA.  

However, the old OSS driver dmasound_pmac produces sounds, so I know that
the hardware is not at fault. Then again, since OSS is being deprecated, I
cannot afford to continue using it for too long.

----------------------------------------------------------------------
 Quietti - 07-25-2004 20:16 CEST 
----------------------------------------------------------------------
I would just like to point out that this is still broken in kernel 2.6.7.

----------------------------------------------------------------------
 Quietti - 09-08-2004 06:32 CEST 
----------------------------------------------------------------------
Still broken in kernel 2.6.8.1 also.

----------------------------------------------------------------------
 Quietti - 10-20-2004 00:38 CEST 
----------------------------------------------------------------------
Still broken in kernel 2.6.9 as well.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
05-25-04 20:35 Quietti        New Bug                                      
05-25-04 20:35 Quietti        File Added: asound.state                     
05-25-04 20:35 Quietti        Distribution              => Debian          
05-25-04 20:35 Quietti        Kernel Version            => self-compiled 2.6.6 vanilla.
05-25-04 20:38 Quietti        Bug Monitored: Quietti                       
05-28-04 21:18 tiwai          Bugnote Added: 0001274                       
05-28-04 21:37 Quietti        Bugnote Added: 0001275                       
07-25-04 20:16 Quietti        Bugnote Added: 0001473                       
09-08-04 06:32 Quietti        Bugnote Added: 0001726                       
10-20-04 00:38 Quietti        Bugnote Added: 0002209                       
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
