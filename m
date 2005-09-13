From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001377]: tons of unknown symbols with 2.6.13 final
Date: Tue, 13 Sep 2005 15:53:56 +0200
Message-ID: <d69da71759ff0e705b2b9b41caa9c8e1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 710791D8
	for <alsa-devel@alsa-project.org>; Tue, 13 Sep 2005 15:53:56 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1377> 
======================================================================
Reported By:                spiral
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1377
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               Kubuntu Hoary
Kernel Version:             2.6.13 final
======================================================================
Date Submitted:             08-30-2005 09:34 CEST
Last Modified:              09-13-2005 15:53 CEST
======================================================================
Summary:                    tons of unknown symbols with 2.6.13 final
Description: 
Hello !

I have a laptop with a hda-intel based sound card... I recently tried to
update my kernel to 2.6.13 with the official kernel.org source, with
almost the same configuration I have on my 2.6.12.5... This worked nicely
except for alsa, that I tried to build either from 1.0.10rc1 or from cvs
(1.0.9 doesn't handle my sound card so I didn't try to rebuild this one)

In both cases, I can't load snd-hda-intel and I get a lot of unknown
symbol messages in dmesg...

I don't have this problem with my 2.6.12.5, but only with the 2.6.13...
======================================================================

----------------------------------------------------------------------
 tiwai - 09-12-05 16:30 
----------------------------------------------------------------------
This is possiblly because configure script failed to detect some
conditions.  For example, some compile flags was changed, etc.

Please attach config.log for checking.

----------------------------------------------------------------------
 spiral - 09-13-05 15:53 
----------------------------------------------------------------------
I just installed ubuntu breezy because I had a lot of problems with my good
old hoary, and I took the same 2.6.13.1 kernel, alsa 1.0.10rc1, and it
works fine on this system now...

Thanks for your help

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-30-05 09:34 spiral         New Issue                                    
08-30-05 09:34 spiral         Distribution              => Kubuntu Hoary   
08-30-05 09:34 spiral         Kernel Version            => 2.6.13 final    
09-02-05 19:51 tiwai          Note Added: 0006017                          
09-04-05 22:11 1g0R           Note Added: 0006038                          
09-05-05 14:15 kSh            Note Added: 0006041                          
09-05-05 14:15 kSh            Issue Monitored: kSh                         
09-06-05 17:35 spiral         File Added: dmesgout.txt                     
09-06-05 17:36 spiral         Note Added: 0006047                          
09-06-05 20:17 1g0R           Note Added: 0006048                          
09-07-05 15:48 tiwai          Note Added: 0006056                          
09-07-05 17:25 spiral         Note Added: 0006059                          
09-07-05 17:26 spiral         Note Edited: 0006059                         
09-07-05 17:27 tiwai          Note Added: 0006060                          
09-07-05 17:28 spiral         Note Added: 0006061                          
09-07-05 17:35 tiwai          Note Added: 0006062                          
09-09-05 17:30 Twey           Note Added: 0006102                          
09-09-05 17:30 Twey           Note Edited: 0006102                         
09-09-05 17:31 Twey           Issue Monitored: Twey                        
09-09-05 17:48 tiwai          Note Added: 0006103                          
09-10-05 23:59 spiral         Note Added: 0006125                          
09-11-05 00:09 rlrevell       Note Added: 0006126                          
09-11-05 00:15 spiral         Note Added: 0006127                          
09-11-05 00:25 rlrevell       Note Added: 0006128                          
09-11-05 00:33 spiral         Note Added: 0006129                          
09-12-05 16:30 tiwai          Note Added: 0006146                          
09-13-05 15:53 spiral         Note Added: 0006153                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
