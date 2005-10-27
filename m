From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001502]: Bad step values in snd_pcm_channel_area_t from snd_pcm_mmap_begin
Date: Thu, 27 Oct 2005 19:29:44 +0200
Message-ID: <ae0788e716941c0d6f087341b9597e10@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 46A4C1A1
	for <alsa-devel@alsa-project.org>; Thu, 27 Oct 2005 19:29:44 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1502> 
======================================================================
Reported By:                drechsle
Assigned To:                tiwai
======================================================================
Project:                    ALSA - lib
Issue ID:                   1502
Category:                   0_general
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             10-25-2005 16:47 CEST
Last Modified:              10-27-2005 19:29 CEST
======================================================================
Summary:                    Bad step values in snd_pcm_channel_area_t from
snd_pcm_mmap_begin
Description: 
I opened the default audio device with 4 channels (MMAP_INTERLEAVED,
SND_PCM_FORMAT_S16)
snd_pcm_mmap_begin then returns a snd_pcm_channel_area_t * like the
following:

Channel 0:   first:    0    step:   32
Channel 1:   first:   16    step:   32
Channel 2:   first:   32    step:   32
Channel 3:   first:   48    step:   32

The step values seem to be wrong. It also doesn't sound very comfortable.
======================================================================

----------------------------------------------------------------------
 drechsle - 10-27-05 08:34 
----------------------------------------------------------------------
I don't know how this could happen, but it's possible.
Propably it's a Suse configuration problem. I think they
use dmix per default?

----------------------------------------------------------------------
 tiwai - 10-27-05 19:29 
----------------------------------------------------------------------
In that case, it's mapped from 4 to 2 channels.
Anyway, this bug is fixed now on CVS.  Thanks.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-25-05 16:47 drechsle       New Issue                                    
10-25-05 17:44 tiwai          Note Added: 0006545                          
10-25-05 18:35 drechsle       Note Added: 0006549                          
10-26-05 08:26 drechsle       Note Added: 0006553                          
10-26-05 12:56 tiwai          Note Added: 0006554                          
10-26-05 13:54 drechsle       Note Added: 0006556                          
10-26-05 13:55 drechsle       File Added: alsa.tar.bz2                     
10-26-05 14:04 tiwai          Note Added: 0006557                          
10-27-05 08:34 drechsle       Note Added: 0006565                          
10-27-05 19:29 tiwai          Status                   new => resolved     
10-27-05 19:29 tiwai          Resolution               open => fixed       
10-27-05 19:29 tiwai          Assigned To               => tiwai           
10-27-05 19:29 tiwai          Note Added: 0006566                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
