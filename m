From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002244]: Aureon 7.1 Universe speakers
	in incorrect order when doing a speaker-test
Date: Tue, 18 Jul 2006 05:54:40 +0200
Message-ID: <8fab2eeb29c67bd6c8bcf17266af4725@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 529F2132
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Jul 2006 05:54:41 +0200 (MEST)
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
Last Modified:              07-18-2006 05:54 CEST
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
 calestyo - 07-18-06 03:23 
----------------------------------------------------------------------
Ok,. I think I managed it to compile the whole stuff from cvs....
First I compiled and loaded alsa-drivers... I've noted that the fix for
2242 which I've reported before has not yet been applied (is this going to
be done) so I patched the bug manually, thus cat /proc/asound/cards give
me now correctly:
 0 [T71Universe    ]: Aureon71Univ - Terratec Aureon 7.1-Universe
                      Terratec Aureon 7.1-Universe at 0x3880, irq 82

Ok,.. then I make && make installed alsa-lib...
using it with my previous (from Debian sid) alsa-utils like aply amixer
and so on leads to this:
$ aplay -l
**** List of PLAYBACK Hardware Devices ****
ALSA lib control.c:816:(snd_ctl_open_noupdate) Invalid CTL hw:0
aplay: device_list:231: control open (0): No such file or directory


$ alsamixer
ALSA lib control.c:816:(snd_ctl_open_noupdate) Invalid CTL default

alsamixer: function snd_ctl_open failed for default: No such file or
directory


$ speaker-test -Dsurround40 -c 4 -t wav

speaker-test 1.0.11

Playback device is surround40
Stream parameters are 48000Hz, S16_LE, 4 channels
WAV file(s)
ALSA lib pcm.c:2146:(snd_pcm_open_noupdate) Unknown PCM surround40
Playback open error: -2,No such file or directory
ALSA lib pcm.c:2146:(snd_pcm_open_noupdate) Unknown PCM surround40
Playback open error: -2,No such file or directory

(same for surround51 and 71)


speaker-test -Dfront -c 2 -t wav

speaker-test 1.0.11

Playback device is front
Stream parameters are 48000Hz, S16_LE, 2 channels
WAV file(s)
ALSA lib pcm.c:2146:(snd_pcm_open_noupdate) Unknown PCM front
Playback open error: -2,No such file or directory
ALSA lib pcm.c:2146:(snd_pcm_open_noupdate) Unknown PCM front
Playback open error: -2,No such file or directory

(same for side, etc.)

The alsa-util stuff from cvs does not compile correctly,.. there are some
autotools problems as far as I can see with po/Makefile.in.in ...

Any other things that I could help you with?

----------------------------------------------------------------------
 Raymond - 07-18-06 05:54 
----------------------------------------------------------------------
1.0.11 is too old, you need to use HG repo instead of CVS

aplay: device_list:231: control open (0): No such file or directory

alsa-lib cannot find Aureon71Univ.conf, why the error message does not
show the filename ?

Change 'Aureon71Universe cards.Aureon71' to 'Aureon71Univ cards.Aureon71'
to instruct alsa-lib to use Aureon71.conf


The hardware does not support S16_LE, you need to use 'plug:surround??'
instead of 'surround??'

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
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
