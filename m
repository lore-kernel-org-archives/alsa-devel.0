From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001337]: AWE 32/64 driver crashes when using the skype program.
Date: Sun, 11 Sep 2005 03:32:06 +0200
Message-ID: <f68e58063f4502359599f64c105965a5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3090F195
	for <alsa-devel@alsa-project.org>; Sun, 11 Sep 2005 03:32:07 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1337> 
======================================================================
Reported By:                philneves
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1337
Category:                   ISA - sb16/sbawe
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
Distribution:               Slackware 10, and Redhat 7.3
Kernel Version:             2.4 series.
======================================================================
Date Submitted:             08-15-2005 03:20 CEST
Last Modified:              09-11-2005 03:32 CEST
======================================================================
Summary:                    AWE 32/64 driver crashes when using the skype
program.
Description: 
This is a serious bug with the sb16/sbawe driver. It seems to crash when
running the skype program. Problem can be reproduced on a regular basis.
Although frequency of occurence is random. Once the driver crashes it
disables all sound on my system and I must restart the computer to get the
sound back. Reloading the driver doesn't work. Problem occurs on all
versions of alsa and all versions of the 2.4 kernel. 





======================================================================

----------------------------------------------------------------------
 philneves - 09-11-05 03:24 
----------------------------------------------------------------------
I did another search of my dmesg file and was able to find the following
information 


isapnp: Scanning for PnP cards...
pnp: SB audio device quirk - increasing port range
pnp: AWE32 quirk - adding two ports
isapnp: Card 'Creative SB AWE64  PnP'
isapnp: 1 Plug & Play card detected total

----------------------------------------------------------------------
 philneves - 09-11-05 03:32 
----------------------------------------------------------------------
Ok thats it. Thats all the info I can find Or identify that might be
useful. Please let me know if there is any additional information that you
need.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-15-05 03:20 philneves      New Issue                                    
08-15-05 03:20 philneves      Distribution              => Slackware 10, and
Redhat 7.3
08-15-05 03:20 philneves      Kernel Version            => 2.4 series.     
08-24-05 07:09 philneves      Note Added: 0005924                          
09-09-05 02:34 philneves      Note Edited: 0005924                         
09-09-05 02:42 philneves      Note Added: 0006086                          
09-09-05 04:12 rlrevell       Note Added: 0006089                          
09-09-05 12:31 tiwai          Note Added: 0006094                          
09-11-05 01:36 philneves      Note Added: 0006131                          
09-11-05 01:49 philneves      Note Added: 0006132                          
09-11-05 03:08 philneves      Note Added: 0006134                          
09-11-05 03:24 philneves      Note Added: 0006135                          
09-11-05 03:32 philneves      Note Added: 0006136                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
