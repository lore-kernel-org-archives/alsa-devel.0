From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001206]: No center channel; rear left and right are reversed; LFE on left front -- Asus P4P800-VM
Date: Tue, 1 Nov 2005 15:55:16 +0100
Message-ID: <734f31e75b9380184f0084ef56c94efa@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D83DCD2
	for <alsa-devel@alsa-project.org>; Tue,  1 Nov 2005 15:55:16 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1206> 
======================================================================
Reported By:                marcmerz
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1206
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Suse 9.3
Kernel Version:             Linux cinemaxx 2.6.11.4-20a-smp-matrox #1 SMP Fri
May 27 20:49:09 CEST 2005 i686 i686 i386 GNU/Linux
======================================================================
Date Submitted:             06-20-2005 20:39 CEST
Last Modified:              11-01-2005 15:55 CET
======================================================================
Summary:                    No center channel; rear left and right are reversed;
LFE on left front -- Asus P4P800-VM
Description: 
The same hardware (Asus P4P800-VM with an analog surround set from
creative) was working fine under Suse 9.1 with Kernel 2.6.5. I then had to
change my HD (/dev/hda) due to harddisk crash and installed Suse 9.3 with
Kernel 2.6.11.4-20a (where i included module support for my Matrox G400
everything else is default config). It came with ALSA 1.08. I already got
the sources from the alsa homepage and updated to the current versions
(1.09b, 1.09a and 1.09 for drivers, utils, libs, tools etc.).
 
Meanwhile i spent more than 7 days now to get my DD5.1 Surround working in
6-channel mode but to no avail. When i do the speaker test, the front left
and front right are ok. Rear Left comes from the Rear Right speaker and
Rear Right comes from the left rear speaker. The center channel does not
do any sounds at all and the LFE output is on the left front speaker.
 
I checked my wirings a couple of times. I do have 'normal' sound in KDE
playing MP3's etc. and i can also use the 'Spread Front to Surround/LFE'
switch in kmix to get some sound from all speakers including center and
lfe.
 
When i play AC3 testfiles with a52dec, the center is always off (i.e. not
to hear) and the lfe output is going to the front left speaker. With
ac3dec i get the same result but on top of it, using 'ac3dec -6' the sound
is crackling and therefore useless (btw. this was also the case with Alsa
1.04|5 under Suse 9.1 with Kernel 2.6.5).
 
I can not believe that the same setup did work flawlessly under ALSA 1.05
and with a new kernel and current source drivers from the alsa project
homepage it is just not working in DD5.1.
 
Maybe there is a configuration mistake concerning plug:surround51 sending
output to the wrong channels but a) i did not change anything there and b)
i have no clue how to do that anyway.
 
Any help would be greatly appreciated.

======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0001191 Center channel and 32-bit emulation bro...
related to          0001501 intel8x0 surround channels missing and ...
related to          0001521 Speakers misplaced in 5.1 surround
======================================================================

----------------------------------------------------------------------
 rraptorr - 08-22-05 15:55 
----------------------------------------------------------------------
What the hell is happening here?
P4P800-VM motherboard DOES NOT HAVE NFORCE chipset.
It can be checked easily by strace -f -e open. It is not even touching
NFORCE.conf, it uses ICH4.conf. I've also downgraded whole alsa-lib to
1.0.8, no change at all. The only working solution is disabling lines with
pbus->dra = 1;.
It looks like the NFORCE issue was by mistake marked as a duplicate of
this one.
I can provide further hardware information if needed. I have access to
this MoBO only from time to time, so I can't say anything more right now.

PS. Will try 1.0.10rc1 as soon as possible.



----------------------------------------------------------------------
 jdthood - 11-01-05 15:55 
