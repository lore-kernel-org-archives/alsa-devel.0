From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002244]: Aureon 7.1 Universe speakers
	in incorrect order when doing a speaker-test
Date: Thu, 20 Jul 2006 14:47:26 +0200
Message-ID: <19e63dd1c4ea2fc9331d0c73672c6792@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 79C8D185
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Jul 2006 14:47:26 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2244> 
======================================================================
Reported By:                calestyo
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2244
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Debian GNU/Linux
Kernel Version:             2.6.17
======================================================================
Date Submitted:             06-29-2006 01:35 CEST
Last Modified:              07-20-2006 14:47 CEST
======================================================================
Summary:                    Aureon 7.1 Universe speakers in incorrect order when
doing a speaker-test
Description: 
I use my Aureon 7.1 Universe with a TerraTec HomeAreon TXR 884 7.1 speaker
set.

I've connected the outputs of the soundard to those of the subwoofer
which
itself connects the small speakers the following way:

Soundcard -------------- Subwoofer --- Small Speakers
Out Front <---------+--> In FL <-----> Front Left Speaker
                    \--> In FR <-----> Font Right Speaker
Out Rear <----------+--> In SL <-----> Side Left Speaker
                    \--> In SR <-----> Side Right Speaker
Out Center/Subwoofer <-> In C <------> Center Speaker
                      \> In Subwoofer
Out Back Surround <----> In BL <-----> Back Left Speaker
                    \--> In BR <-----> Back Right Speaker

