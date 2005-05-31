From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000848]: Intel HDA (C-Media 9880) SPDIF Out
Date: Tue, 31 May 2005 17:56:53 +0200
Message-ID: <263629c97a95290d47f46908bbb5c170@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7DEDB1B6
	for <alsa-devel@alsa-project.org>; Tue, 31 May 2005 17:56:53 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=848> 
======================================================================
Reported By:                1g0R
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   848
Category:                   PCI - azx
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Distribution:               Fedora Core 3
Kernel Version:             2.6.8-ac8
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             01-25-2005 15:28 CET
Last Modified:              05-31-2005 17:56 CEST
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
 1g0R - 03-24-05 22:20 
----------------------------------------------------------------------
Hi Folks,

Thanks everyone the help.
Now its working tha PCM output on spdif.
I use xmms on receiver.
Many thanks.
tiwai lets close this one.
And thanks again.
Best Regards
1g0R

----------------------------------------------------------------------
 tiwai - 03-29-05 17:30 
----------------------------------------------------------------------
OK, closing now.

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
02-14-05 22:28 1g0R           Note Added: 0003613                          
02-18-05 18:55 tiwai          Note Added: 0003658                          
02-19-05 19:51 1g0R           Note Added: 0003670                          
02-21-05 19:57 1g0R           Note Added: 0003683                          
02-22-05 14:29 tiwai          Note Added: 0003699                          
02-22-05 19:05 1g0R           Note Added: 0003709                          
03-12-05 23:11 1g0R           Note Added: 0003900                          
03-13-05 14:49 1g0R           Note Added: 0003902                          
03-13-05 16:23 1g0R           Note Added: 0003903                          
03-17-05 19:31 1g0R           Note Added: 0003984                          
03-17-05 21:00 pzad           Note Added: 0003985                          
03-18-05 14:41 1g0R           Note Added: 0003994                          
03-18-05 17:22 tiwai          Note Added: 0003996                          
03-24-05 03:39 cltien         Note Added: 0004191                          
03-24-05 22:20 1g0R           Note Added: 0004203                          
03-29-05 17:30 tiwai          Status                   new => resolved     
03-29-05 17:30 tiwai          Resolution               open => fixed       
03-29-05 17:30 tiwai          Assigned To               => tiwai           
03-29-05 17:30 tiwai          Note Added: 0004250                          
05-31-05 17:56 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
