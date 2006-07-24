From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001971]: Some elements incorrectly have
	capture flags
Date: Mon, 24 Jul 2006 16:44:06 +0200
Message-ID: <e7efc4ee1e97480f498fb9a7ea64a93e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E1299223
	for <alsa-devel@alsa-project.org>;
	Mon, 24 Jul 2006 16:44:06 +0200 (MEST)
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
Last Modified:              07-24-2006 16:44 CEST
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
 Raymond - 07-24-06 03:00 
----------------------------------------------------------------------
The ALSA drivers should follow the standard name or someone must update
ControlNames.txt

http://hg-mirror.alsa-project.org/alsa-kernel?cmd=file;file=Documentation/ControlNames.txt;filenode=2cd9765e57f6d680c41023c1742b5a692be70eda;style=raw

----------------------------------------------------------------------
 rlrevell - 07-24-06 16:44 
----------------------------------------------------------------------
Your comment makes no sense.  You never give enough information for anyone
to fogure out what you mean.  Which controls for which driver do not
follow the standard?

I've asked you 100 times why you can't post a patch and you refuse to
answer.

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
04-14-06 06:21 Raymond        Note Added: 0009282                          
04-14-06 09:55 Raymond        Note Edited: 0009282                         
06-30-06 18:20 Raymond        Note Added: 0010749                          
06-30-06 18:22 Raymond        Note Edited: 0010749                         
06-30-06 18:33 Raymond        Note Edited: 0010749                         
07-22-06 05:25 Raymond        Note Added: 0011166                          
07-22-06 23:01 rlrevell       Note Added: 0011173                          
07-23-06 04:19 Raymond        Note Added: 0011180                          
07-23-06 04:28 Raymond        Note Edited: 0011180                         
07-23-06 11:12 Raymond        Note Edited: 0011180                         
07-24-06 03:00 Raymond        Note Added: 0011207                          
07-24-06 16:44 rlrevell       Note Added: 0011210                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
