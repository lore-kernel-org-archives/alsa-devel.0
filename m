From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000724]: No apparent support for Creative Sounblaster 24 bit.
Date: Sun, 12 Jun 2005 15:43:22 +0200
Message-ID: <95e63d636d6333b3a8bd88fdf3931e9c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 441281D1
	for <alsa-devel@alsa-project.org>; Sun, 12 Jun 2005 15:43:22 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=724> 
======================================================================
Reported By:                sjberryman
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   724
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     feedback
Distribution:               Fedora Core1, Core2 and Suse 9.2
Kernel Version:             2.6.9 2.4.28 2.6.8
======================================================================
Date Submitted:             12-13-2004 09:21 CET
Last Modified:              06-12-2005 15:43 CEST
======================================================================
Summary:                    No apparent support for Creative Sounblaster 24 bit.
Description: 
No apparent support for Creative Sounblaster 24 bit.

Fedora does not find any sound device.

Susi finds a device but can't activate it.
======================================================================

----------------------------------------------------------------------
 jcdutton - 06-11-05 15:13 
----------------------------------------------------------------------
You can find me on irc.freenode.net #alsa as nick jcdutton  sometimes.

----------------------------------------------------------------------
 zubir - 06-12-05 15:43 
----------------------------------------------------------------------
[ed@localhost ~]$ cat /proc/asound/cards
0 [CA0106         ]: CA0106 - CA0106
                     MSI K8N Diamond MB [SB0438] at 0xee00 irq 16

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-13-04 09:21 sjberryman     New Issue                                    
12-13-04 09:21 sjberryman     Distribution              => Fedora Core1, Core2
and Suse 9.2
12-13-04 09:21 sjberryman     Kernel Version            => 2.6.9 2.4.28 2.6.8
12-13-04 09:26 sjberryman     Issue Monitored: sjberryman                    
12-13-04 10:07 pzad           Note Added: 0002821                          
12-16-04 18:28 tiwai          Status                   new => resolved     
12-16-04 18:28 tiwai          Resolution               open => not an issue
12-16-04 18:28 tiwai          Assigned To               => tiwai           
12-16-04 18:28 tiwai          Assigned To              tiwai =>            
01-19-05 09:08 sjberryman     Status                   resolved => feedback
01-19-05 09:08 sjberryman     Resolution               not an issue => reopened
01-19-05 09:08 sjberryman     Note Added: 0003263                          
01-19-05 14:27 tiwai          Note Added: 0003266                          
01-22-05 22:15 nadavkav       Note Added: 0003379                          
01-22-05 23:20 fmoraes        Note Added: 0003381                          
01-25-05 22:39 Kane32         Note Added: 0003411                          
01-26-05 13:18 nadavkav       Note Added: 0003416                          
02-08-05 23:26 sHINOBI        Issue Monitored: sHINOBI                     
02-08-05 23:32 sHINOBI        Note Added: 0003534                          
02-09-05 07:25 pzad           Note Added: 0003535                          
02-09-05 08:57 sHINOBI        Note Added: 0003536                          
02-09-05 13:25 nadavkav       Issue Monitored: nadavkav                    
02-09-05 13:25 nadavkav       Issue End Monitor: nadavkav                    
05-28-05 16:06 sjberryman     Note Added: 0004774                          
05-28-05 20:02 jcdutton       Status                   feedback => assigned
05-28-05 20:02 jcdutton       Assigned To               => jcdutton        
05-28-05 20:07 jcdutton       Note Added: 0004775                          
05-28-05 20:07 jcdutton       Status                   assigned => feedback
06-10-05 13:28 sjberryman     Note Added: 0004983                          
06-10-05 18:58 jcdutton       Note Added: 0004985                          
06-11-05 13:34 sjberryman     Note Added: 0004988                          
06-11-05 15:11 jcdutton       Note Added: 0004991                          
06-11-05 15:13 jcdutton       Note Added: 0004992                          
06-12-05 10:43 nadavkav       Note Deleted: 0003379                        
06-12-05 10:43 nadavkav       Note Deleted: 0003416                        
06-12-05 15:43 zubir          Note Added: 0004998                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
