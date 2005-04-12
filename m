From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001045]: Cirrus Logic cs4236B
Date: Tue, 12 Apr 2005 17:17:36 +0200
Message-ID: <453e8cb1c573387642551b28bc091150@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C303127E
	for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2005 17:17:36 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1045> 
======================================================================
Reported By:                atiounkine
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1045
Category:                   ISA - cs4236
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Debian Sarge
Kernel Version:             2.6.11 Custom preempt SMP
======================================================================
Date Submitted:             04-11-2005 20:46 CEST
Last Modified:              04-12-2005 17:17 CEST
======================================================================
Summary:                    Cirrus Logic cs4236B
Description: 
Hello
  I can't insert a module of snd-cs4236  for my chip that detected by
"pnpdump" as CS4236B.

 I can use with snd-cs4232 but it have not a mic volume (it appear as mic
option w/o volume) and I cannot record with it.

 I can record with "Xandros Linux 1.0" with kernel "2.4.19-x1" and cs4232
OSS driver.

I will add more information about isapnp detection.
 Thanks.
======================================================================

----------------------------------------------------------------------
 atiounkine - 04-12-05 17:15 
----------------------------------------------------------------------
I have configured cs4236 with alsaconf and it's working!

 In alsaconf is necesary select only cs4236 and in this case will
configure it correctly.
 
  Before I tried  insert modules with "modprobe" and it print error "no
such device".
  Best regards

----------------------------------------------------------------------
 atiounkine - 04-12-05 17:17 
----------------------------------------------------------------------
And mic input and mic volume also working!

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-11-05 20:46 atiounkine     New Issue                                    
04-11-05 20:46 atiounkine     Distribution              => Debian Sarge    
04-11-05 20:46 atiounkine     Kernel Version            => 2.6.11 Custom preempt
SMP
04-11-05 20:49 atiounkine     Issue Monitored: atiounkine                    
04-12-05 17:15 atiounkine     Note Added: 0004453                          
04-12-05 17:17 atiounkine     Note Added: 0004454                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
