From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000391]: Built-in sound card not seen.
Date: Fri, 7 Jan 2005 18:29:01 +0100
Message-ID: <b2087e32512f4fc220ae6f027ed318a7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 7505F24F
	for <alsa-devel@alsa-project.org>; Fri,  7 Jan 2005 18:29:01 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=391> 
======================================================================
Reported By:                PhilTR
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   391
Category:                   OTHERS
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             2.4.20-31.9
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             07-16-2004 00:21 CEST
Last Modified:              01-07-2005 18:29 CET
======================================================================
Summary:                    Built-in sound card not seen.
Description: 
I can't say that this is really a bug although its got me bugged. I
installed a new mother board (GA-8IPE 1000 Pro) which has a built-in
RealTek sound card:
02:01.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139
C+ (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Flags: bus master, medium devsel, latency 32, IRQ 5
        I/O ports at 9000 [size=256]
        Memory at fb004000 (32-bit, non-prefetchable)       [size=256]
        Capabilities: [50] Power Management version 2

Linux dutifully loaded w/o incident and after loggin in I received the
following error message: 'Couldn't open mixer device /dev/sound/mixer" 

I've been receiving help at <a
href="http://www.linuxquestions.org/questions/showthread.php?s=&threadid=203196&perpage=15&pagenumber=1">LinuxQuestions.org<a/>
but, to get to the point, I'm wondering if anyone here has a fix? I've
downloaded "alsa-xxxx-1.0.5" (firmware is: 1.0.4) Set-up proceeded w/o
incident. Running "alsaconf" got me: "No supported PnP or PCI card dound"
and "No legacy drivers found." 

Your kind patience is appreciated. philtr (rabne@pipeline.com)

======================================================================

----------------------------------------------------------------------
 PhilTR - 01-01-05 19:51 
----------------------------------------------------------------------
Problem fixed with new sound card that was not plug-n-pray.

----------------------------------------------------------------------
 tiwai - 01-07-05 18:29 
----------------------------------------------------------------------
OK, closing this now.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-16-04 00:21 PhilTR         New Issue                                    
07-16-04 00:21 PhilTR         Kernel Version            => 2.4.20-31.9     
07-16-04 11:55 tiwai          Note Added: 0001440                          
07-24-04 21:00 PhilTR         Note Added: 0001472                          
07-30-04 17:09 tiwai          Note Added: 0001495                          
01-01-05 19:51 PhilTR         Note Added: 0003034                          
01-07-05 18:29 tiwai          Status                   new => resolved     
01-07-05 18:29 tiwai          Resolution               open => not an issue
01-07-05 18:29 tiwai          Assigned To               => tiwai           
01-07-05 18:29 tiwai          Note Added: 0003113                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
