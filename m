From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000646]: emu10k1: sound chopped when passthru enabled
Date: Sun, 5 Dec 2004 12:36:48 +0100
Message-ID: <431a1d52ced54c74f45524e31febc65f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C723A353
	for <alsa-devel@alsa-project.org>; Sun,  5 Dec 2004 12:36:48 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=646> 
======================================================================
Reported By:                flink
Assigned To:                perex
======================================================================
Project:                    ALSA - lib
Issue ID:                   646
Category:                   pcm - digital audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             11-12-2004 17:02 CET
Last Modified:              12-05-2004 12:36 CET
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
 visit0r - 11-24-04 09:24 
----------------------------------------------------------------------
I have managed to play couple of DVDs with AC3 without any problems, so I
suppose the problem was somewhere else.

----------------------------------------------------------------------
 perex - 12-05-04 12:36 
----------------------------------------------------------------------
Fixed in 1.0.7.

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
11-18-04 23:34 rlrevell       Note Added: 0002472                          
11-19-04 07:14 visit0r        Note Added: 0002476                          
11-24-04 09:09 duanev         Note Added: 0002542                          
11-24-04 09:24 visit0r        Note Added: 0002543                          
12-05-04 12:36 perex          Status                   new => resolved     
12-05-04 12:36 perex          Resolution               open => fixed       
12-05-04 12:36 perex          Assigned To               => perex           
12-05-04 12:36 perex          Note Added: 0002719                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
