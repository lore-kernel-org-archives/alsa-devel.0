From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001728]: Modification of volume
	control for M-Audio Revolution 5.1
Date: Mon, 26 Jun 2006 13:35:53 +0200
Message-ID: <7b46283bc3d308f9932e68ddfb56469f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AD68E195
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Jun 2006 13:35:53 +0200 (MEST)
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
Last Modified:              06-26-2006 13:35 CEST
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
 alinja - 06-26-06 13:13 
----------------------------------------------------------------------
I'll fix the simple things and investigate how the other things should be
done when I have the time again. 

I wasn't sure about the index thing (or the orderin of the controls in
general) at all so I basically "guessed" what it should be. So making it 0
should be ok? I read some other reports that suggest some issues about the
ordering, maybe those could be fixed at the same time?

----------------------------------------------------------------------
 Raymond - 06-26-06 13:35 
----------------------------------------------------------------------
I don't have this card but other user complain "Left front channel always
muted on boot" in https://bugtrack.alsa-project.org/alsa-bug/view.php?id=321

It seem that the id of those index controls (DAC Volume and Deemphasis)
are not consecutive in asound.state

http://www.alsa-project.org/~iwai/writing-an-alsa-driver/x851.htm 

The index field holds the index number of this control. If there are
several different controls with the same name, they can be distinguished
by the index number. This is the case when several codecs exist on the
card. If the index is zero, you can omit the definition above.

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
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
