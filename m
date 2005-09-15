From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000263]: Maya44 MKII (Envy 24HT processor) probes correctly yet doesn't work.
Date: Thu, 15 Sep 2005 19:34:02 +0200
Message-ID: <aac8c0736b0d24c856d14cc842261d2c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1346B11E
	for <alsa-devel@alsa-project.org>; Thu, 15 Sep 2005 19:34:02 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=263> 
======================================================================
Reported By:                Vladimir Dyakov
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   263
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     acknowledged
Distribution:               ASPLinux 9.2 (base on Fedora Core 1)
Kernel Version:             kernel-2.6.5-mm6
======================================================================
Date Submitted:             05-08-2004 08:27 CEST
Last Modified:              09-15-2005 19:34 CEST
======================================================================
Summary:                    Maya44 MKII (Envy 24HT processor) probes correctly
yet doesn't work.
Description: 
I've got Audiotrak Maya44 MKII soundcard and Linux kernel-2.6.5-mm6 with
alsa-1.0.4rc2. If I am not mistaken my soundcard is base on Envy24HT
processor. There's a driver in alsa for this processor called ice1724.
It's written in it's source that it supports only Prodigy 7.1.

Is there any way to make driver work with my audio card?
======================================================================

----------------------------------------------------------------------
 Vladimir Dyakov - 04-09-05 15:03 
----------------------------------------------------------------------
> Submitter: Did you have better luck with later ALSA releases?
Nope, 1.0.8 seems not ot support AudioTrak Maya MKII

----------------------------------------------------------------------
 OnO - 09-15-05 19:34 
----------------------------------------------------------------------
Can anybody please update the driver to Maya 44 mkII ? Thanks.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-08-04 08:27 Vladimir DyakovNew Issue                                    
05-08-04 08:27 Vladimir DyakovDistribution              => ASPLinux 9.2 (base on
Fedora Core 1)
05-08-04 08:27 Vladimir DyakovKernel Version            => kernel-2.6.5-mm6
05-08-04 08:35 Vladimir DyakovNote Added: 0001070                          
05-11-04 07:03 Vladimir DyakovNote Added: 0001081                          
05-11-04 07:07 Vladimir DyakovNote Added: 0001082                          
05-18-04 20:44 tiwai          Note Added: 0001144                          
05-19-04 13:31 Vladimir DyakovNote Added: 0001151                          
05-19-04 13:35 Vladimir DyakovNote Added: 0001152                          
05-25-04 14:51 tiwai          Note Added: 0001212                          
05-26-04 04:33 Vladimir DyakovNote Added: 0001245                          
05-26-04 14:35 tiwai          Note Added: 0001256                          
05-31-04 05:26 Vladimir DyakovNote Added: 0001279                          
05-31-04 05:29 Vladimir DyakovNote Added: 0001280                          
06-17-04 06:51 Vladimir DyakovNote Added: 0001314                          
06-17-04 08:02 Apostolos DimitromanolakisNote Added: 0001315                    
     
06-17-04 08:39 Vladimir DyakovNote Added: 0001316                          
06-17-04 08:46 Vladimir DyakovNote Added: 0001317                          
06-18-04 18:02 Apostolos DimitromanolakisIssue Monitored: Apostolos
Dimitromanolakis                    
07-16-04 13:34 Vladimir DyakovNote Added: 0001452                          
04-08-05 22:26 jdthood        Note Added: 0004375                          
04-09-05 15:03 Vladimir DyakovNote Added: 0004404                          
04-09-05 16:04 jdthood        Status                   new => acknowledged 
09-15-05 19:34 OnO            Note Added: 0006219                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
