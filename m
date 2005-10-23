From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000992]: no supported card
Date: Sun, 23 Oct 2005 19:47:06 +0200
Message-ID: <5c765a47035d8bbe99fd57731d253f99@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 43976144
	for <alsa-devel@alsa-project.org>; Sun, 23 Oct 2005 19:47:07 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=992> 
======================================================================
Reported By:                rav0r
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   992
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     feedback
Distribution:               
Kernel Version:             2.4
======================================================================
Date Submitted:             03-14-2005 21:52 CET
Last Modified:              10-23-2005 19:47 CEST
======================================================================
Summary:                    no supported card
Description: 
I am not sure what model my s.card is. I only know it's ct4830 , 4.1 .Will
this model ever be supported?
======================================================================

----------------------------------------------------------------------
 jcdutton - 09-10-05 13:16 
----------------------------------------------------------------------
This card should be supported.
try the troubleshooter on: http://alsa.opensrc.org/TroubleShooting

----------------------------------------------------------------------
 jcdutton - 10-23-05 19:47 
----------------------------------------------------------------------
lspci is used to detect your sound card.
You don't seem to have it installed.
install pciutils.
The ./configure should then work fine.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-14-05 21:52 rav0r          New Issue                                    
03-14-05 21:52 rav0r          Kernel Version            => 2.4             
03-14-05 22:57 mikma          Note Added: 0003910                          
03-15-05 23:13 rav0r          Note Added: 0003925                          
03-16-05 11:05 mikma          Note Added: 0003935                          
03-17-05 00:51 rav0r          Note Added: 0003974                          
03-20-05 19:14 rav0r          Note Added: 0004096                          
03-20-05 20:28 mikma          Note Added: 0004099                          
03-21-05 03:32 rav0r          File Added: config.log                       
03-21-05 03:33 rav0r          Note Added: 0004112                          
03-21-05 03:33 rav0r          Note Added: 0004113                          
03-21-05 15:44 mikma          Note Added: 0004118                          
03-21-05 17:13 rav0r          Note Added: 0004120                          
04-06-05 18:15 rav0r          Note Added: 0004347                          
04-06-05 18:16 rav0r          Note Added: 0004348                          
04-06-05 18:40 jcdutton       Note Added: 0004349                          
04-06-05 18:40 jcdutton       Status                   assigned => feedback
04-07-05 12:54 rav0r          Note Added: 0004355                          
04-07-05 12:55 rav0r          Note Added: 0004356                          
04-11-05 13:30 rav0r          Note Edited: 0004356                         
06-06-05 10:03 perex          Assigned To              perex => jcdutton   
06-06-05 10:03 perex          Category                 0_compilation problem_!!!
=> PCI - emu10k1
09-10-05 13:16 jcdutton       Note Added: 0006119                          
10-23-05 19:47 jcdutton       Note Added: 0006516                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
