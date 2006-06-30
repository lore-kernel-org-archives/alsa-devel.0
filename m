From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000324]: Audigy2 Platinum: very low
	volume (both in and out)
Date: Fri, 30 Jun 2006 18:22:26 +0200
Message-ID: <9ceca30faf1297ffd7f78d5c143e81a2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BB848265
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Jun 2006 18:22:26 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=324> 
======================================================================
Reported By:                garden
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   324
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Debian sid
Kernel Version:             2.6.5
======================================================================
Date Submitted:             06-06-2004 13:17 CEST
Last Modified:              06-30-2006 18:22 CEST
======================================================================
Summary:                    Audigy2 Platinum: very low volume (both in and out)
Description: 
Both the input and output levels of my Audigy2 Platinum seem to be very low
if compared to the same card with Windows (win98se). For example, I
connected an external source (a MD player with very loud music in the
disc) to the optical input, then to the aux input, then to the aux2 input.
With the mixer settings to 100% the input level still does not go over
20-25% of the maximum amplitude (while with Windows I have to lower the
input level or it will be too high). The same thing applies to the output
level of my analog speakers. [I must be *very* careful when I reboot with
Windows and must not forget to turn the volume knob from 10 to 2]. I had
exactly the same problem when I used the emu10k1 drivers from sourceforge.
======================================================================

----------------------------------------------------------------------
 killrbuckeye - 06-30-06 16:32 
----------------------------------------------------------------------
pzad: is this issue ever going to be addressed (we're approaching the
two-year mark), or should I just give up on using Linux for audio
recording with my Audigy?

----------------------------------------------------------------------
 jcdutton - 06-30-06 18:22 
----------------------------------------------------------------------
Known problem. The problem is due to the way sound is routed. This has been
fixed for one creative sound card so far. I will upload a patch to try
when I get a moment.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-06-04 13:17 garden         New Issue                                    
06-06-04 13:17 garden         Distribution              => Debian sid      
06-06-04 13:17 garden         Kernel Version            => 2.6.5           
06-28-04 09:17 pzad           Status                   new => assigned     
06-28-04 09:17 pzad           Assigned To               => pzad            
09-14-04 15:24 garden         Note Added: 0001758                          
09-16-04 10:16 pzad           Note Added: 0001766                          
09-16-04 11:32 garden         File Added: amixer.out                       
09-16-04 11:37 garden         Note Added: 0001769                          
09-16-04 12:17 pzad           Note Added: 0001772                          
09-16-04 13:23 garden         Note Added: 0001773                          
08-30-05 12:23 jdthood        Note Added: 0005975                          
08-30-05 12:32 garden         Note Added: 0005978                          
08-30-05 20:21 rlrevell       Note Added: 0005981                          
08-31-05 14:01 pzad           Note Added: 0005988                          
08-31-05 18:54 rlrevell       Note Added: 0005990                          
01-26-06 21:52 pzad           Note Added: 0007789                          
01-26-06 21:55 rlrevell       Note Added: 0007790                          
01-26-06 22:03 pzad           Note Added: 0007791                          
01-28-06 23:11 andred         Issue Monitored: andred                      
06-19-06 16:33 killrbuckeye   Note Added: 0010316                          
06-19-06 16:34 killrbuckeye   Issue Monitored: killrbuckeye                    
06-21-06 23:18 snover         Note Added: 0010409                          
06-21-06 23:19 snover         Issue Monitored: snover                      
06-21-06 23:19 snover         Note Edited: 0010409                         
06-30-06 16:32 killrbuckeye   Note Added: 0010739                          
06-30-06 16:34 pzad           Assigned To              pzad =>             
06-30-06 18:22 jcdutton       Note Added: 0010750                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
