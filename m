From: bugtrack@alsa-project.org
Subject: [ALSA - plugins 0001324]: ALSA apps that use both playback and capture segfaults with plug:jack
Date: Tue, 9 Aug 2005 21:45:27 +0200
Message-ID: <d5c309c2e64b85e83ba7a28dbf0f866f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 626311E6
	for <alsa-devel@alsa-project.org>; Tue,  9 Aug 2005 21:45:27 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1324> 
======================================================================
Reported By:                b0ef
Assigned To:                
======================================================================
Project:                    ALSA - plugins
Issue ID:                   1324
Category:                   PCM - jack
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             08-09-2005 21:36 CEST
Last Modified:              08-09-2005 21:45 CEST
======================================================================
Summary:                    ALSA apps that use both playback and capture
segfaults with plug:jack
Description: 
I have applied realtime-preempt-2.6.13-rc4-RT-V0.7.51-38

ALSA apps that use both playback and capture segfaults with plug:jack

I have tested with several applications, primarily asterisk. 

I have not found any app that uses both playback and capture that works
with plug:jack. Normal playback and capture separate with plug:jack works
great. 
======================================================================

----------------------------------------------------------------------
 b0ef - 08-09-05 21:42 
----------------------------------------------------------------------
Anyways, I'll throw it in here

Let /etc/asterisk/alsa.conf use plug:jack

input_device=plug:jack
output_device=plug:jack

gdb /usr/sbin/asterisk 

r -vvvvpc

dial 2000

It then spits out: 

*CLI> dial 2004
[New Thread -1228231760 (LWP 22016)]
[New Thread -1227965520 (LWP 22015)]
    -- Executing Dial("ALSA/plug:jack",
"SIP/12220000000@proxy01.sipphone.com") in new stack

Use EXIT or QUIT to exit the asterisk console
*CLI> [Thread -1228231760 (LWP 22016) exited]
    -- Called 12220000000@proxy01.sipphone.com
    -- SIP/proxy01.sipphone.com-f2f0 answered ALSA/plug:jack
 << Console call has been answered >>

Program received signal SIGSEGV, Segmentation fault.
[Switching to Thread -1220076624 (LWP 21992)]
jack_activate (client=0x814cc08) at client.c:1611
1611    client.c: No such file or directory.
        in client.c

----------------------------------------------------------------------
 b0ef - 08-09-05 21:45 
----------------------------------------------------------------------
I wrote the wrong patch number. The patch I have applied is: 

realtime-preempt-2.6.13-rc4-RT-V0.7.52-02

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-09-05 21:36 b0ef           New Issue                                    
08-09-05 21:40 b0ef           Note Added: 0005736                          
08-09-05 21:42 b0ef           Note Added: 0005737                          
08-09-05 21:45 b0ef           Note Added: 0005738                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
