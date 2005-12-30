From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001179]: alsa-lib 1.0.9 breaks snd_hda_intel
Date: Fri, 30 Dec 2005 04:25:39 +0100
Message-ID: <b5bb564ef3d3026f721a75cb60fa3a5a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C02BB1A1
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 04:25:39 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1179> 
======================================================================
Reported By:                theoneandonlysm
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1179
Category:                   1_pcm - digital audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             06-10-2005 19:08 CEST
Last Modified:              12-30-2005 04:25 CET
======================================================================
Summary:                    alsa-lib 1.0.9 breaks snd_hda_intel
Description: 
I upgraded alsa (lib, tools, oss) 1.0.8 to 1.0.9 through Slackware's
package update and noticed that aRts in kde did not produce any sound even
though no errors in arts was reported.

I uninstalled the alsa-lib package and compiled the 1.0.8 sources and
sound worked again (with self-compiled 1.0.9 drivers on kernel 2.6.11.11).
Compiling and installing alsa-lib 1.0.9 once again caused sound to stop
functioning.

dmesg gives me no errors, and I am not certain where else to look. The
only clue I get is from mplayer while playing an audio file, where I get
continual output of:
alsa-space: xrun of at least 0.002 msecs. resetting stream
alsa-space: xrun of at least 0.002 msecs. resetting stream
alsa-space: xrun of at least 0.002 msecs. resetting stream
alsa-space: xrun of at least 0.004 msecs. resetting stream
alsa-space: xrun of at least 0.004 msecs. resetting stream
alsa-space: xrun of at least 0.002 msecs. resetting stream
alsa-space: xrun of at least 0.002 msecs. resetting stream

my lsmod:
vmnet                  27812  2
parport_pc             22980  1
vmmon                 105260  0
snd_pcm_oss            49312  0
snd_mixer_oss          18304  1 snd_pcm_oss
snd_hda_intel          14336  1
snd_hda_codec          69248  1 snd_hda_intel
snd_pcm                83716  3 snd_pcm_oss,snd_hda_intel,snd_hda_codec
snd_timer              22276  1 snd_pcm
snd                    50532  8
snd_pcm_oss,snd_mixer_oss,snd_hda_intel,snd_hda_codec,snd_pcm,snd_timer
snd_page_alloc          8068  2 snd_hda_intel,snd_pcm
lp                      8836  0
parport                21440  2 parport_pc,lp
nfsd                   91464  8
exportfs                5120  1 nfsd
nfs                    96044  1
lockd                  61992  3 nfsd,nfs
sunrpc                130500  5 nfsd,nfs,lockd
vfat                   11648  1
fat                    36252  1 vfat
i915                   18176  1
drm                    61204  2 i915
intel_agp              20380  1
agpgart                29488  3 drm,intel_agp
hw_random               4884  0
rtc                    10828  0
ehci_hcd               29576  0
usblp                  11648  0
uhci_hcd               30480  0
usbcore               107384  4 ehci_hcd,usblp,uhci_hcd

======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0001201 Can't use xmms with alsa driver (hda-in...
======================================================================

----------------------------------------------------------------------
 synx13 - 07-01-05 21:55 
----------------------------------------------------------------------
positon-fix is a card-specific option.  It only applies to snd-hda-intel. 
I get the problem (but only with Quicktime MOV files?) with my snd-cmipci
card.  Interestingly all types of movies play besides these particular
ones.  I noticed on failing to convert them to AVI/mpeg that they have a
strange bitrate:
...[mp2 @ 0x85783c8]bitrate 224 is not allowed in mp2
...Couldn't open codec mp2, br=224
Is that possibly something that could provoke this juttering of sound as
alsa-space continues to reset every quarter second or so?  Where is the
source that causes the error?  I can't find it in any of the alsa sources
I have installed.

Oh, and also I should mention I have resets at more like 0.1 - 0.2 ms, not
0.002ms.

note to sally: Try the CVS alsa-kernel sources.. is what I have, and
there's a file right under Documentation/ALSA-Configuration.txt in there. 
(:pserver:anonymous:@cvs.sourceforge.net:/cvsroot/alsa)



----------------------------------------------------------------------
 rlrevell - 12-30-05 04:25 
----------------------------------------------------------------------
Any improvement with later ALSA releases?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-10-05 19:08 theoneandonlysmNew Issue                                    
06-13-05 13:09 tiwai          Note Added: 0005008                          
06-19-05 12:30 sally          Note Added: 0005088                          
06-20-05 03:46 theoneandonlysmNote Added: 0005092                          
06-20-05 10:45 sally          Note Added: 0005094                          
06-20-05 11:23 perex          Category                 0_general => 1_pcm -
digital audio
06-21-05 01:37 theoneandonlysmNote Added: 0005100                          
06-21-05 11:13 tiwai          Note Added: 0005101                          
06-21-05 12:48 tiwai          Relationship added       has duplicate 0001201
06-25-05 05:11 sally          Note Added: 0005256                          
07-01-05 21:53 synx13         Note Added: 0005340                          
07-01-05 21:55 synx13         Note Edited: 0005340                         
12-07-05 17:58 ikonst         Issue Monitored: ikonst                      
12-30-05 04:25 rlrevell       Note Added: 0007207                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
