From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001728]: Modification of volume
	control for M-Audio Revolution 5.1
Date: Thu, 15 Jun 2006 19:47:41 +0200
Message-ID: <781e26f108492de2137a1611e094e0ca@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2F82A179
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Jun 2006 19:47:42 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1728> 
======================================================================
Reported By:                cyan
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1728
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               gentoo testing
Kernel Version:             2.6.14-gentoo-r5
======================================================================
Date Submitted:             01-09-2006 23:35 CET
Last Modified:              06-15-2006 19:47 CEST
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
 alinja - 02-02-06 15:15 
----------------------------------------------------------------------
Is second this suggestion. I consider the current implementation with
independent channel volumes broken (especially as there is no master
volume). I already had decided to make a similar patch, but I'm glad I
found this.

----------------------------------------------------------------------
 alinja - 06-15-06 19:47 
----------------------------------------------------------------------
Sorry that I add this a bit late... I hacked up a modification that allows
per-card configuration of the mixer settings. I also changed the main
channel name to PCM on revolution 7.1. I have only tested this on my 7.1,
I hope I ot thing right on the other cards.

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
======================================================================