----------------------------------------------------------------------
some-settings.txt is the pile of information originally
appended to the original bug report.  For readability
I have put it in an attachment.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-20-05 20:39 marcmerz       New Issue                                    
06-20-05 20:39 marcmerz       Distribution              => Suse 9.3        
06-20-05 20:39 marcmerz       Kernel Version            => Linux cinemaxx
2.6.11.4-20a-smp-matrox #1 SMP Fri May 27 20:49:09 CEST 2005 i686 i686 i386
GNU/Linux
06-21-05 11:26 tiwai          Note Added: 0005105                          
06-21-05 20:29 marcmerz       Note Added: 0005113                          
06-22-05 01:08 marcmerz       Note Added: 0005115                          
06-22-05 01:20 marcmerz       Note Added: 0005116                          
06-22-05 01:43 rlrevell       Note Added: 0005117                          
06-22-05 10:04 pzad           Note Added: 0005119                          
06-22-05 11:49 tiwai          Note Added: 0005124                          
06-22-05 11:53 tiwai          Note Added: 0005125                          
06-22-05 12:37 marcmerz       Note Added: 0005127                          
06-22-05 12:44 tiwai          Note Added: 0005128                          
06-22-05 12:48 tiwai          Note Added: 0005129                          
06-22-05 12:51 marcmerz       Note Added: 0005130                          
06-22-05 12:55 marcmerz       Note Added: 0005131                          
06-22-05 18:03 tiwai          Note Added: 0005138                          
06-22-05 19:55 marcmerz       File Added: ac97#0-0                         
06-22-05 19:55 marcmerz       File Added: ac97#0-0+regs                    
06-22-05 19:55 marcmerz       Note Added: 0005146                          
06-22-05 19:57 marcmerz       File Added: alsasound                        
06-22-05 20:18 rraptorr       Note Added: 0005147                          
06-22-05 20:19 rraptorr       File Added: codec97                          
06-22-05 20:34 rraptorr       Note Added: 0005148                          
06-22-05 20:35 rraptorr       Note Edited: 0005147                         
06-22-05 20:35 rraptorr       Note Deleted: 0005148                        
06-22-05 20:50 rraptorr       Issue Monitored: rraptorr                    
06-22-05 21:06 marcmerz       Note Edited: 0005146                         
06-22-05 21:13 marcmerz       Note Added: 0005149                          
06-22-05 21:17 rlrevell       Note Added: 0005150                          
06-22-05 21:18 marcmerz       File Added: codec97-marcmerz                    
06-22-05 21:26 rraptorr       Note Added: 0005151                          
06-22-05 22:24 marcmerz       Note Added: 0005152                          
06-22-05 22:32 rraptorr       Note Added: 0005153                          
06-22-05 22:59 marcmerz       Note Edited: 0005152                         
06-23-05 20:21 marcmerz       Note Added: 0005194                          
06-26-05 19:45 marcmerz       Issue Monitored: tiwai                       
06-26-05 19:45 marcmerz       Note Added: 0005265                          
06-28-05 10:49 perex          Assigned To              perex =>            
06-28-05 10:49 perex          Category                 0_compilation problem_!!!
=> PCI - intel8x0
07-10-05 19:57 phision        Issue Monitored: phision                     
07-10-05 20:08 phision        Note Added: 0005443                          
08-18-05 21:03 robert         Note Added: 0005852                          
08-18-05 21:05 robert         File Added: NFORCE.conf                      
08-18-05 21:27 rlrevell       Note Added: 0005854                          
08-18-05 21:32 rlrevell       Relationship added       duplicate of 0001191
08-18-05 21:56 marcmerz       Note Added: 0005856                          
08-18-05 22:03 rlrevell       File Added: nforce.patch                     
08-18-05 22:07 rlrevell       Note Added: 0005857                          
08-22-05 15:47 rraptorr       Note Added: 0005898                          
08-22-05 15:55 rraptorr       Note Edited: 0005898                         
09-29-05 12:36 jdthood        Summary                  No Surround Sound (5.1)
with analog speaker set on ASUS P4P800-VM and Suse 9.3 (Kernel 26.11.4-20a) =>
No center channel; rear left and right are reversed; LFE on left front -- Asus
P4P800-VM
11-01-05 15:28 jdthood        Relationship added       related to 0001521  
11-01-05 15:43 jdthood        Relationship added       related to 0001501  
11-01-05 15:53 jdthood        Description Updated                          
11-01-05 15:54 jdthood        File Added: some-settings.txt                    
11-01-05 15:55 jdthood        Note Added: 0006596                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
