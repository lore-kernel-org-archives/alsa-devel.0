From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000372]: Problem using Jack with multiple RME 96/8 PAD sound cards
Date: Sat, 19 Mar 2005 09:08:27 +0100
Message-ID: <40b47fade6670951518b197fe5fdcfec@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B18A81E6
	for <alsa-devel@alsa-project.org>; Sat, 19 Mar 2005 09:08:27 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=372> 
======================================================================
Reported By:                sidorovich
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   372
Category:                   general
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             07-09-2004 19:22 CEST
Last Modified:              03-19-2005 09:08 CET
======================================================================
Summary:                    Problem using Jack with multiple RME 96/8 PAD sound
cards
Description: 
I am trying to use two RME 96/8 PAD sound cards in a system running Red Hat
version 9 and can't get capture to work.  I am trying to get this working
using Jack and have used the
.asoundrc magic found on http://www.opensrc.org to treat these two cards
as one four channel device but it only seems to work in playback mode. 
If I try capture, or duplex, mode I immediately get the following errors:
  ALSA lib pcm.c:1148:(snd_pcm_link) SNDRV_PCM_IOCTL_LINK failed:
Operation already in progress
 jackstart:  pcm.c:6036: snd_pcm_mmap_commit:  Assertion " frames <=
snd_pcm_mmap_avail(pcm)" failed.
 
 I can get either card working one at a time but not together for a four
channel system.  I have attached the .asoundrc file that I am using to
combine these two cards into one.  
 
Is this a bug with ALSA?
======================================================================

----------------------------------------------------------------------
 jdthood - 03-19-05 09:08 
----------------------------------------------------------------------
Submitter: Did you ever figure out this problem?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-09-04 19:22 sidorovich     New Issue                                    
07-09-04 19:22 sidorovich     File Added: .asoundrc.txt                    
03-19-05 09:08 jdthood        Note Added: 0004012                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
