From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000384]: Crackly PCM output.
Date: Mon, 3 Jan 2005 14:27:22 +0100
Message-ID: <6118787adf9d68143710be81af649fff@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 63AD62D3
	for <alsa-devel@alsa-project.org>; Mon,  3 Jan 2005 14:27:22 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=384> 
======================================================================
Reported By:                bryanb
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   384
Category:                   PCI - ymfpci
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Gentoo dev sources
Kernel Version:             2.6
======================================================================
Date Submitted:             07-13-2004 19:28 CEST
Last Modified:              01-03-2005 14:27 CET
======================================================================
Summary:                    Crackly PCM output.
Description: 
When playing a sound through the speakers on Toshiba Tecra 8100 the only
sound produced is noise.
======================================================================

----------------------------------------------------------------------
 wallsga - 01-03-05 13:48 
----------------------------------------------------------------------
Neither "ac97-default-rate-fix.diff" nor "ymfpci-novra.diff" 
solved the problem.

Testing using the /proc interface with "tecra8100demo.patch"
in place revealed:

   - turing VRA on & off without changing the rate did not induce the
problem

   - turning on VRA and changing the rate in register 0x2c away from 48
Khz 
        and then back to 48 KHz always induced the problem (except in one
trial)

   - trying to set the rate back to 48 Khz and/or turning off VRA does
not
        make the problem go away, once induced


I conclude that simply changing the rate induces the problem.  Once
induced
the problem cannot be reversed except via chipset reset.  To date it
appears that
the only solution for this laptop is to prevent VRA rate changes
altogether (including the probe).


I'd be happy with an ac97_codec module option to prevent VRA rate probes
and enables.


I wanted to test more, like not allowing the modem rate register (0x32?)
to change,
since I don't think it's a valid register for this chip, and then see if
VRA works.
But honestly, I don't have the time.

----------------------------------------------------------------------
 tiwai - 01-03-05 14:27 
----------------------------------------------------------------------
The latest CVS already includes the change for ac97_codec.c.  The rate
detection is no longer performed for non-vra case.
Please give a try.

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
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
