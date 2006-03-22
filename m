From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001572]: Simultaneous sound from speakers and headphone
Date: Wed, 22 Mar 2006 15:53:34 +0100
Message-ID: <aeb29e3c36c069b0bcf510b3bb7cfddf@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CEA501A6
	for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2006 15:53:34 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1572> 
======================================================================
Reported By:                mjsb
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1572
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo Linux
Kernel Version:             2.1.13-gentoo-r3
======================================================================
Date Submitted:             11-17-2005 16:31 CET
Last Modified:              03-22-2006 15:53 CET
======================================================================
Summary:                    Simultaneous sound from speakers and headphone
Description: 
I cannot ear headphones without having sound from front speakers
simultaneously.
Volume of headphones is adjusted by front speakers and when muting front
speakers also mutes headphones.
(in MS Windows, inserting headphones automatically disables sound from
front speakers)

======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0001663 LW20 bugs with headphone input, realtek...
======================================================================

----------------------------------------------------------------------
 mjsb - 03-22-06 15:06 
----------------------------------------------------------------------
OK. I managed to compile/install from CVS. (please delete my last
note#0008855)

The new model lg from hda-intel driver does not work on laptop LG LW20
Express:
There is sound from headphones, but no sound from front speakers, never!
So this bug still applies.

The files that I uploaded sometime ago to this bug report should be
helpfull to make sound work on this laptop.

----------------------------------------------------------------------
 tiwai - 03-22-06 15:53 
----------------------------------------------------------------------
Looks like the pin assingment is different.  Try to edit
alc880_lg_init_verbs[], alc880_lg_mixer[] and NIDs in alc880_lgauotmute().

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-17-05 16:31 mjsb           New Issue                                    
11-17-05 16:31 mjsb           Distribution              => Gentoo Linux    
11-17-05 16:31 mjsb           Kernel Version            => 2.1.13-gentoo-r3
11-17-05 16:33 mjsb           Issue Monitored: mjsb                        
12-08-05 21:23 mjsb           Note Added: 0006962                          
01-16-06 11:19 mjsb           Note Added: 0007685                          
01-19-06 18:27 rlrevell       Relationship added       has duplicate 0001663
01-21-06 03:24 mjsb           Note Added: 0007730                          
01-21-06 03:25 mjsb           File Added: HPoff-speakeron                    
01-21-06 03:25 mjsb           File Added: HPon-speakeroff                    
01-21-06 03:30 mjsb           Note Edited: 0007730                         
01-25-06 11:47 blackr2d       Issue Monitored: blackr2d                    
01-25-06 11:56 blackr2d       Note Added: 0007778                          
01-25-06 11:59 blackr2d       Note Edited: 0007778                         
01-25-06 12:00 blackr2d       Note Edited: 0007778                         
01-25-06 12:36 blackr2d       Note Edited: 0007778                         
02-14-06 05:36 richardfish    Issue Monitored: richardfish                    
02-14-06 05:37 richardfish    Note Added: 0008069                          
02-16-06 13:49 mjsb           Note Added: 0008096                          
03-01-06 18:00 mpt            Issue Monitored: mpt                         
03-15-06 15:36 tiwai          Note Added: 0008552                          
03-22-06 01:33 crissi         Note Added: 0008766                          
03-22-06 01:33 crissi         Issue Monitored: crissi                      
03-22-06 01:42 rlrevell       Note Added: 0008768                          
03-22-06 01:44 rlrevell       Note Added: 0008769                          
03-22-06 01:55 crissi         Note Added: 0008772                          
03-22-06 01:58 rlrevell       Note Added: 0008773                          
03-22-06 02:09 crissi         Note Added: 0008774                          
03-22-06 02:25 rlrevell       Note Added: 0008777                          
03-22-06 02:26 rlrevell       Note Deleted: 0008768                        
03-22-06 02:26 rlrevell       Note Deleted: 0008773                        
03-22-06 02:26 rlrevell       Note Deleted: 0008769                        
03-22-06 02:27 rlrevell       Note Deleted: 0008777                        
03-22-06 02:27 crissi         Note Added: 0008778                          
03-22-06 02:30 rlrevell       Note Added: 0008780                          
03-22-06 14:25 mjsb           Note Added: 0008855                          
03-22-06 15:06 mjsb           Note Added: 0008856                          
03-22-06 15:53 tiwai          Note Added: 0008860                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
