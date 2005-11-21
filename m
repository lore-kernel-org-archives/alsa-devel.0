From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000749]: Buzz from ALSA setup
Date: Mon, 21 Nov 2005 20:37:45 +0100
Message-ID: <707233437390608fbf561a87b3c2f005@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 521C6172
	for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2005 20:37:45 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=749> 
======================================================================
Reported By:                misnagid
Assigned To:                pzad
======================================================================
Project:                    ALSA - driver
Issue ID:                   749
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora FC3
Kernel Version:             2.6.9
======================================================================
Date Submitted:             12-26-2004 15:37 CET
Last Modified:              11-21-2005 20:37 CET
======================================================================
Summary:                    Buzz from ALSA setup
Description: 
I get an almost constant buzz from speakers when I've tried to use ALSA. 
Have followed your directions from the online web page directions to the
letter.  Still buzz.
Have brought all sound levels up ising alsamixer and Kmix.  Of no help. 
Have tried everything I've seen about this problem.
OnBoard NVidia audio from Asus A7N8X-E Deluxe disabled.  Using emu10k1
driver for installed Creative Labs Audigy 2 soundcard. This is a brand new
successful in all other regards install of Fedora FC3.

======================================================================

----------------------------------------------------------------------
 misnagid - 11-21-05 20:29 
----------------------------------------------------------------------
The output is:
Advanced Linux Sound Architecture Driver Version 1.0.10rc1 (Mon Sep 12
08:13:09 2005 UTC).

----------------------------------------------------------------------
 pzad - 11-21-05 20:37 
----------------------------------------------------------------------
I checked log and there was fixed one bug ("Problem manifests as noise
when
using more than 2GB of RAM"), but this was fixed in 1.0.10rc3 (not in
1.0.10rc1).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-26-04 15:37 misnagid       New Issue                                    
12-26-04 15:37 misnagid       Distribution              => Fedora FC3      
12-26-04 15:37 misnagid       Kernel Version            => 2.6.9           
12-26-04 15:58 pzad           Note Added: 0002935                          
12-26-04 16:31 misnagid       Note Added: 0002936                          
12-26-04 16:44 misnagid       Note Added: 0002937                          
12-26-04 16:56 pzad           Note Added: 0002938                          
12-26-04 17:47 misnagid       Note Added: 0002939                          
12-26-04 18:07 misnagid       Note Added: 0002940                          
12-26-04 18:17 misnagid       Note Added: 0002942                          
12-26-04 18:38 misnagid       Note Added: 0002943                          
12-26-04 19:27 pzad           Note Added: 0002944                          
12-26-04 19:44 misnagid       File Added: test.state                       
12-26-04 19:44 misnagid       Note Added: 0002945                          
12-26-04 20:02 misnagid       Note Added: 0002946                          
12-26-04 20:09 misnagid       Note Added: 0002947                          
12-26-04 20:22 pzad           File Added: newtest.state                    
12-26-04 20:27 pzad           Note Added: 0002948                          
12-26-04 20:32 pzad           Note Added: 0002949                          
12-26-04 20:59 misnagid       Note Added: 0002950                          
12-26-04 21:11 misnagid       Note Added: 0002951                          
12-26-04 21:19 pzad           Note Added: 0002952                          
12-26-04 21:22 pzad           Note Added: 0002953                          
12-26-04 21:43 misnagid       Note Added: 0002954                          
12-26-04 21:47 pzad           Note Added: 0002955                          
12-26-04 22:18 misnagid       Note Added: 0002956                          
12-26-04 23:46 misnagid       Note Added: 0002957                          
12-27-04 10:46 pzad           Note Added: 0002958                          
12-27-04 16:33 misnagid       Note Added: 0002964                          
12-27-04 16:34 misnagid       File Added: test2.state                      
12-27-04 16:38 misnagid       Note Added: 0002965                          
12-27-04 16:45 pzad           Note Added: 0002966                          
12-27-04 16:58 misnagid       Note Added: 0002967                          
12-27-04 16:58 misnagid       File Added: test3.state                      
12-27-04 17:42 misnagid       Note Added: 0002968                          
12-27-04 17:57 misnagid       Note Added: 0002969                          
12-27-04 18:16 pzad           Note Added: 0002970                          
12-27-04 18:43 misnagid       Note Added: 0002971                          
12-27-04 19:27 misnagid       Note Added: 0002972                          
12-27-04 21:09 misnagid       Note Added: 0002975                          
12-27-04 21:31 pzad           Note Added: 0002976                          
12-27-04 21:47 misnagid       Note Added: 0002977                          
12-27-04 21:49 misnagid       Note Added: 0002978                          
12-27-04 22:00 pzad           Note Added: 0002979                          
12-27-04 22:29 misnagid       Note Added: 0002980                          
12-27-04 22:54 pzad           Note Added: 0002981                          
12-27-04 23:15 misnagid       Note Added: 0002982                          
12-27-04 23:19 misnagid       Note Added: 0002983                          
12-27-04 23:46 pzad           Note Added: 0002984                          
12-27-04 23:48 misnagid       Note Added: 0002985                          
12-28-04 21:13 rlrevell       Note Added: 0002987                          
01-03-05 00:36 misnagid       Note Added: 0003049                          
01-03-05 15:10 pzad           Note Added: 0003064                          
01-09-05 00:27 misnagid       Note Added: 0003132                          
01-11-05 10:36 pzad           Note Added: 0003141                          
01-11-05 11:24 misnagid       Note Added: 0003142                          
01-11-05 23:20 misnagid       Note Added: 0003159                          
04-22-05 11:04 stransky       Note Added: 0004553                          
08-24-05 00:55 lonerider      Note Added: 0005921                          
11-16-05 15:58 misnagid       Note Added: 0006741                          
11-16-05 16:03 misnagid       Note Added: 0006742                          
11-16-05 16:10 pzad           Note Added: 0006743                          
11-20-05 07:29 misnagid       Note Added: 0006763                          
11-20-05 09:16 pzad           Note Added: 0006764                          
11-20-05 13:23 misnagid       Note Added: 0006766                          
11-21-05 19:53 rlrevell       Note Added: 0006774                          
11-21-05 20:29 misnagid       Note Added: 0006775                          
11-21-05 20:37 pzad           Note Added: 0006776                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
