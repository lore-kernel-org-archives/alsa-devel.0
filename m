From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001565]: Compilation problem of src/pcm/pcm_file.c
Date: Wed, 16 Nov 2005 16:46:38 +0100
Message-ID: <018773ef59d09fe23958d91e847eaf78@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B83C51CC
	for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2005 16:46:38 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1565> 
======================================================================
Reported By:                croiset
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1565
Category:                   0_general
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             11-16-2005 16:46 CET
Last Modified:              11-16-2005 16:46 CET
======================================================================
Summary:                    Compilation problem of src/pcm/pcm_file.c
Description: 
there is an error on line 191 of pcm_file.c you must replace it by : 
n = snd_pcm_frames_to_bytes(pcm, err);

The old line was :
snd_pcm_uframes_t n = snd_pcm_frames_to_bytes(pcm, err);

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-16-05 16:46 croiset        New Issue                                    
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
