From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000646]: emu10k1: sound chopped when passthru enabled
Date: Wed, 24 Nov 2004 09:24:41 +0100
Message-ID: <d8d998a73975f2f077a30df38a5935c2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id EC84E2A5
	for <alsa-devel@alsa-project.org>; Wed, 24 Nov 2004 09:24:41 +0100 (MET)
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
Last Modified:              11-24-2004 09:24 CET
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
 duanev - 11-24-04 09:09 
----------------------------------------------------------------------
I'm 99.99% sure it's fixed - I've played 3 or 4 DVDs now (several with DTS
- higher bitrate?) and never heard a glitch.  I am running a dual proc
which seems to help my interrupt latency in other cases, but these other
users must be running with a single proc.  Has AC3 passthrough worked for
you on this hardware before?

----------------------------------------------------------------------
 visit0r - 11-24-04 09:24 
----------------------------------------------------------------------
I have managed to play couple of DVDs with AC3 without any problems, so I
suppose the problem was somewhere else.

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
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
