From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001377]: tons of unknown symbols with 2.6.13 final
Date: Sat, 10 Sep 2005 23:59:43 +0200
Message-ID: <61be16aaa02dcdf96a5ac9cfd59f401f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 39F0F14F
	for <alsa-devel@alsa-project.org>; Sat, 10 Sep 2005 23:59:44 +0200 (MEST)
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
Last Modified:              09-10-2005 23:59 CEST
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
 tiwai - 09-09-05 17:48 
----------------------------------------------------------------------
1g0R's case is irrelevant to the original report.  Don't mix up any more.

----------------------------------------------------------------------
 spiral - 09-10-05 23:59 
----------------------------------------------------------------------
tiwai :

I tried modprobe snd, & got an error message about device_mode, but I've
checked, I don't have any file in /etc (recursively) which still contains
"device_mode", so I don't know why modprobe still tries to pass this
option. When I do insmod snd.ko, this works fine, but I still get the same
unknown symbol messages when I try to modprobe snd-hda-intel (but the
message you asked me to look for in /proc/kallsysm is there, no problem).
I tried to insmod snd-hda-intel.ko also, but still got the unknown
symbols...

What's more, I just tried again today, with kernel 2.6.13.1 this time, and
with an updated cvs tree, & I've still got the same problem.

I hope you'll be able to help me.

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
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
