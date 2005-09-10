From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000724]: No apparent support for Creative Sounblaster 24 bit.
Date: Sat, 10 Sep 2005 13:12:37 +0200
Message-ID: <e543e5f6de0c4aa0835991c34e985ea1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1DC7B16C
	for <alsa-devel@alsa-project.org>; Sat, 10 Sep 2005 13:12:38 +0200 (MEST)
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
Status:                     closed
Distribution:               Fedora Core1, Core2 and Suse 9.2
Kernel Version:             2.6.9 2.4.28 2.6.8
Resolution:                 reopened
Fixed in Version:           
======================================================================
Date Submitted:             12-13-2004 09:21 CET
Last Modified:              09-10-2005 13:12 CEST
======================================================================
Summary:                    No apparent support for Creative Sounblaster 24 bit.
Description: 
No apparent support for Creative Sounblaster 24 bit.

Fedora does not find any sound device.

Susi finds a device but can't activate it.
======================================================================

----------------------------------------------------------------------
 jcdutton - 06-13-05 10:25 
----------------------------------------------------------------------
Use the alsasound startup script.
It is a standard /etc/init.d script that runs at start up and shutdown.
At shutdown is stores the mixer settings, and start up is restores them.

----------------------------------------------------------------------
 jcdutton - 09-10-05 13:12 
----------------------------------------------------------------------
Fixed in alsa-driver 1.0.9b

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
06-13-05 09:33 sjberryman     Note Added: 0005002                          
06-13-05 10:25 jcdutton       Note Added: 0005003                          
09-10-05 13:12 jcdutton       Status                   feedback => closed  
09-10-05 13:12 jcdutton       Note Added: 0006118                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
