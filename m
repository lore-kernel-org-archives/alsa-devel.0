From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000848]: Intel HDA (C-Media 9880) SPDIF Out
Date: Tue, 22 Feb 2005 19:05:35 +0100
Message-ID: <13db8056fc887f81bd0a3503e13ae773@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 14D1E1AA
	for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2005 19:05:35 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=848> 
======================================================================
Reported By:                1g0R
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   848
Category:                   PCI - azx
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 3
Kernel Version:             2.6.8-ac8
======================================================================
Date Submitted:             01-25-2005 15:28 CET
Last Modified:              02-22-2005 19:05 CET
======================================================================
Summary:                    Intel HDA (C-Media 9880) SPDIF Out
Description: 
When i set in modprobe.conf the options snd-xxx model=full_dig, there is no
output signal on SPDIF (Coax).
I try:
aplay -D hw:0,1 (<--digital out) else.wav
the command run normally, but no output on spdif out.the same with xmms
(with ALSA, on hw:0,1).

======================================================================

----------------------------------------------------------------------
 tiwai - 02-22-05 14:29 
----------------------------------------------------------------------
You're reading the CVS repository.  Check out files to use at first.  I
recommend you to learn CVS briefly.

----------------------------------------------------------------------
 1g0R - 02-22-05 19:05 
----------------------------------------------------------------------
Hi,

I tried out, but no success.
I need to use Coaxial out, because i havent got optical cables.
Is the latest cvs working with coaxial spdif out?
I look the #codec, and i found this:
Node 0x12 [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x0810: OUT
  Pin Default 0x01452070: SPDIF Out at Ext Rear
    Conn = Optical, Color = Grey
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x07
Node 0x13 [Pin Complex] wcaps 0x400281: Stereo Digital
  Pincap 0x0830: IN OUT
  Pin Default 0x01c50000: SPDIF In at Ext Rear
    Conn = Optical, Color = Unknown
  Pin-ctls: 0x00:
Node 0x14 [Vendor Defined Widget] wcaps 0xf00000: Mono


is this ok?
then i try aplay:
Node 0x12 [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x0810: OUT
  Pin Default 0x01452070: SPDIF Out at Ext Rear
    Conn = Optical, Color = Grey
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x07
Node 0x13 [Pin Complex] wcaps 0x400281: Stereo Digital
  Pincap 0x0830: IN OUT
  Pin Default 0x01c50000: SPDIF In at Ext Rear
    Conn = Optical, Color = Unknown
  Pin-ctls: 0x00:
Node 0x14 [Vendor Defined Widget] wcaps 0xf00000: Mono

but i cant hear any sound from receiver.

Thanks the help.
Best regards
1g0R (G)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-25-05 15:28 1g0R           New Issue                                    
01-25-05 15:28 1g0R           Distribution              => Fedora Core 3   
01-25-05 15:28 1g0R           Kernel Version            => 2.6.8-ac8       
01-25-05 18:04 jbrsubscribe   Note Added: 0003408                          
01-25-05 18:05 jbrsubscribe   Issue Monitored: jbrsubscribe                    
01-25-05 18:14 jbrsubscribe   Note Added: 0003409                          
01-28-05 02:56 nc             Issue Monitored: nc                          
01-28-05 03:07 nc             Note Added: 0003423                          
01-28-05 19:01 1g0R           Note Added: 0003434                          
02-04-05 15:02 tiwai          Note Added: 0003507                          
02-04-05 19:36 1g0R           Note Added: 0003514                          
02-04-05 19:41 tiwai          Note Added: 0003515                          
02-05-05 06:06 mab            Issue Monitored: mab                         
02-05-05 08:46 1g0R           Note Added: 0003518                          
02-14-05 22:27 1g0R           Note Added: 0003612                          
02-14-05 22:28 1g0R           Note Added: 0003613                          
02-18-05 18:55 tiwai          Note Added: 0003658                          
02-19-05 19:51 1g0R           Note Added: 0003670                          
02-21-05 19:57 1g0R           Note Added: 0003683                          
02-22-05 14:29 tiwai          Note Added: 0003699                          
02-22-05 19:05 1g0R           Note Added: 0003709                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
