From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001502]: Bad step values in snd_pcm_channel_area_t from snd_pcm_mmap_begin
Date: Wed, 26 Oct 2005 08:26:37 +0200
Message-ID: <65f344c912ba9e080adf77f1ce13e796@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 09DF815A
	for <alsa-devel@alsa-project.org>; Wed, 26 Oct 2005 08:26:37 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1502> 
======================================================================
Reported By:                drechsle
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1502
Category:                   0_general
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             10-25-2005 16:47 CEST
Last Modified:              10-26-2005 08:26 CEST
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
 drechsle - 10-25-05 18:35 
----------------------------------------------------------------------
Hardware: Tyan S2885, 2xOpteron 248, 
Audio Device: AMD8111 (intel8x0)
Kernel: 2.6.13 (smp, patched by suse)

----------------------------------------------------------------------
 drechsle - 10-26-05 08:26 
----------------------------------------------------------------------
tried 1.0.10rc2: same problem

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-25-05 16:47 drechsle       New Issue                                    
10-25-05 17:44 tiwai          Note Added: 0006545                          
10-25-05 18:35 drechsle       Note Added: 0006549                          
10-26-05 08:26 drechsle       Note Added: 0006553                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
