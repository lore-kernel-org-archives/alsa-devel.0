From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000848]: Intel HDA (C-Media 9880) SPDIF Out
Date: Mon, 14 Feb 2005 22:27:27 +0100
Message-ID: <b0b62c91f2238612f1ae9e6cacd9862c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3E1A524F
	for <alsa-devel@alsa-project.org>; Mon, 14 Feb 2005 22:27:28 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=848> 
======================================================================
Reported By:                1g0R
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   848
Category:                   PCI - azx
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 3
Kernel Version:             2.6.8-ac8
======================================================================
Date Submitted:             01-25-2005 15:28 CET
Last Modified:              02-14-2005 22:27 CET
======================================================================
Summary:                    Intel HDA (C-Media 9880) SPDIF Out
Description: 
When i set in modprobe.conf the options snd-xxx model=full_dig, there is no
output signal on SPDIF (Coax).
I try:
aplay -D hw:0,1 (<--digital out) else.wav
the command run normally, but no output on spdif out.the same with xmms
(with ALSA, on hw:0,1).

======================================================================

----------------------------------------------------------------------
 1g0R - 02-05-05 08:46 
----------------------------------------------------------------------
[igor@skynet ~]$ iecset sbits 4
Mode: professional
Data: audio
Rate: unknown
Rate Locked: yes
Emphasis: unknown
Stereophonic: not indicated
Userbits: unkown
Sample Bits: unknown
Word Length: unknown
[igor@skynet ~]$ iecset -Dhw:0
Mode: professional
Data: audio
Rate: unknown
Rate Locked: yes
Emphasis: unknown
Stereophonic: not indicated
Userbits: unkown
Sample Bits: unknown
Word Length: unknown
[igor@skynet ~]$   

I cant change the values.Only Mode,and Data can i change. Why?

----------------------------------------------------------------------
 1g0R - 02-14-05 22:27 
----------------------------------------------------------------------
Hi,

I cant change iecset values
[igor@skynet ~]$ sudo iecset -Dhw:0 sbits 4
Password:
Mode: professional
Data: audio
Rate: unknown
Rate Locked: yes
Emphasis: unknown
Stereophonic: not indicated
Userbits: unkown
Sample Bits: unknown
Word Length: unknown
[igor@skynet ~]$ sudo iecset
Mode: professional
Data: audio
Rate: unknown
Rate Locked: yes
Emphasis: unknown
Stereophonic: not indicated
Userbits: unkown
Sample Bits: unknown
Word Length: unknown
[igor@skynet ~]$

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-25-05 15:28 1g0R           New Issue                                    
01-25-05 15:28 1g0R           Distribution              => Fedora Core 3   
01-25-05 15:28 1g0R           Kernel Version            => 2.6.8-ac8       
01-25-05 18:04 jbrsubscribe   Note Added: 0003408                          
01-25-05 18:05 jbrsubscribe   Issue Monitored: jbrsubscribe                    
01-25-05 18:14 jbrsubscribe   Note Added: 0003409                          
01-28-05 02:56 nc             Issue Monitored: nc                          
01-28-05 03:07 nc             Note Added: 0003423                          
01-28-05 19:01 1g0R           Note Added: 0003434                          
02-04-05 15:02 tiwai          Note Added: 0003507                          
02-04-05 19:36 1g0R           Note Added: 0003514                          
02-04-05 19:41 tiwai          Note Added: 0003515                          
02-05-05 06:06 mab            Issue Monitored: mab                         
02-05-05 08:46 1g0R           Note Added: 0003518                          
02-14-05 22:27 1g0R           Note Added: 0003612                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
