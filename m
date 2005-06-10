From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001179]: alsa-lib 1.0.9 breaks snd_hda_intel
Date: Fri, 10 Jun 2005 19:08:11 +0200
Message-ID: <f9cfc7d6488f81a8b7115774b6868389@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id ADB481B0
	for <alsa-devel@alsa-project.org>; Fri, 10 Jun 2005 19:08:11 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1179> 
======================================================================
Reported By:                theoneandonlysm
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1179
Category:                   0_general
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             06-10-2005 19:08 CEST
Last Modified:              06-10-2005 19:08 CEST
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-10-05 19:08 theoneandonlysmNew Issue                                    
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
