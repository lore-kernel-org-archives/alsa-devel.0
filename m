From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001472]: Constant distortion noise on digital mixer
Date: Tue, 28 Feb 2006 14:50:01 +0100
Message-ID: <30d1e92df20fbb428c661439b82c6bf1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DF35D16C
	for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2006 14:50:01 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1472> 
======================================================================
Reported By:                Atraides
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1472
Category:                   PCI - ice1712
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Suse
Kernel Version:             2.6.11.4-21.9
======================================================================
Date Submitted:             10-12-2005 02:02 CEST
Last Modified:              02-28-2006 14:50 CET
======================================================================
Summary:                    Constant distortion noise on digital mixer
Description: 
The hardware in question is a Terratec DMX 6Fire 24/96. I have a constant
crackling (like an old UKW radio between to stations) on the digital
mixer. The noise disappears for a few seconds if I switch the Phono Input,
the Breakout LED or Line In Selector. It changes the noise character when
switching the S/PDIF Input from coaxial to optical. Even if all ins and
outs are muted or tracked down its still there (I can see it in the
Monitor Mixer).
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001785 ice1712 driver -cs8427 SPDIF chip not a...
======================================================================

----------------------------------------------------------------------
 alanmann - 02-14-06 22:06 
----------------------------------------------------------------------
Funny that! Neither of the patches mentioned here are in 1.0.11rc3 I am
sure, though they should be on CVS.  Particularly, without this patch, I
would expect the touch sensitivity to be present as previouly, even if it
is not noticable if not touched.  With this patch the sheilding can be
dispensed with.

----------------------------------------------------------------------
 Atraides - 02-28-06 14:50 
----------------------------------------------------------------------
Ok, my fault. I missed your question about the touch issue. My note was
about that distortion noise as mentioned in my bug report. That noise is
now gone with 1.0.10RC3. I will check your patch as soon as possible.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-12-05 02:02 Atraides       New Issue                                    
10-12-05 02:02 Atraides       Distribution              => Suse            
10-12-05 02:02 Atraides       Kernel Version            => 2.6.11.4-21.9   
10-12-05 13:50 tiwai          Note Added: 0006465                          
10-12-05 15:19 Atraides       Note Added: 0006467                          
10-13-05 10:19 alanmann       Note Added: 0006475                          
10-13-05 13:39 Atraides       Note Added: 0006477                          
10-14-05 11:48 Atraides       Note Edited: 0006477                         
10-14-05 12:55 alanmann       Note Added: 0006478                          
10-17-05 20:41 Atraides       Note Added: 0006488                          
02-02-06 22:03 alanmann       Note Added: 0007882                          
02-05-06 22:21 alanmann       Note Added: 0007942                          
02-05-06 22:22 alanmann       File Added: bug1472-dmx6fire-limit-to-6ADCs.patch 
                  
02-07-06 12:54 alanmann       File Added:
bug1472-dmx6fire-limit-to-6ADCs-v2.patch                    
02-07-06 12:56 alanmann       Note Added: 0007957                          
02-08-06 16:26 alanmann       Note Added: 0007966                          
02-08-06 16:27 alanmann       File Added:
bug1472-dmx6fire-limit-to-6ADCs-v3.patch                    
02-08-06 19:58 perex          Relationship added       related to 0001785  
02-12-06 14:55 Atraides       Note Added: 0008028                          
02-14-06 22:06 alanmann       Note Added: 0008070                          
02-28-06 14:50 Atraides       Note Added: 0008242                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
