From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000660]: No sound output  despite unmuting and maximizing all volume settings
Date: Tue, 23 Nov 2004 23:45:15 +0100
Message-ID: <b7b8019cf4ef3ac3f9e56b4e9e4f6c4e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 754A32CD
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2004 23:45:15 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=660> 
======================================================================
Reported By:                bji
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   660
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 3
Kernel Version:             2.6.9
======================================================================
Date Submitted:             11-21-2004 02:53 CET
Last Modified:              11-23-2004 23:45 CET
======================================================================
Summary:                    No sound output  despite unmuting and maximizing all
volume settings
Description: 
I get no sound output from any program I have tried (xmms, play, aplay, cat
> /dev/audio) with no error messages or any other indication that there is
a problem which would cause sound to not occur.

I have already run alsamixer many times and tried every combination of
muted and unmuted settings with all volumes maximized.  With no volume
settings muted, and all volume settings at maximum level, I still get no
sound.

Everything *looks* like it's working - output in the kernel log, xmms's
display, everything.  But I get no sound out of the built-in speaker or
the headphone jack.

I have tried the following:

* Default install of Fedora Core 3; it recognized the sound card and
installed module settings in /etc/modprobe.conf to load snd-intel8x0.  But
I never got any sound out of this default install no matter what I tried.

* Custom compiled the 2.6.9 kernel with no patches except the software
suspend 2 patch.  This built the version of the ALSA drivers that come
with 2.6.9.  Still no sound.

* Downloaded and compiled version 1.0.7 of the ALSA drivers and installed
them.  Still no sound.

======================================================================

----------------------------------------------------------------------
 IceRAM - 11-23-04 23:27 
----------------------------------------------------------------------
These files attached are from my system:
 asound.state [^] (6,780 bytes) 11-23-04 23:24 [Delete]
 modprobe.conf [^] (902 bytes) 11-23-04 23:25 [Delete]
 iceram_lsmod.txt [^] (1,801 bytes) 11-23-04 23:26 [Delete]

----------------------------------------------------------------------
 IceRAM - 11-23-04 23:45 
----------------------------------------------------------------------
Oh, I just remembered something.

When I used alsa (cs64xx, AFAIK) on another computer, having the speakers
made loud, I could hear some kind of "power on" noise (difficult to
characterise) when the modules were loaded (the noise was similar to the
one made when pluggin the speakers in the speakers jack in the sound
card).

I couldn't hear anything though on this configuration - I don't know if I
should consider this a feature or a bug...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-21-04 02:53 bji            New Issue                                    
11-21-04 02:53 bji            Distribution              => Fedora Core 3   
11-21-04 02:53 bji            Kernel Version            => 2.6.9           
11-21-04 02:55 bji            Note Added: 0002481                          
11-21-04 02:56 bji            File Added: proc_asound.txt                    
11-21-04 03:16 bji            Note Added: 0002483                          
11-21-04 03:19 bji            Note Added: 0002484                          
11-23-04 16:20 tiwai          Note Added: 0002522                          
11-23-04 23:23 IceRAM         Note Added: 0002537                          
11-23-04 23:24 IceRAM         File Added: asound.state                     
11-23-04 23:25 IceRAM         File Added: modprobe.conf                    
11-23-04 23:26 IceRAM         File Added: iceram_lsmod.txt                    
11-23-04 23:27 IceRAM         Note Added: 0002538                          
11-23-04 23:28 IceRAM         Note Edited: 0002537                         
11-23-04 23:29 IceRAM         Note Edited: 0002537                         
11-23-04 23:29 IceRAM         Issue Monitored: IceRAM                      
11-23-04 23:45 IceRAM         Note Added: 0002539                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
