From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000506]: Hercules Fortissimo II (Gamesurround 5.1 digital edition) has no sound on headphone output
Date: Sun, 28 Nov 2004 14:44:55 +0100
Message-ID: <2690de3ba7f34589d16333f181fbd605@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 45D4826E
	for <alsa-devel@alsa-project.org>; Sun, 28 Nov 2004 14:44:55 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=506> 
======================================================================
Reported By:                bekker
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   506
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Gentoo Linux
Kernel Version:             kernel 2.6.8-gentoo-r3.
======================================================================
Date Submitted:             09-19-2004 13:40 CEST
Last Modified:              11-28-2004 14:44 CET
======================================================================
Summary:                    Hercules Fortissimo II (Gamesurround 5.1 digital
edition) has no sound on headphone output
Description: 
the Fortissimo II card has seperate outputs for front, rear speakers and
headphone. I cannot get sound on the headphone. 

Front (HW:0,0) and rear speakers (HW:0,1) work.IEC958 (HW:0,2) is also
available but I have not tested it.

The slider marked as headphone in the mixer actually controls the rear
speaker volume. 


======================================================================

----------------------------------------------------------------------
 arphen - 11-19-04 08:04 
----------------------------------------------------------------------
Anybody works on this problem?
I have a BlackGold II Cannon card which uses CS4630 with two codecs. and I
have the same problem. I can hear sound from front, rear or center_lfe 
seperately, but there is no sound from headphones. here is my
/proc/asound/devices
_______________________________________
  0: [0- 0]: ctl
  8: [0- 0]: raw midi
 19: [0- 3]: digital audio playback
 18: [0- 2]: digital audio playback
 17: [0- 1]: digital audio playback
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
  1:       : sequencer
 33:       : timer
________________________________________
 
and here is my /dev/snd/*
___________________________________________
crw-rw----  1 jim audio 116,  0
11&https://bugtrack.alsa-project.org/alsa-bug/view.php?id=26376; 19 14:31
controlC0
crw-rw----  1 jim audio 116,  8
11&https://bugtrack.alsa-project.org/alsa-bug/view.php?id=26376; 19 14:31
midiC0D0
crw-rw----  1 jim audio 116, 24
11&https://bugtrack.alsa-project.org/alsa-bug/view.php?id=26376; 19 14:31
pcmC0D0c
crw-rw----  1 jim audio 116, 16
11&https://bugtrack.alsa-project.org/alsa-bug/view.php?id=26376; 19 14:31
pcmC0D0p
crw-rw----  1 jim audio 116, 17
11&https://bugtrack.alsa-project.org/alsa-bug/view.php?id=26376; 19 14:31
pcmC0D1p
crw-rw----  1 jim audio 116, 18
11&https://bugtrack.alsa-project.org/alsa-bug/view.php?id=26376; 19 14:31
pcmC0D2p
crw-rw----  1 jim audio 116, 19
11&https://bugtrack.alsa-project.org/alsa-bug/view.php?id=26376; 19 14:31
pcmC0D3p
crw-rw----  1 jim audio 116,  1
11&https://bugtrack.alsa-project.org/alsa-bug/view.php?id=26376; 19 14:31 seq
crw-rw----  1 jim audio 116, 33
11&https://bugtrack.alsa-project.org/alsa-bug/view.php?id=26376; 19 14:31 timer
_________________________________________________________

----------------------------------------------------------------------
 darkbrain - 11-28-04 14:44 
----------------------------------------------------------------------
I applyed the patch: now i can see Center LFE but it's mapped to rear
speakers. 
As you can see Hercules Fortissimo II has only one codec cs4624
http://images.google.it/imgres?imgurl=http://www.de.tomshardware.com/video/20011018/images/hercules_fort2_card.jpg&imgrefurl=http://www.de.tomshardware.com/video/20011018/audiocards-11.html&h=411&w=425&sz=51&tbnid=GTz4QrL3D3MJ:&tbnh=117&tbnw=120&start=33&prev=/images%3Fq%3Dhercules%2Bfortissimo%2B2%2B%26start%3D20%26hl%3Dit%26lr%3D%26sa%3DN

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-19-04 13:40 bekker         New Issue                                    
09-19-04 13:40 bekker         Distribution              => Gentoo Linux    
09-19-04 13:40 bekker         Kernel Version            => kernel
2.6.8-gentoo-r3.
09-19-04 13:41 bekker         Note Added: 0001784                          
09-20-04 17:39 tiwai          Note Added: 0001789                          
09-21-04 20:01 bekker         Note Added: 0001808                          
09-23-04 18:34 tiwai          Note Added: 0001830                          
10-06-04 11:33 tiwai          Note Added: 0002019                          
10-07-04 22:25 bekker         Note Added: 0002040                          
10-08-04 12:15 tiwai          Note Added: 0002046                          
10-08-04 14:38 bekker         Note Added: 0002051                          
10-08-04 15:22 tiwai          Note Added: 0002052                          
10-08-04 15:23 tiwai          File Added: cs46xx-force-cl.dif                   

10-08-04 20:25 bekker         Note Added: 0002056                          
10-12-04 14:36 tiwai          Note Added: 0002093                          
10-14-04 16:41 bekker         Note Added: 0002156                          
11-19-04 08:04 arphen         Note Added: 0002477                          
11-19-04 08:04 arphen         Issue Monitored: arphen                      
11-28-04 14:44 darkbrain      Note Added: 0002624                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
