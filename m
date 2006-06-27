From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001728]: Modification of volume
	control for M-Audio Revolution 5.1
Date: Tue, 27 Jun 2006 15:10:52 +0200
Message-ID: <aab8774bee6d40c8b247c7459928859b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7F394267
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Jun 2006 15:10:52 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1728> 
======================================================================
Reported By:                cyan
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1728
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               gentoo testing
Kernel Version:             2.6.14-gentoo-r5
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             01-09-2006 23:35 CET
Last Modified:              06-27-2006 15:10 CEST
======================================================================
Summary:                    Modification of volume control for M-Audio
Revolution 5.1
Description: 
In Alsamixer (and KMix) is not possible to change volume of both chanels at
once. Slides with names "DAC" and "DAC1" corresponds to left and right
chanel. 
I would like to make a suggestion to merge them together.
======================================================================

----------------------------------------------------------------------
 alinja - 06-27-06 15:08 
----------------------------------------------------------------------
hlabs,

This patch fixes only the controls to have sane names and stereo
combinations. I got the left channel mute problem yesterday too (with
alinja2 patch). Are the channel names right on revo 5.1?

----------------------------------------------------------------------
 tiwai - 06-27-06 15:10 
----------------------------------------------------------------------
Yes, the mute problem at boot is a different issue from this topic.
It's probably the same root as the problem on revo 7.1, I2C/SPI protocol
problem.

Anyway, I applied the patch to HG repo now, so let's close this bug.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-09-06 23:35 cyan           New Issue                                    
01-09-06 23:35 cyan           Distribution              => gentoo testing  
01-09-06 23:35 cyan           Kernel Version            => 2.6.14-gentoo-r5
01-14-06 22:31 wollschaf      Note Added: 0007656                          
01-25-06 00:07 wollschaf      Issue Monitored: wollschaf                    
01-25-06 00:09 wollschaf      File Added: ak4xxx-adda-stereomixer.patch         
          
01-25-06 00:29 wollschaf      Note Added: 0007776                          
01-27-06 15:20 tiwai          Note Added: 0007804                          
02-02-06 15:15 alinja         Note Added: 0007877                          
03-28-06 14:22 alinja         Issue Monitored: alinja                      
06-15-06 19:41 alinja         File Added: ak4xx-volumes.patch                   

06-15-06 19:47 alinja         Note Added: 0010242                          
06-16-06 18:50 tiwai          Note Added: 0010256                          
06-24-06 10:43 Raymond        Note Added: 0010472                          
06-26-06 13:13 alinja         Note Added: 0010531                          
06-26-06 13:35 Raymond        Note Added: 0010533                          
06-26-06 15:38 Raymond        Note Edited: 0010533                         
06-26-06 15:57 tiwai          Note Added: 0010537                          
06-26-06 17:36 alinja         Note Added: 0010552                          
06-26-06 17:49 tiwai          Note Added: 0010554                          
06-26-06 21:36 alinja         File Added: ak4xx-volumes-alinja2.patch           
        
06-26-06 21:41 alinja         Note Added: 0010561                          
06-27-06 14:46 hlabs          Note Added: 0010592                          
06-27-06 14:47 hlabs          Note Edited: 0010592                         
06-27-06 15:08 alinja         Note Added: 0010593                          
06-27-06 15:10 tiwai          Status                   new => resolved     
06-27-06 15:10 tiwai          Resolution               open => fixed       
06-27-06 15:10 tiwai          Assigned To               => tiwai           
06-27-06 15:10 tiwai          Note Added: 0010594                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
