From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002000]: Sound continually cuts in and out
Date: Mon, 17 Apr 2006 16:42:39 +0200
Message-ID: <72e7b09381a7a19610e7bd439223bca1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F0B1317C
	for <alsa-devel@alsa-project.org>; Mon, 17 Apr 2006 16:42:39 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2000> 
======================================================================
Reported By:                spm
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2000
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
Distribution:               Ubuntu 5.10 Breezy
Kernel Version:             2.6.12-10-386
======================================================================
Date Submitted:             04-04-2006 19:22 CEST
Last Modified:              04-17-2006 16:42 CEST
======================================================================
Summary:                    Sound continually cuts in and out
Description: 
And it makes a pop sound when cutting out.

I thought it was an IRQ conflict, but it is not (I checked with "cat
/proc/interrupts".

This actually started to occur after plugging in a USB mouse. Mouse is no
longer in, but problem persists. I have redone "alsaconf" problem still
persists...pulling my hair out here...
======================================================================

----------------------------------------------------------------------
 spm - 04-14-06 22:07 
----------------------------------------------------------------------
Just noticed something...

cat: /proc/asound/hwdep: No such file or directory

Is that normal?  

Help please...this is driving me batty...

----------------------------------------------------------------------
 spm - 04-17-06 16:42 
----------------------------------------------------------------------
I have provided a lot...can anybody help?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-04-06 19:22 spm            New Issue                                    
04-04-06 19:22 spm            Distribution              => Ubuntu 5.10 Breezy
04-04-06 19:22 spm            Kernel Version            => 2.6.12-10-386   
04-04-06 19:45 rlrevell       Note Added: 0009114                          
04-14-06 04:22 spm            Note Added: 0009281                          
04-14-06 22:06 spm            Note Added: 0009288                          
04-14-06 22:07 spm            Note Added: 0009289                          
04-17-06 16:42 spm            Note Added: 0009313                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
