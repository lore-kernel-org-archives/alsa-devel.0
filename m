From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002244]: Aureon 7.1 Universe speakers
	in incorrect order when doing a speaker-test
Date: Thu, 29 Jun 2006 15:40:11 +0200
Message-ID: <3dd3f90dbebdcde47cd9cb7c935908ae@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 230FE29C
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Jun 2006 15:40:12 +0200 (MEST)
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
Last Modified:              06-29-2006 15:40 CEST
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
 calestyo - 06-29-06 15:37 
----------------------------------------------------------------------
I get similar errors when trying to use those profiles with other
applications, but I must admit that I don't fully understand how they
work... (see me post to alsa-users where I've asked about this stuff)

----------------------------------------------------------------------
 Raymond - 06-29-06 15:40 
----------------------------------------------------------------------
cat /proc/asound/cards

cat /proc/asound/pcm

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
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
