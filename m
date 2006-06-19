From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002159]: ac3 passthrough not working
	on recent versions
Date: Mon, 19 Jun 2006 22:10:22 +0200
Message-ID: <993458a8c657e2791aa741f2f45bf56b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 09589153
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Jun 2006 22:10:22 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2159> 
======================================================================
Reported By:                nikke
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   2159
Category:                   PCI - ymfpci
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     feedback
Distribution:               Debian
Kernel Version:             2.6.15
======================================================================
Date Submitted:             05-24-2006 23:44 CEST
Last Modified:              06-19-2006 22:10 CEST
======================================================================
Summary:                    ac3 passthrough not working on recent versions
Description: 
Using the following AC3 passthrough with mplayer works:
Linux 2.4.31
alsa-driver 1.0.8-7 (debian stable packaged)

Using Linux 2.6.15 (both with alsa-driver 1.10rc3 that ships with the
kernel and
alsa-driver 1.0.11) it doesn't work. The reciever just says "unlock" and
stays quiet.

The only change is booting with different kernels, no other config or
hardware is touched, so this must be a driver regression.

The card is YMF-754 based, connected with coax spdif to my HK reciever.

If you need more info, just tell me and I'll dig it up.
======================================================================

----------------------------------------------------------------------
 nikke - 06-19-06 21:43 
----------------------------------------------------------------------
Euh. Now I'm confused.

My interpretion of the docs are that default options in 1.0.11 are to do
output so AC3 works. This seems like a sane behaviour to me, since AC3 has
worked before and there are probably more users of AC3 surround than
analog output surround.

Also, I have tried 1.0.11 both with rear_swap=0 and =1
(using modprobe snd-ymfpci rear_swap=X)
and neither works.

Am I missing something obvious?

----------------------------------------------------------------------
 Mimosius - 06-19-06 22:10 
----------------------------------------------------------------------
Hi nikke, Clemens, Raymond, ...

I totally agree, module option "rear_swap", doesn't fix the problem. I had
already send a mail to the alsa-devel mailinglist with CC to Clemens.
At the moment I'm very busy, so I've not much time, maybe next week...

greets from Magdeburg - Germany,
Glen

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-24-06 23:44 nikke          New Issue                                    
05-24-06 23:44 nikke          Distribution              => Debian          
05-24-06 23:44 nikke          Kernel Version            => 2.6.15          
05-24-06 23:47 nikke          Issue Monitored: nikke                       
06-02-06 04:23 Raymond        Note Added: 0010045                          
06-02-06 04:25 Raymond        Note Edited: 0010045                         
06-12-06 13:14 Mimosius       Issue Monitored: Mimosius                    
06-14-06 22:32 nikke          Note Added: 0010216                          
06-15-06 02:18 Raymond        Note Added: 0010221                          
06-15-06 02:27 Raymond        Note Edited: 0010221                         
06-15-06 11:03 Mimosius       Note Added: 0010237                          
06-15-06 23:43 nikke          Note Added: 0010246                          
06-16-06 13:01 Mimosius       Note Added: 0010250                          
06-16-06 13:16 Mimosius       Note Edited: 0010250                         
06-16-06 13:26 Raymond        Note Added: 0010251                          
06-16-06 13:31 Raymond        Note Edited: 0010251                         
06-16-06 13:37 Mimosius       Note Added: 0010252                          
06-16-06 16:25 Raymond        Note Added: 0010255                          
06-17-06 01:17 nikke          Note Added: 0010262                          
06-17-06 02:43 Raymond        Note Edited: 0010251                         
06-17-06 10:21 Raymond        Note Added: 0010266                          
06-17-06 10:24 Raymond        Note Edited: 0010266                         
06-17-06 11:02 Raymond        Note Added: 0010267                          
06-17-06 14:25 Raymond        Note Added: 0010268                          
06-17-06 15:16 nikke          Note Added: 0010269                          
06-17-06 16:10 Raymond        Note Added: 0010270                          
06-17-06 16:23 Raymond        Note Edited: 0010270                         
06-17-06 18:22 rlrevell       Note Added: 0010280                          
06-18-06 04:03 Raymond        Note Added: 0010295                          
06-18-06 04:08 Raymond        Note Edited: 0010295                         
06-18-06 04:14 Raymond        Note Edited: 0010295                         
06-18-06 13:30 Raymond        Note Edited: 0010295                         
06-19-06 13:11 Clemens LadischStatus                   new => assigned     
06-19-06 13:11 Clemens LadischAssigned To               => Clemens Ladisch 
06-19-06 13:33 Clemens LadischStatus                   assigned => resolved
06-19-06 13:33 Clemens LadischResolution               open => not fixable 
06-19-06 13:33 Clemens LadischNote Added: 0010307                          
06-19-06 21:43 nikke          Status                   resolved => feedback
06-19-06 21:43 nikke          Resolution               not fixable => reopened
06-19-06 21:43 nikke          Note Added: 0010320                          
06-19-06 22:10 Mimosius       Note Added: 0010321                          
======================================================================
