From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001334]: module fails to load because it can't register ac97 bus
Date: Tue, 16 Aug 2005 18:05:49 +0200
Message-ID: <7f2d327a69c38e781e3b589b8119113a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3DC081FD
	for <alsa-devel@alsa-project.org>; Tue, 16 Aug 2005 18:05:50 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1334> 
======================================================================
Reported By:                bdijkstra
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1334
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               SuSE Linux
Kernel Version:             2.6.13-rc5-git3-3-default
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             08-14-2005 00:13 CEST
Last Modified:              08-16-2005 18:05 CEST
======================================================================
Summary:                    module fails to load because it can't register ac97
bus
Description: 
The Hercules GameTheater XP card has two codecs of the same type (CS4294).
The cs46xx driver tries to register these two codecs with the same name
with the ac97 bus which then fails.
I have attached the message log of a module load which shows the problem.


======================================================================

----------------------------------------------------------------------
 bdijkstra - 08-15-05 23:14 
----------------------------------------------------------------------
added same patch as a file attachment, in case you prefer it that way..

----------------------------------------------------------------------
 tiwai - 08-16-05 18:05 
----------------------------------------------------------------------
Applied to CVS.  Thanks.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-14-05 00:13 bdijkstra      New Issue                                    
08-14-05 00:13 bdijkstra      File Added: cs46xx-error.log                    
08-14-05 00:13 bdijkstra      Distribution              => SuSE Linux      
08-14-05 00:13 bdijkstra      Kernel Version            =>
2.6.13-rc5-git3-3-default
08-14-05 00:21 bdijkstra      Note Added: 0005812                          
08-14-05 14:19 bdijkstra      Note Added: 0005815                          
08-15-05 19:55 tiwai          Note Added: 0005820                          
08-15-05 23:11 bdijkstra      Note Added: 0005823                          
08-15-05 23:14 bdijkstra      File Added: ac97_codec_name.patch                 
  
08-15-05 23:14 bdijkstra      Note Added: 0005824                          
08-16-05 18:05 tiwai          Status                   new => resolved     
08-16-05 18:05 tiwai          Resolution               open => fixed       
08-16-05 18:05 tiwai          Assigned To               => tiwai           
08-16-05 18:05 tiwai          Note Added: 0005830                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
