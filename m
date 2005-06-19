From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001179]: alsa-lib 1.0.9 breaks snd_hda_intel
Date: Sun, 19 Jun 2005 12:30:33 +0200
Message-ID: <fb0acee56053d9b0d8673f815c8b7a06@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E7F2D1AA
	for <alsa-devel@alsa-project.org>; Sun, 19 Jun 2005 12:30:33 +0200 (MEST)
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
Category:                   0_general
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             06-10-2005 19:08 CEST
Last Modified:              06-19-2005 12:30 CEST
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

----------------------------------------------------------------------
 tiwai - 06-13-05 13:09 
----------------------------------------------------------------------
It's likely a problem arts with dmix plugin.
A known workaround is to set the sample rate on arts to 48000.

----------------------------------------------------------------------
 sally - 06-19-05 12:30 
----------------------------------------------------------------------
I have similar probs after finding 1.09 unsatisfactory and reverting to
1.08 (all source build)

I dont have any arts on this system, never have.

I do have simple asound dmix:

# Set default sound card
# Useful so that all settings can be changed to a different card here.
pcm.snd_card {
    type hw
    card 0
}


pcm.dmixer {
    type dmix
    ipc_key 1024
    ipc_perm 0660 # def 0600
#    pcm.slave "snd_card"
    slave {
       pcm "snd_card"
#       period_time 0 ###time OR size , not both
       period_size 1024
       buffer_size 8192 # Buffer size ensoniq 65536
#       rate 8000
#       rate 44100
    }
    bindings {
       0 0
       1 1
    }
}

removing the buffer line made no perceptible diff, removing the file
asound.conf made the errors 5x more frequent. :(

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-10-05 19:08 theoneandonlysmNew Issue                                    
06-13-05 13:09 tiwai          Note Added: 0005008                          
06-19-05 12:30 sally          Note Added: 0005088                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
