From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001909]: Labelling of controls for SB
	Extigy is confusing
Date: Fri, 4 Aug 2006 18:59:50 +0200
Message-ID: <c5437e6bf2ace278b177da40c712964d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5FF5116E
	for <alsa-devel@alsa-project.org>;
	Fri,  4 Aug 2006 18:59:50 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1909> 
======================================================================
Reported By:                andersin
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1909
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   text
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             03-11-2006 16:33 CET
Last Modified:              08-04-2006 18:59 CEST
======================================================================
Summary:                    Labelling of controls for SB Extigy is confusing
Description: 
The controls for the SB Extigy are all labelled as Master. The names should
reflect the channel(s) that they control. Amixer shows this information
(albeit its mapping of controls to actual channels is off).
Additionally a Master 1 control exists that changes the volume of all
channels.
======================================================================

----------------------------------------------------------------------
 Raymond - 08-03-06 11:43 
----------------------------------------------------------------------
Syntax: SOURCE [DIRECTION] FUNCTION

The following controls appear in capture view of alsamixer because it miss
the 'Playback' direction

Simple mixer control 'Bass',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 96
  Mono: 48 [50%]
Simple mixer control 'Treble',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 96
  Mono: 48 [50%]

The following control should only appear in capture view of alsamixer,
because the control name did not follow Syntax: SOURCE [DIRECTION]
FUNCTION

Simple mixer control 'Capture Input Source',0
  Capabilities: enum
  Items: 'Input 0' 'Mic' 'Mixer'
  Item0: 'Input 0'

Simple mixer control 'Digital In',0
  Capabilities: volume volume-joined pswitch pswitch-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 200
  Mono: 200 [100%] Playback [on]

These control also not follow the syntax.

Simple mixer control 'Channel Routing Mode Select',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 6
  Mono: 6 [100%]

similar bug report https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1971
and https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1366

Refer to appearance of EQ peaks in alsamixer.png in
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1366 , alsamixer
is supposed to handle up to 8 channels ( 2 , 2 , 1 , 1, 2 ) with 5 sliders
(i.e. front, rear, centre, lfe , side ) when the count of the control is
greater than two and up to eight only. 

http://hg-mirror.alsa-project.org/alsa-kernel?f=2cd9765e57f6;file=Documentation/ControlNames.txt;style=gitweb



----------------------------------------------------------------------
 Clemens Ladisch - 08-04-06 18:59 
----------------------------------------------------------------------
andersin, your control names do not quite match the controls seen in other
SB Extigy devices (and that the driver expects).

Please post the output of "lsusb -v" for this device.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-11-06 16:33 andersin       New Issue                                    
08-02-06 02:40 Raymond        Note Added: 0011384                          
08-02-06 14:31 andersin       Note Added: 0011388                          
08-02-06 14:31 andersin       Note Added: 0011389                          
08-03-06 04:06 Raymond        Note Added: 0011395                          
08-03-06 04:16 Raymond        Note Edited: 0011395                         
08-03-06 09:47 Raymond        Note Added: 0011397                          
08-03-06 09:55 Raymond        Note Edited: 0011397                         
08-03-06 09:57 Raymond        Note Edited: 0011397                         
08-03-06 09:58 Raymond        Note Edited: 0011397                         
08-03-06 09:59 Raymond        Note Edited: 0011397                         
08-03-06 11:43 Raymond        Note Edited: 0011397                         
08-04-06 18:49 Clemens LadischProject                  ALSA - utils => ALSA -
driver
08-04-06 18:50 Clemens LadischAssigned To               => Clemens Ladisch 
08-04-06 18:50 Clemens LadischStatus                   new => assigned     
08-04-06 18:50 Clemens LadischCategory                 alsamixer => USB -
usb-audio
08-04-06 18:59 Clemens LadischNote Added: 0011420                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
