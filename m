From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000172]: Master volume control only controls front speakers
Date: Fri, 10 Mar 2006 03:20:16 +0100
Message-ID: <0a1c6e5bccb6c02cad038003d6b71481@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8F12E18C
	for <alsa-devel@alsa-project.org>; Fri, 10 Mar 2006 03:20:16 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=172> 
======================================================================
Reported By:                gruberroland
Assigned To:                perex
======================================================================
Project:                    ALSA - lib
Issue ID:                   172
Category:                   2_mixer
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
======================================================================
Date Submitted:             03-31-2004 11:50 CEST
Last Modified:              03-10-2006 03:20 CET
======================================================================
Summary:                    Master volume control only controls front speakers
Description: 
The master volume control has no effect on the rear speakers.
The rear speakers can be controlled by "Sigmatel Surround" but not
completly muted.

I use "Sigmatel 4-Speaker Stereo" to get sound on all 4 speakers. The
speakers are plugged into both output plugs on the soundcard.

I tried all volume controls that are provided, there seems to be no master
control.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000154 Master volume only controls front outpu...
related to          0000919 Master volume doesn't control rear spea...
======================================================================

----------------------------------------------------------------------
 Raymond - 03-10-06 03:05 
----------------------------------------------------------------------
The other control which affect volume of front and rear speakers

numid=107,iface=MIXER,name='3D Control - Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=off
numid=110,iface=MIXER,name='3D Control Sigmatel - Depth'
  ; type=INTEGER,access=rw---,values=1,min=0,max=3,step=0
  : values=0
numid=111,iface=MIXER,name='3D Control Sigmatel - Rear Depth'
  ; type=INTEGER,access=rw---,values=1,min=0,max=3,step=0
  : values=0
numid=106,iface=MIXER,name='PCM Out Path & Mute'
  ; type=ENUMERATED,access=rw---,values=1,items=2
  ; Item #0 'pre 3D'
  ; Item #1 'post 3D'
  : values=0

----------------------------------------------------------------------
 rlrevell - 03-10-06 03:20 
----------------------------------------------------------------------
Those Sigmatel and 3D* controls are part of the AC97 codec.  A real master
volume has to be implemented with emu10k1 DSP code (as in the patch)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-31-04 11:50 gruberroland   New Issue                                    
03-31-04 11:50 gruberroland   Kernel Version            => 2.4.25          
03-31-04 16:33 perex          Assigned To               => perex           
03-31-04 16:33 perex          Severity                 major => feature    
03-31-04 16:33 perex          Status                   new => assigned     
03-31-04 16:35 perex          Note Added: 0000725                          
10-22-04 16:44 perex          Relationship added       related to 0000154  
10-29-04 21:03 BMS            Issue Monitored: BMS                         
02-22-05 09:57 perex          Relationship added       related to 0000919  
02-22-05 09:59 perex          Project                  ALSA - driver => ALSA -
lib
02-22-05 09:59 perex          Category                 PCI - ens1371 => mixer
03-09-06 11:17 muffty         Note Added: 0008387                          
03-09-06 11:18 muffty         File Added: master_volume_v3.patch                
   
03-09-06 11:19 muffty         Note Edited: 0008387                         
03-09-06 11:24 muffty         Issue Monitored: muffty                      
03-09-06 12:23 Miwer          Issue Monitored: Miwer                       
03-09-06 19:53 muffty         Note Edited: 0008387                         
03-10-06 02:45 Raymond        Note Added: 0008398                          
03-10-06 03:05 Raymond        Note Added: 0008399                          
03-10-06 03:20 rlrevell       Note Added: 0008400                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