You might have a look at soundcard manual page 8
(http://supportuk.terratec.net/modules.php?op=modload&name=Downloads&file=index&req=getit&lid=574)
and speaker manual page 12
(http://supportuk.terratec.net/modules.php?op=modload&name=Downloads&file=index&req=getit&lid=724)
My speakers are placed in my room in a configuration as the 7.1 shown on
page 12
in the speaker manual.

As you note the connection from rear to side is a little bit strange (at
least I
thought so,...) but this seems to be correct, because when I use the
windows
mixer supplied by TerraTec itself, there is a surround test included which
shows
the position of the 8 speakers and let me put the indiviually on and off
and
this leads always to the correct position.

The problem now: I tried the same as under Windows unter Linux with the
speaker-test tool.
I called it via speaker-test -t wav -c 8 and the following came out:
What wav file was played ----- in which speaker position the wav file was
played
"Front Left" ----------------- Front Left Speaker  (correct)
"Front Center" --------------- Center Speaker      (correct)
"Front Right" ---------------- Front Right Speaker (correct)
"Side Right" ----------------- Back Right Speaker  (probably wrong!)
"Rear Right" ----------------- Side Right Speaker  (probably wrong!)
"Rear Left" ------------------ Side Left Speaker  (probably wrong!)
"Side Left" ------------------ Back Left Speaker  (probably wrong!)
"LFE" ------------------------ Subwoofer (correct)

No one could think that I should just switch the speaker cables but that
can't
be a proper solution (not only because this would break settings in the
original
Windows driver (which I only use for Upgrading my Plextor drive firmware
;) ).
I think the configuration of the surround for the Aureon 7.1 Universe has
here
some mistake, hasn't it?
======================================================================

----------------------------------------------------------------------
 Raymond - 07-20-06 14:37 
----------------------------------------------------------------------
Does the volume controls change the correct channels ?

Do you have any multi-media player (e.g. xine, mplayer, ... ) and 5.1
movie to test the surround51 ? speaker-test seem buggy in calculating
period size

----------------------------------------------------------------------
 calestyo - 07-20-06 14:47 
----------------------------------------------------------------------
>Does the volume controls change the correct channels ?
No they are also switched.

>Do you have any multi-media player (e.g. xine, mplayer, ... ) and 5.1
movie to test the surround51 ? speaker-test seem buggy in calculating
period size
Yes I have,.. but unfortunately I do not have a surround test dvd or so,..
and with an normal movie it would be very difficult to test if everything
works correct as background sounds are often very silend and so,..
So what exactly do you want me to test? :D

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-29-06 01:35 calestyo       New Issue                                    
06-29-06 01:35 calestyo       Distribution              => Debian GNU/Linux
06-29-06 01:35 calestyo       Kernel Version            => 2.6.17          
06-29-06 01:36 calestyo       Note Added: 0010634                          
06-29-06 01:36 calestyo       Issue Monitored: calestyo                    
06-29-06 15:29 Raymond        Note Added: 0010647                          
06-29-06 15:36 calestyo       Note Added: 0010648                          
06-29-06 15:37 calestyo       Note Added: 0010649                          
06-29-06 15:40 Raymond        Note Added: 0010650                          
06-29-06 15:45 calestyo       Note Added: 0010651                          
06-29-06 15:52 Raymond        Note Added: 0010652                          
06-29-06 15:54 Raymond        Note Edited: 0010652                         
06-29-06 15:56 calestyo       Note Added: 0010653                          
06-29-06 15:58 Raymond        Note Added: 0010654                          
06-29-06 16:01 calestyo       Note Added: 0010655                          
06-29-06 16:04 Raymond        Note Added: 0010656                          
06-29-06 16:07 calestyo       Note Added: 0010657                          
06-29-06 16:08 Raymond        Note Edited: 0010656                         
06-29-06 16:12 Raymond        Note Added: 0010658                          
06-29-06 16:19 calestyo       Note Added: 0010659                          
06-29-06 17:50 tiwai          Note Added: 0010677                          
06-29-06 19:05 calestyo       Note Added: 0010695                          
06-30-06 02:02 Raymond        Note Added: 0010709                          
06-30-06 02:14 rlrevell       Note Added: 0010711                          
06-30-06 05:13 Raymond        Note Edited: 0010709                         
07-03-06 19:28 calestyo       Note Added: 0010803                          
07-03-06 19:37 rlrevell       Note Added: 0010804                          
07-17-06 20:49 calestyo       Note Added: 0011049                          
07-18-06 03:23 calestyo       Note Added: 0011051                          
07-18-06 03:23 calestyo       Note Deleted: 0011049                        
07-18-06 05:54 Raymond        Note Added: 0011052                          
07-18-06 05:58 Raymond        Note Edited: 0011052                         
07-18-06 13:37 calestyo       Note Added: 0011054                          
07-18-06 14:24 Raymond        Note Added: 0011058                          
07-18-06 14:25 Raymond        Note Edited: 0011058                         
07-18-06 14:34 calestyo       Note Added: 0011059                          
07-18-06 17:35 Raymond        Note Added: 0011067                          
07-18-06 17:39 Raymond        Note Edited: 0011067                         
07-18-06 18:03 calestyo       Note Added: 0011068                          
07-18-06 18:12 Raymond        Note Added: 0011069                          
07-18-06 18:30 calestyo       Note Added: 0011070                          
07-19-06 03:36 Raymond        Note Added: 0011077                          
07-19-06 05:50 Raymond        Note Edited: 0011077                         
07-19-06 11:50 calestyo       Note Added: 0011084                          
07-19-06 12:03 Raymond        Note Added: 0011085                          
07-19-06 12:06 Raymond        Note Edited: 0011085                         
07-19-06 12:11 calestyo       Note Added: 0011086                          
07-19-06 16:46 Raymond        Note Added: 0011087                          
07-19-06 18:21 calestyo       Note Added: 0011091                          
07-19-06 18:22 calestyo       Note Added: 0011092                          
07-19-06 20:01 tiwai          Note Added: 0011093                          
07-19-06 21:30 calestyo       Note Added: 0011102                          
07-20-06 04:01 Raymond        Note Added: 0011106                          
07-20-06 08:06 Raymond        Note Added: 0011113                          
07-20-06 12:38 calestyo       Note Added: 0011117                          
07-20-06 12:48 calestyo       Note Added: 0011118                          
07-20-06 13:44 Raymond        Note Added: 0011119                          
07-20-06 13:57 calestyo       Note Added: 0011120                          
07-20-06 14:09 Raymond        Note Added: 0011121                          
07-20-06 14:25 calestyo       Note Added: 0011122                          
07-20-06 14:37 Raymond        Note Added: 0011124                          
07-20-06 14:47 calestyo       Note Added: 0011125                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
