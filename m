From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000646]: emu10k1: sound chopped when passthru enabled
Date: Wed, 17 Nov 2004 08:09:47 +0100
Message-ID: <12ceacefa7e74e8f0ff58c5136d8e901@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 8D1C322E
	for <alsa-devel@alsa-project.org>; Wed, 17 Nov 2004 08:09:47 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=646> 
======================================================================
Reported By:                flink
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   646
Category:                   pcm - digital audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             11-12-2004 17:02 CET
Last Modified:              11-17-2004 08:09 CET
======================================================================
Summary:                    emu10k1: sound chopped when passthru enabled
Description: 
When I play a DVD with AC3 passthru enabled, the signal is correctly send
to my AC3 decoder but this signal is chopped. I've a little led on my
decoder to show if dolby digital is enabled or not and this led blinks
instead of remaining enabled. So the sound is also chopped and a DVD can't
be 
watched this way.
======================================================================

----------------------------------------------------------------------
 duanev - 11-17-04 07:00 
----------------------------------------------------------------------
I just applied your patch to linux-2.6.8.1-12mdk/sound/pci/emu10k1/emupcm.c
in my Mandrake 10.1 Official tree (alsa 1.0.6) and it fixes the SBLive
spdif choppy problem perfectly.  (visit0r, are you running a preemtable
kernel?)  For this particular file:

# diff emupcm.c.orig emupcm.c
1188c1188
<               src, frames, tram_shift++);
---
>               src, frames, tram_shift);

(remove the ++)

----------------------------------------------------------------------
 visit0r - 11-17-04 08:09 
----------------------------------------------------------------------
Yes, I'm running kernel in preemptable mode. The patch is applied in the
version of ALSA in Linux 2.6.10-rc2, it seems. Still, the effect is there,
but as I said, it's not even close as bad as before. 

Are you sure it fixed it completely? The choppies might not be noticeable
when you watch the DVD with AC3 only for a minute or two.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-12-04 17:02 flink          New Issue                                    
11-13-04 22:18 rlrevell       Note Added: 0002403                          
11-13-04 22:31 rlrevell       File Added: patch                            
11-13-04 22:33 rlrevell       Note Added: 0002404                          
11-16-04 00:13 visit0r        Note Added: 0002421                          
11-16-04 00:24 rlrevell       Note Added: 0002422                          
11-16-04 21:09 visit0r        Note Added: 0002430                          
11-17-04 04:06 duanev         Issue Monitored: duanev                      
11-17-04 07:00 duanev         Note Added: 0002432                          
11-17-04 08:05 visit0r        Issue Monitored: visit0r                     
11-17-04 08:09 visit0r        Note Added: 0002434                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
