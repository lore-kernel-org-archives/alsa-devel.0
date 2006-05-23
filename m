From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002145]: Quiet sound, no master channel, no PCM channel and no ability to switch to non-8ch mode
Date: Tue, 23 May 2006 02:19:09 +0200
Message-ID: <b3a9ea90a6a7240907d2f24cedfe4614@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5EA6A21F
	for <alsa-devel@alsa-project.org>; Tue, 23 May 2006 02:19:09 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2145> 
======================================================================
Reported By:                rathann
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2145
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 5
Kernel Version:             2.6.16-1.2111_FC5 (SMP)
======================================================================
Date Submitted:             05-23-2006 00:22 CEST
Last Modified:              05-23-2006 02:19 CEST
======================================================================
Summary:                    Quiet sound, no master channel, no PCM channel and
no ability to switch to non-8ch mode
Description: 
1. Sound is very quiet. I need to set every channel to max to have decent
volume.
2. There's no master channel and there's no PCM channel.
3. There's a switch to change the number of output channels, but it has
only one option: 8ch (card supports 2-8ch).
======================================================================

----------------------------------------------------------------------
 rlrevell - 05-23-06 01:51 
----------------------------------------------------------------------
There is definitely a PCM channel, but you're right about the lack of
Master and buggy Channel Mode switch.

Are you testing 1.0.11 or 1.0.11-rc2 (which comes with 2.6.16 kernel)?

Please post the contents of /proc/asound/card0/codec97#0/ac97#0-0

----------------------------------------------------------------------
 rathann - 05-23-06 02:19 
----------------------------------------------------------------------
(about PCM)
You're right, it's there. It wasn't there in 1.0.11rc2, but I forgot to
re-check after upgrading to 1.0.11 final. Sorry for misinformation.

(about version)
I was using 1.0.11rc2 which came with FC5 kernel package, but I followed
the instructions at http://people.redhat.com/stransky/alsa/ and installed
1.0.11. Since the problem with the channel switch persisted, I filed this
bugreport.

$ cat /proc/asound/card0/codec97#0/ac97#0-0
cat: /proc/asound/card0/codec97#0/ac97#0-0: No such file or directory
$ ls -l /proc/asound/card0/
total 0
-r--r--r-- 1 root root 0 May 23 02:17 codec#0
-r--r--r-- 1 root root 0 May 23 02:17 id
-rw-r--r-- 1 root root 0 May 23 02:17 oss_mixer
dr-xr-xr-x 4 root root 0 May 23 02:17 pcm0c
dr-xr-xr-x 3 root root 0 May 23 02:17 pcm0p
dr-xr-xr-x 4 root root 0 May 23 02:17 pcm1c
$ lsmod | grep snd
snd_hda_intel          53020  2
snd_hda_codec         197120  1 snd_hda_intel
snd_seq_dummy          37508  0
snd_seq_oss            67584  0
snd_seq_midi_event     41344  1 snd_seq_oss
snd_seq                89856  5
snd_seq_dummy,snd_seq_oss,snd_seq_midi_event
snd_seq_device         42512  3 snd_seq_dummy,snd_seq_oss,snd_seq
snd_pcm_oss            75936  0
snd_mixer_oss          51328  1 snd_pcm_oss
snd_pcm               125832  3 snd_hda_intel,snd_hda_codec,snd_pcm_oss
snd_timer              58632  2 snd_seq,snd_pcm
snd                    96744  14
snd_hda_intel,snd_hda_codec,snd_seq_dummy,snd_seq_oss,snd_seq,snd_seq_device,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
soundcore              44129  1 snd
snd_page_alloc         44176  2 snd_hda_intel,snd_pcm

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-23-06 00:22 rathann        New Issue                                    
05-23-06 00:22 rathann        Distribution              => Fedora Core 5   
05-23-06 00:22 rathann        Kernel Version            => 2.6.16-1.2111_FC5
(SMP)
05-23-06 00:39 rlrevell       Note Added: 0009920                          
05-23-06 01:46 rathann        Note Added: 0009921                          
05-23-06 01:51 rlrevell       Note Added: 0009922                          
05-23-06 02:19 rathann        Note Added: 0009923                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
