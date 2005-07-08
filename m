From: bugtrack@alsa-project.org
Subject: [ALSA - liboss 0000492]: EMU10K1 and OSS emulation PCM volume problem
Date: Fri, 8 Jul 2005 10:38:38 +0200
Message-ID: <9ce9c81dfaf1027adad6fe9452bc387d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 47814E3
	for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2005 10:38:38 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=492> 
======================================================================
Reported By:                croiset
Assigned To:                
======================================================================
Project:                    ALSA - liboss
Issue ID:                   492
Category:                   
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Resolution:                 unable to duplicate
Fixed in Version:           
======================================================================
Date Submitted:             09-09-2004 16:51 CEST
Last Modified:              07-08-2005 10:38 CEST
======================================================================
Summary:                    EMU10K1 and OSS emulation PCM volume problem
Description: 
when I use a sound card :
0 [Live           ]: EMU10K1 - Sound Blaster Live!
                     Sound Blaster Live! (rev.10) at 0x8400, irq 10
when I use the oss emulation, the only way to have sound on the audio
analog output, is to use the mixer call Wave (ALTPCM) instead of PCM like
other cards. The mixer I used for the test is alsamixer.

My tests are on alsa driver 1.0.5a.

======================================================================

----------------------------------------------------------------------
 jdthood - 03-21-05 00:02 
----------------------------------------------------------------------
Submitter: Any improvement with later ALSA releases?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-09-04 16:51 croiset        New Issue                                    
03-21-05 00:02 jdthood        Note Added: 0004106                          
03-28-05 04:08 jdthood        Status                   new => resolved     
03-28-05 04:08 jdthood        Resolution               open => unable to
duplicate
07-08-05 10:38 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
