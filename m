From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000384]: Crackly PCM output.
Date: Tue, 18 Jan 2005 19:07:06 +0100
Message-ID: <8fc39a0a2ef52639d371d4998c181bdd@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B5A60236
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2005 19:07:06 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=384> 
======================================================================
Reported By:                bryanb
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   384
Category:                   PCI - ymfpci
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Gentoo dev sources
Kernel Version:             2.6
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             07-13-2004 19:28 CEST
Last Modified:              01-18-2005 19:07 CET
======================================================================
Summary:                    Crackly PCM output.
Description: 
When playing a sound through the speakers on Toshiba Tecra 8100 the only
sound produced is noise.
======================================================================

----------------------------------------------------------------------
 wallsga - 01-18-05 18:44 
----------------------------------------------------------------------
I patched up my alsa-driver-1.0.7 and things appear
to work.  The tecra8100.diff file contains
the changes, which came from the following sources:

ymfpci-novra.diff

ac97-default-rate-fix.diff

A CVS diff from the alsa project site:
   RCS file: /cvsroot/alsa/alsa-kernel/pci/ac97/ac97_codec.c,v
   diff -u -r1.160 -r1.161
   --- alsa/alsa-kernel/pci/ac97/ac97_codec.c	2004/12/27 13:24:29	1.160
   +++ alsa/alsa-kernel/pci/ac97/ac97_codec.c	2004/12/27 14:00:40	1.161

A line that I winged into ymfpci_main.c before the call to
snd_ac97_mixer():
   /* YMFPCI doesn't need VRA */
   chip->ac97_bus->no_vra = 1;

-Andy

----------------------------------------------------------------------
 tiwai - 01-18-05 19:07 
----------------------------------------------------------------------
OK then let's close this nasty bug ;)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-13-04 19:28 bryanb         New Issue                                    
07-13-04 19:28 bryanb         Distribution              => Gentoo dev sources
07-13-04 19:28 bryanb         Kernel Version            => 2.6             
07-29-04 22:43 codefathers    Note Added: 0001485                          
07-29-04 22:45 codefathers    Issue Monitored: codefathers                    
09-03-04 03:37 Derek_Burdick  Issue Monitored: Derek_Burdick                    
09-03-04 03:40 Derek_Burdick  Note Added: 0001684                          
10-23-04 23:24 c0ldevil       Note Added: 0002257                          
10-23-04 23:27 c0ldevil       Note Edited: 0002257                         
10-23-04 23:55 c0ldevil       Note Added: 0002259                          
10-23-04 23:56 c0ldevil       Note Added: 0002260                          
11-10-04 12:48 tiwai          Note Added: 0002369                          
11-17-04 18:14 c0ldevil       Note Added: 0002436                          
11-17-04 20:33 c0ldevil       Note Added: 0002442                          
11-17-04 20:39 rlrevell       Note Added: 0002443                          
11-18-04 14:30 tiwai          Note Added: 0002445                          
11-18-04 15:46 c0ldevil       Note Added: 0002446                          
11-18-04 15:56 c0ldevil       Note Added: 0002447                          
11-18-04 15:59 c0ldevil       File Added: dumps.zip                        
11-18-04 16:00 c0ldevil       Note Added: 0002448                          
11-18-04 19:44 tiwai          Note Added: 0002465                          
11-18-04 21:05 c0ldevil       Note Added: 0002471                          
11-18-04 21:29 c0ldevil       Note Edited: 0002471                         
11-22-04 14:24 wallsga        Note Added: 0002496                          
11-22-04 14:26 wallsga        Note Edited: 0002496                         
11-22-04 14:30 wallsga        Issue Monitored: wallsga                     
11-22-04 14:37 tiwai          Note Added: 0002498                          
11-23-04 16:14 wallsga        File Added: tecra8100-bug-data.tar.gz             
      
11-23-04 16:15 wallsga        Note Added: 0002520                          
12-16-04 22:44 wallsga        Note Added: 0002843                          
12-20-04 16:08 wallsga        Note Added: 0002883                          
12-20-04 16:10 wallsga        File Added: tecra8100demo.patch                   

12-20-04 16:11 wallsga        File Added: codec-init-seq.tar.gz                 
  
12-20-04 16:59 tiwai          Note Added: 0002887                          
12-20-04 17:00 tiwai          File Added: ac97-default-rate-fix.diff            
       
12-20-04 17:25 wallsga        Note Added: 0002888                          
12-20-04 17:27 wallsga        Note Edited: 0002888                         
12-20-04 17:37 tiwai          Note Added: 0002890                          
12-20-04 17:42 tiwai          Note Added: 0002892                          
12-20-04 17:43 tiwai          File Added: ymfpci-novra.diff                    
12-30-04 23:25 c0ldevil       Issue Monitored: c0ldevil                    
01-03-05 13:48 wallsga        Note Added: 0003059                          
01-03-05 14:27 tiwai          Note Added: 0003062                          
01-18-05 18:44 wallsga        Note Added: 0003257                          
01-18-05 18:45 wallsga        File Added: tecra8100.diff                    
01-18-05 19:07 tiwai          Status                   new => resolved     
01-18-05 19:07 tiwai          Resolution               open => fixed       
01-18-05 19:07 tiwai          Assigned To               => tiwai           
01-18-05 19:07 tiwai          Note Added: 0003258                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
