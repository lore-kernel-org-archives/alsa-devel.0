From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002199]: No sound from M-AUDIO
	Revolution 5.1
Date: Sun, 11 Jun 2006 22:01:01 +0200
Message-ID: <37173dcf4772b8ebf57011a34c451a06@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5DAC5149
	for <alsa-devel@alsa-project.org>;
	Sun, 11 Jun 2006 22:01:01 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2199> 
======================================================================
Reported By:                hlabs
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2199
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             06-09-2006 21:25 CEST
Last Modified:              06-11-2006 22:01 CEST
======================================================================
Summary:                    No sound from M-AUDIO Revolution 5.1
Description: 
M-AUDIO Revo 5.1
kernel 2.6.16
alsa 1.0.11

I got sound only from front channel.
Other channels doesn't works at all.

In alsamixer all outs unmuted and routed to pcm out.

======================================================================

----------------------------------------------------------------------
 hlabs - 06-11-06 19:40 
----------------------------------------------------------------------
Thanks a lot !

Also working HP out is necessary to me.
And what device corresponds to HP output ?

----------------------------------------------------------------------
 wollschaf - 06-11-06 22:01 
----------------------------------------------------------------------
The headphone output is not supported (yet), sadly. I use the rear channels
to drive my headphones which works fine (less noise than front speaker
output), but the built-in amplifier would be useful sometimes.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-09-06 21:25 hlabs          New Issue                                    
06-09-06 21:34 hlabs          Issue Monitored: hlabs                       
06-11-06 00:06 wollschaf      Note Added: 0010149                          
06-11-06 19:40 hlabs          Note Added: 0010152                          
06-11-06 22:01 wollschaf      Note Added: 0010153                          
======================================================================
