From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001971]: Some elements incorrectly have capture flags
Date: Thu, 13 Apr 2006 20:26:05 +0200
Message-ID: <eb9a743927c35f08499d4118a281cfed@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 540B1148
	for <alsa-devel@alsa-project.org>; Thu, 13 Apr 2006 20:26:06 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1971> 
======================================================================
Reported By:                pzad
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1971
Category:                   simple mixer
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             03-28-2006 12:16 CEST
Last Modified:              04-13-2006 20:26 CEST
======================================================================
Summary:                    Some elements incorrectly have capture flags
Description: 
Some elemnts have capture flags even they have nothing to do with capture.
This will duplicate control in alsamixer - view ALL.

On VIA8233A + ALC650:

Simple mixer control '3D Control - Center',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 15
  Mono: 1 [7%]
Simple mixer control '3D Control - Depth',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 15
  Mono: 0 [0%]

On Audigy 1:
Simple mixer control 'Bass',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 40
  Front Left: 23 [58%]
  Front Right: 23 [58%]
Simple mixer control 'Treble',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 40
  Front Left: 27 [68%]
  Front Right: 27 [68%]


======================================================================

----------------------------------------------------------------------
 Raymond - 04-13-06 11:32 
----------------------------------------------------------------------
>> Anyway there is still bug, because this "Captrure" mixer element in
alsamixer >> doesn't work at all.

In View All of alsamixer

The "Playback" control and "Capture" control are side by side.

Both "Playback" and "Capture" will go up/down when we press key to
increase/decrease the "Playback" control and it affect the output.

The "Capture" control will go up/down when we press key to
increase/decrese the "Capture" but it actually don't affect the output.

----------------------------------------------------------------------
 pzad - 04-13-06 20:26 
----------------------------------------------------------------------
This is because alsamixer doesn't check "has_common" flag.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-28-06 12:16 pzad           New Issue                                    
03-30-06 11:01 Raymond        Note Added: 0009028                          
03-30-06 12:50 pzad           Note Added: 0009031                          
03-30-06 13:13 pzad           Note Added: 0009032                          
03-30-06 13:22 Raymond        Note Added: 0009033                          
03-30-06 13:29 Raymond        Note Edited: 0009033                         
03-30-06 13:41 Raymond        Note Edited: 0009033                         
03-31-06 04:36 Raymond        Note Added: 0009041                          
03-31-06 04:50 Raymond        Note Edited: 0009041                         
04-01-06 01:13 Raymond        Note Edited: 0009033                         
04-03-06 19:08 Raymond        Note Added: 0009103                          
04-05-06 18:42 Raymond        Note Added: 0009121                          
04-05-06 18:46 Raymond        Note Edited: 0009121                         
04-05-06 18:50 Raymond        Note Edited: 0009121                         
04-06-06 09:11 Raymond        Note Deleted: 0009103                        
04-06-06 09:44 Raymond        Note Added: 0009124                          
04-06-06 09:45 Raymond        Note Edited: 0009124                         
04-07-06 12:05 Raymond        Note Added: 0009136                          
04-13-06 11:32 Raymond        Note Added: 0009256                          
04-13-06 20:26 pzad           Note Added: 0009268                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
