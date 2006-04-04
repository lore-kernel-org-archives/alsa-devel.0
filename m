From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0002001]: fast repeated calls to adjust volume incrementally fail for multi channel control of SB Extigy
Date: Wed, 5 Apr 2006 00:06:21 +0200
Message-ID: <a8c26febdbe58355e18f80605b9be580@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3F4BF178
	for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2006 00:06:21 +0200 (MEST)
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


The following issue has been SUBMITTED.
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
Last Modified:              04-05-2006 00:06 CEST
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-05-06 00:06 andersin       New Issue                                    
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
