From: noreply@alsa-project.org
Subject: [ALSA - driver 0000391]: Built-in sound card not seen.
Date: Fri, 16 Jul 2004 00:21:16 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040715222116.A9E701C009@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id DCC1E23F
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 00:21:17 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id BD2B21240D
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 00:21:16 +0200 (MEST)
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


The following bug has been SUBMITTED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000391
======================================================================
Reported By:                PhilTR
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     391
Category:                   OTHERS
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.4.20-31.9
======================================================================
Date Submitted:             07-16-2004 00:21 CEST
Last Modified:              07-16-2004 00:21 CEST
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

Bug History
Date Modified  Username       Field                    Change              
======================================================================
07-16-04 00:21 PhilTR         New Bug                                      
07-16-04 00:21 PhilTR         Kernel Version            => 2.4.20-31.9     
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
