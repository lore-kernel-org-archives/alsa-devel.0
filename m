From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001909]: Labelling of controls for SB
	Extigy is confusing
Date: Thu, 3 Aug 2006 04:06:27 +0200
Message-ID: <0e44799626fa776d76438a8213742056@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A4092193
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Aug 2006 04:06:27 +0200 (MEST)
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
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   1909
Category:                   alsamixer
Reproducibility:            always
Severity:                   text
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             03-11-2006 16:33 CET
Last Modified:              08-03-2006 04:06 CEST
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
 andersin - 08-02-06 14:31 
----------------------------------------------------------------------
amixer:

Simple mixer control 'Master',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right - Rear Left - Rear Right -
Front Center - Woofer
  Limits: Playback 0 - 200
  Mono:
  Front Left: Playback 150 [75%] [on]
  Front Right: Playback 150 [75%] [on]
  Rear Left: Playback 150 [75%] [on]
  Rear Right: Playback 150 [75%] [on]
  Front Center: Playback 150 [75%] [on]
  Woofer: Playback 150 [75%] [on]
Simple mixer control 'Master',1
  Capabilities: pvolume pvolume-joined
  Playback channels: Mono
  Limits: Playback 0 - 200
  Mono: Playback 150 [75%]
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
Simple mixer control 'PCM',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 200
  Mono: Playback 200 [100%] [on]
Simple mixer control 'Line',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 200
  Mono:
  Front Left: Playback 176 [88%] [off]
  Front Right: Playback 176 [88%] [off]
Simple mixer control 'Line',1
  Capabilities: pvolume pvolume-joined
  Playback channels: Mono
  Limits: Playback 0 - 200
  Mono: Playback 176 [88%]
Simple mixer control 'Mic',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 200
  Mono: Playback 200 [100%] [off]
Simple mixer control 'IEC958 Optical',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch cswitch-joined
  Capture channels: Mono
  Limits: Capture 0 - 200
  Mono: Capture 10 [5%] [on]
Simple mixer control 'Capture Input Source',0
  Capabilities: enum
  Items: 'Input 0' 'Mic' 'Mixer'
  Item0: 'Input 0'
Simple mixer control '3D Stereo Extender',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Channel Routing Mode Select',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 6
  Mono: 6 [100%]
Simple mixer control 'Digital In',0
  Capabilities: volume volume-joined pswitch pswitch-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 200
  Mono: 200 [100%] Playback [on]
Simple mixer control 'Digital Out',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Digital Out1',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Speaker',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]

----------------------------------------------------------------------
 Raymond - 08-03-06 04:06 
----------------------------------------------------------------------
Most likely both alsamixer and amixer cannot handle these two controls
properly

       control.16 {
                 comment.access 'read write'
                 comment.type INTEGER
                 comment.count 6
                 comment.range '0 - 200'
                 iface MIXER
                 name 'Master Playback Volume'
                 value.0 130
                 value.1 130
                 value.2 130
                 value.3 130
                 value.4 130
                 value.5 130
         }
         control.17 {
                 comment.access 'read write'
                 comment.type INTEGER
                 comment.count 1
                 comment.range '0 - 200'
                 iface MIXER
                 name 'Master Playback Volume'
                 index 1
                 value 130
         }

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-11-06 16:33 andersin       New Issue                                    
08-02-06 02:40 Raymond        Note Added: 0011384                          
08-02-06 14:31 andersin       Note Added: 0011388                          
08-02-06 14:31 andersin       Note Added: 0011389                          
08-03-06 04:06 Raymond        Note Added: 0011395                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
