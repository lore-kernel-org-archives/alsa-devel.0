From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001909]: Labelling of controls for SB
	Extigy is confusing
Date: Wed, 2 Aug 2006 14:31:04 +0200
Message-ID: <c97433f6c99b3c5d310f73da77e440da@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A881D1AC
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Aug 2006 14:31:04 +0200 (MEST)
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
Last Modified:              08-02-2006 14:31 CEST
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
 Raymond - 08-02-06 02:40 
----------------------------------------------------------------------
Would you post the content of test.state after 'alsactl store -f
test.state'  and output of 'amixer' ?

----------------------------------------------------------------------
 andersin - 08-02-06 14:31 
----------------------------------------------------------------------
test.state:
state.Extigy {
         control.1 {
                 comment.access 'read write'
                 comment.type BOOLEAN
                 comment.count 1
                 iface MIXER
                 name 'PCM Playback Switch'
                 value true
         }
         control.2 {
                 comment.access 'read write'
                 comment.type INTEGER
                 comment.count 1
                 comment.range '0 - 200'
                 iface MIXER
                 name 'PCM Playback Volume'
                 value 200
         }
         control.3 {
                 comment.access 'read write'
                 comment.type BOOLEAN
                 comment.count 1
                 iface MIXER
                 name 'Digital In Switch'
                 value true
         }
         control.4 {
                 comment.access 'read write'
                 comment.type INTEGER
                 comment.count 1
                 comment.range '0 - 200'
                 iface MIXER
                 name 'Digital In Volume'
                 value 200
         }
         control.5 {
                 comment.access 'read write'
                 comment.type BOOLEAN
                 comment.count 1
                 iface MIXER
                 name 'Line Playback Switch'
                 value false
         }
         control.6 {
                 comment.access 'read write'
                 comment.type INTEGER
                 comment.count 2
                 comment.range '0 - 200'
                 iface MIXER
                 name 'Line Playback Volume'
                 value.0 176
                 value.1 176
         }
         control.7 {
                 comment.access 'read write'
                 comment.type INTEGER
                 comment.count 1
                 comment.range '0 - 200'
                 iface MIXER
                 name 'Line Playback Volume'
                 index 1
                 value 176
         }
         control.8 {
                 comment.access 'read write'
                 comment.type BOOLEAN
                 comment.count 1
                 iface MIXER
                 name '3D Stereo Extender Switch'
                 value false
         }
         control.9 {
                 comment.access 'read write'
                 comment.type BOOLEAN
                 comment.count 1
                 iface MIXER
                 name 'Mic Playback Switch'
                 value false
         }
         control.10 {
                 comment.access 'read write'
                 comment.type INTEGER
                 comment.count 1
                 comment.range '0 - 200'
                 iface MIXER
                 name 'Mic Playback Volume'
                 value 200
         }
         control.11 {
                 comment.access 'read write'
                 comment.type INTEGER
                 comment.count 1
                 comment.range '0 - 6'
                 iface MIXER
                 name 'Channel Routing Mode Select'
                 value 6
         }
         control.12 {
                 comment.access 'read write'
                 comment.type ENUMERATED
                 comment.count 1
                 comment.item.0 'Input 0'
                 comment.item.1 Mic
                 comment.item.2 Mixer
                 iface MIXER
                 name 'Capture Input Source'
                 value 'Input 0'
         }
         control.13 {
                 comment.access 'read write'
                 comment.type BOOLEAN
                 comment.count 1
                 iface MIXER
                 name 'Capture Switch'
                 value true
         }
         control.14 {
                 comment.access 'read write'
                 comment.type INTEGER
                 comment.count 1
                 comment.range '0 - 200'
                 iface MIXER
                 name 'Capture Volume'
                 value 10
         }
         control.15 {
                 comment.access 'read write'
                 comment.type BOOLEAN
                 comment.count 1
                 iface MIXER
                 name 'Master Playback Switch'
                 value true
         }
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
         control.18 {
                 comment.access 'read write'
                 comment.type INTEGER
                 comment.count 1
                 comment.range '0 - 96'
                 iface MIXER
                 name 'Tone Control - Bass'
                 value 48
         }
         control.19 {
                 comment.access 'read write'
                 comment.type INTEGER
                 comment.count 1
                 comment.range '0 - 96'
                 iface MIXER
                 name 'Tone Control - Treble'
                 value 48
         }
         control.20 {
                 comment.access 'read write'
                 comment.type BOOLEAN
                 comment.count 1
                 iface MIXER
                 name 'Speaker Playback Switch'
                 value true
         }
         control.21 {
                 comment.access 'read write'
                 comment.type BOOLEAN
                 comment.count 1
                 iface MIXER
                 name 'Digital Out Playback Switch'
                 value false
         }
         control.22 {
                 comment.access 'read write'
                 comment.type BOOLEAN
                 comment.count 1
                 iface MIXER
                 name 'Digital Out1 Playback Switch'
                 value false
         }
         control.23 {
                 comment.access 'read write'
                 comment.type BOOLEAN
                 comment.count 1
                 iface MIXER
                 name 'IEC958 Optical Playback Switch'
                 value false
         }
 }

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-11-06 16:33 andersin       New Issue                                    
08-02-06 02:40 Raymond        Note Added: 0011384                          
08-02-06 14:31 andersin       Note Added: 0011388                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
