From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000509]: Conexant Moden "not ready"
Date: Sat, 19 Nov 2005 10:32:26 +0100
Message-ID: <ddb125a9fb5980cf603419f32ec1edb2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7377A16B
	for <alsa-devel@alsa-project.org>; Sat, 19 Nov 2005 10:32:26 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=509> 
======================================================================
Reported By:                gbilotta
Assigned To:                sashak
======================================================================
Project:                    ALSA - driver
Issue ID:                   509
Category:                   PCI - intel8x0m
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Debian GNU/Linux Testing
Kernel Version:             2.6.7
======================================================================
Date Submitted:             09-20-2004 19:20 CEST
Last Modified:              11-19-2005 10:32 CET
======================================================================
Summary:                    Conexant Moden "not ready"
Description: 
modprobing for snd_intel8x0m gives the following error:

MC'97 1 converters and GPIO not ready (0xff00)
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000857 intel8x0m does not work on asus a3n laptop
related to          0000890 no dialtone with modem &amp; strange lo...
======================================================================

----------------------------------------------------------------------
 sashak - 09-24-04 22:45 
----------------------------------------------------------------------
Data you see in win is from "customized" driver, so it should not be
problem.

Conexant link is useless - there is no related technical info - we need
the spec. Most likely it is not abaliable in public. I'll think how to
continue with it.

----------------------------------------------------------------------
 alonbl - 11-19-05 10:32 
----------------------------------------------------------------------
Hello,
Just wanted to know if a solution is on the way...
I have Conexant modem with intel8x0m... And can't use it without
proprietary binary drivers. ALSA is the best available solution!!!

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-20-04 19:20 gbilotta       New Issue                                    
09-20-04 19:20 gbilotta       File Added: asound.tar.bz2                    
09-20-04 19:20 gbilotta       Distribution              => Debian GNU/Linux
Testing
09-20-04 19:20 gbilotta       Kernel Version            => 2.6.7           
09-20-04 19:21 gbilotta       File Added: lspci.out                        
09-20-04 22:23 sashak         Note Added: 0001795                          
09-22-04 00:24 gbilotta       Note Added: 0001809                          
09-22-04 02:16 sashak         Note Added: 0001810                          
09-22-04 13:52 gbilotta       Note Added: 0001812                          
09-22-04 13:53 gbilotta       File Added: test.out                         
09-22-04 19:53 sashak         Note Added: 0001818                          
09-23-04 14:33 gbilotta       Note Added: 0001826                          
09-23-04 14:33 gbilotta       File Added: cat_regs                         
09-23-04 14:34 gbilotta       File Added: cat_regs2                        
09-24-04 03:07 sashak         Note Added: 0001853                          
09-24-04 13:30 gbilotta       Note Added: 0001880                          
09-24-04 13:32 gbilotta       Note Added: 0001881                          
09-24-04 22:45 sashak         Note Added: 0001905                          
03-02-05 14:12 perex          Relationship added       related to 0000857  
03-02-05 15:17 perex          Relationship added       related to 0000890  
08-30-05 12:26 jdthood        Severity                 block => major      
11-19-05 10:32 alonbl         Note Added: 0006762                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
