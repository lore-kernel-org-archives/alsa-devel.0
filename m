From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0002001]: fast repeated calls to adjust
	volume incrementally fail for multi channel control of SB Extigy
Date: Wed, 2 Aug 2006 14:27:24 +0200
Message-ID: <1cb49de8888934af211c7b9593f0c933@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C474B1AC
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Aug 2006 14:27:24 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2001> 
======================================================================
Reported By:                andersin
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   2001
Category:                   amixer
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             04-05-2006 00:06 CEST
Last Modified:              08-02-2006 14:27 CEST
======================================================================
Summary:                    fast repeated calls to adjust volume incrementally
fail for multi channel control of SB Extigy
Description: 
The SB Extigy has multiple channels which amixer reports as:
Simple mixer control 'Master',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right - Rear Left - Rear Right -
Front Center - Woofer
  Limits: Playback 0 - 200
  Mono:
  Front Left: Playback 146 [73%] [on]
  Front Right: Playback 146 [73%] [on]
  Rear Left: Playback 146 [73%] [on]
  Rear Right: Playback 146 [73%] [on]
  Front Center: Playback 146 [73%] [on]
  Woofer: Playback 146 [73%] [on]

repeated calls to amixer to incrementally adjust the volume make the
volume "wobble". The volume stays at about the same value but goes
slightly up and down on different speakers (can't quite pin down which
ones, but the effect is noticeable).

The effect can be easily reproduced:
while ( true ); do amixer sset Master 2- & done;

Note the &. It is necessary, since
while ( true ); do amixer sset Master 2-; done;
will work just fine, however even here a small quirk can be observed.
I let the above loop run and observe the volume through alsamixer. Now I
issue in another shell amixer sset Master 150. 

The volume does get set to the desired value on all controls associated
with master (all 6 channels). However, sometimes (often for the last
speakers) the volume gets reset to a lower value than it used to be before
I use amixer.
Example:

channel                1   2   3   4   5   6
---------------------------------------------
values before control 100 100 100 100 100 100
values set by amixer  150 150 150 150 150 150
values for next step  148 148 148  98  98  98

How many channels are affected is up to chance, but the higher ones 5+6
have a higher chance of being subject to this issue so I guess it could be
some race between the various amixer processes.

Note that this behavior is fine if I use a mono volume control.
======================================================================

----------------------------------------------------------------------
 Raymond - 08-01-06 16:28 
----------------------------------------------------------------------
Would you post the content of test.state after 'alsactl store -f
test.state' ?

----------------------------------------------------------------------
 andersin - 08-02-06 14:27 
----------------------------------------------------------------------
Ok, here it is:

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
04-05-06 00:06 andersin       New Issue                                    
08-01-06 16:28 Raymond        Note Added: 0011375                          
08-02-06 14:27 andersin       Note Added: 0011387                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
