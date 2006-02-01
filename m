From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001804]: can't run alsamixer
Date: Wed, 1 Feb 2006 01:46:37 +0100
Message-ID: <204707ed0bcb32733b5537b88918cc3b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5D6E91F8
	for <alsa-devel@alsa-project.org>; Wed,  1 Feb 2006 01:46:37 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1804> 
======================================================================
Reported By:                puvi
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   1804
Category:                   alsamixer
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             02-01-2006 01:46 CET
Last Modified:              02-01-2006 01:46 CET
======================================================================
Summary:                    can't run alsamixer
Description: 
Trying to get my sound to work on KDE3.5

I have tried everything that I found in googling but no joy!

So I was wondering whther you guys will be able to help.

I run alsamixer and I get this:
puvi@homer ~]$ alsamixer

alsamixer: function snd_ctl_open failed for default: No such device

When I run alsaplayer, I get this
[puvi@homer ~]$ alsaplayer
snd_pcm_open: No such device (default)
Failed to initialize plugin!
Failed to register plugin: /usr/lib/alsaplayer/output/libalsa_out.so
Failed to load output plugin "alsa". Trying defaults.
snd_pcm_open: No such device (default)
Failed to initialize plugin!
/usr/lib/alsaplayer/output/libalsa_out.so failed to load

It looks like I am missig something in my /dev directory but I have no
idea what it is ...

I have the following modules inserted into the kernel:
[root@homer puvi]# /sbin/lsmod |grep snd
snd_seq_oss            36480  0
snd_seq_midi_event      8192  1 snd_seq_oss
snd_seq                58384  4 snd_seq_oss,snd_seq_midi_event
snd_seq_device          9228  2 snd_seq_oss,snd_seq
snd_intel8x0           32604  1
snd_ac97_codec         73980  1 snd_intel8x0
snd_pcm_oss            48424  0
snd_mixer_oss          18304  1 snd_pcm_oss
snd_pcm                92296  3 snd_intel8x0,snd_ac97_codec,snd_pcm_oss
snd_timer              30468  2 snd_seq,snd_pcm
snd                    55140  11
snd_seq_oss,snd_seq,snd_seq_device,snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
soundcore               9889  1 snd
snd_page_alloc         10120  2 snd_intel8x0,snd_pcm

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-01-06 01:46 puvi           New Issue                                    
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
