From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000365]: No audio with Asus p4p800-vm
Date: Fri, 25 Mar 2005 19:40:02 +0100
Message-ID: <4ceb63111def06bdedc9081d370891a9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 7D2AD1B1
	for <alsa-devel@alsa-project.org>; Fri, 25 Mar 2005 19:40:02 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=365> 
======================================================================
Reported By:                Anlar
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   365
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Gentoo - up to date stable
Kernel Version:             2.6.7
======================================================================
Date Submitted:             07-04-2004 20:53 CEST
Last Modified:              03-25-2005 19:40 CET
======================================================================
Summary:                    No audio with Asus p4p800-vm
Description: 
I have new Asus P4P800-VM motherboard (865G) that has i8x0 (x=1?) (ADI1980)
builtin. Alsa does seem to initialize, the required modules load and
something gets fed to the device but nothing comes out. I have played
around with the mixer volumes and done other known usual stuff as well.

A googling session revealed that some people have had success with this
motherboard but most of the people have failed. I thought that something
on this motherboard might be non-standard and require attention. 

(If it is trivial, something t be added to the wikis. I doubt though since
couple guys have tried already and none of them were complete newbies.)
======================================================================

----------------------------------------------------------------------
 jdthood - 03-23-05 16:09 
----------------------------------------------------------------------
The fact that OSS doesn't work either leads one to suspect a
hardware problem.

----------------------------------------------------------------------
 Anlar - 03-25-05 19:40 
----------------------------------------------------------------------
Works on all flavors of Windows. It's quite stunning actually. I spent a
lot time trying to find out any sane explanation but was unable to find
any. 

The spdif module (that I stole from P4PE mobo, those modules seem to be
more or less universal) works wonderfully so I am happy. I tried finding
any proof that some P4P800VM user would have got the analogs working.
Didn't find any. 

However the mobo is old already, never sold much (I guess) and it's not
imho worth digging more.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-04-04 20:53 Anlar          New Issue                                    
07-04-04 20:53 Anlar          Distribution              => Gentoo - up to date
stable
07-04-04 20:53 Anlar          Kernel Version            => 2.6.7           
07-04-04 20:54 Anlar          Issue Monitored: Anlar                       
07-06-04 22:04 Anlar          Note Added: 0001387                          
07-06-04 22:29 Anlar          File Added: asound.state                     
07-06-04 22:58 Anlar          Note Added: 0001389                          
07-06-04 22:59 Anlar          Note Edited: 0001389                         
07-07-04 17:32 Anlar          Note Edited: 0001389                         
07-07-04 22:02 Anlar          Note Added: 0001394                          
07-08-04 20:30 Anlar          Note Added: 0001395                          
07-08-04 20:31 Anlar          File Added: alsa                             
07-08-04 20:32 Anlar          File Added: alsa.conf                        
07-08-04 20:33 Anlar          Note Edited: 0001387                         
07-08-04 20:36 Anlar          Note Edited: 0001395                         
07-08-04 20:40 Anlar          Note Edited: 0001395                         
07-16-04 12:14 tiwai          Note Added: 0001447                          
07-16-04 20:09 Anlar          Note Added: 0001454                          
03-23-05 16:09 jdthood        Note Added: 0004175                          
03-25-05 19:40 Anlar          Note Added: 0004210                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
