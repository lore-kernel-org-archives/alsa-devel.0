From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001176]: problem with alsa-driver and asus m5a notebook
Date: Fri, 26 Aug 2005 14:46:45 +0200
Message-ID: <88ae88d74f15725ef7c902c49024667d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 54B281E4
	for <alsa-devel@alsa-project.org>; Fri, 26 Aug 2005 14:46:45 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1176> 
======================================================================
Reported By:                Ballbreaker
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1176
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               gentoo
Kernel Version:             2.6.12-rc5
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             06-09-2005 13:44 CEST
Last Modified:              08-26-2005 14:46 CEST
======================================================================
Summary:                    problem with alsa-driver and asus m5a notebook
Description: 
I use gentoo-linux on an asus m5a notebook. Installation of alsa-driver
works without any error messages. xmms, aplay etc. play files, but i can't
hear anything. alsa-mixer shows me all the mixer-controls. I didn't forget
to unmute, and with windows sound is working fine - so i think there is a
problem with the alsa-driver and this notebook (on other notebooks with
the same sound-chip alsa is working).

I tried the following, always with the same results:
- compile alsa in the kernel
- compile alsa as kernel modules
- emerge alsa-driver (version 1.0.9-rc3 - 1.0.9-rc4 is not in portage
yet)
- compile alsa-driver manually (version 1.0.9-rc4)

Everything seems to work fine, but i can't hear anything, so maybe this is
a bug in the alsa-driver.
Would be great if somebody could tell me how i get alsa working on my
notebook  ;-)

Greetz,
thomas


======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001311 drivers load but unmuting channels / ad...
======================================================================

----------------------------------------------------------------------
 tiwai - 08-12-05 19:00 
----------------------------------------------------------------------
The message is usually a non-fatal one.  The next boot should be fine.

Your device is already listed on the table, so it should work as default,
at least with CVS version...

----------------------------------------------------------------------
 tiwai - 08-26-05 14:46 
----------------------------------------------------------------------
Let's close this.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-09-05 13:44 Ballbreaker    New Issue                                    
06-09-05 13:44 Ballbreaker    Distribution              => gentoo          
06-09-05 13:44 Ballbreaker    Kernel Version            => 2.6.12-rc5      
06-09-05 16:11 Ballbreaker    Issue Monitored: Ballbreaker                    
06-09-05 16:12 Ballbreaker    Issue End Monitor: Ballbreaker                    
06-09-05 16:19 Ballbreaker    Issue Monitored: Ballbreaker                    
08-05-05 08:39 perex          Relationship added       related to 0001311  
08-09-05 21:09 askel          Note Added: 0005735                          
08-11-05 14:26 tiwai          Note Added: 0005756                          
08-11-05 19:45 Ballbreaker    Note Added: 0005762                          
08-12-05 15:48 tiwai          Note Added: 0005774                          
08-12-05 15:54 askel          Note Edited: 0005735                         
08-12-05 15:55 askel          Note Edited: 0005735                         
08-12-05 18:09 Ballbreaker    Note Added: 0005784                          
08-12-05 18:17 tiwai          Note Added: 0005785                          
08-12-05 18:45 Ballbreaker    Note Added: 0005786                          
08-12-05 19:00 tiwai          Note Added: 0005788                          
08-26-05 14:46 tiwai          Status                   assigned => resolved
08-26-05 14:46 tiwai          Resolution               open => fixed       
08-26-05 14:46 tiwai          Note Added: 0005949                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
