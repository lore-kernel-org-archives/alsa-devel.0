From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001670]: Mic no longer works, can't seem to change anything to fix it
Date: Thu, 22 Dec 2005 06:04:47 +0100
Message-ID: <9424820e64eef8ce3af6df69b948e22e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7A4501A7
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2005 06:04:47 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1670> 
======================================================================
Reported By:                callihn
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1670
Category:                   PCI - cmipci
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 4
Kernel Version:             ALL, currently vanilla 2.6.14.4
======================================================================
Date Submitted:             12-22-2005 02:25 CET
Last Modified:              12-22-2005 06:04 CET
======================================================================
Summary:                    Mic no longer works, can't seem to change anything
to fix it
Description: 
Everything was working fine in FC2, now that I have upgraded to FC4 I can
no longer get the mic to work, using the same asound.state as posted below
in both and everything else still works as it did before, also I know the
mic does work because unmuting it allows me to hear it in loopback, not
sure if it means anything but in alsamixer the capture option on the mic
does blink when in use but again I can get no sound out of it other than
loopback from unmuting it in the playback section.
======================================================================

----------------------------------------------------------------------
 callihn - 12-22-05 05:25 
----------------------------------------------------------------------
Also here is my card:

01:00.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev
10)

And lsmod | grep snd says:

snd_cmipci             38048  0 
gameport               15752  1 snd_cmipci
snd_seq_dummy           3972  0 
snd_seq_oss            38272  0 
snd_seq_midi_event      7552  1 snd_seq_oss
snd_seq                55376  5
snd_seq_dummy,snd_seq_oss,snd_seq_midi_event
snd_pcm_oss            55072  0 
snd_mixer_oss          19840  1 snd_pcm_oss
snd_pcm                96264  4
snd_intel8x0,snd_ac97_codec,snd_cmipci,snd_pcm_oss
snd_page_alloc         11272  2 snd_intel8x0,snd_pcm
snd_opl3_lib           12032  1 snd_cmipci
snd_timer              26756  3 snd_seq,snd_pcm,snd_opl3_lib
snd_hwdep              10372  1 snd_opl3_lib
snd_mpu401_uart         8320  1 snd_cmipci
snd_rawmidi            26656  1 snd_mpu401_uart
snd_seq_device          9356  5
snd_seq_dummy,snd_seq_oss,snd_seq,snd_opl3_lib,snd_rawmidi
snd                    58212  15
snd_intel8x0,snd_ac97_codec,snd_cmipci,snd_seq_dummy,snd_seq_oss,snd_seq,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_opl3_lib,snd_timer,snd_hwdep,snd_mpu401_uart,snd_rawmidi,snd_seq_device
soundcore              10592  1 snd


Also if it helps any FC2 was using Alsa 1.0.9rc2


I have installed the Alsa 1.0.11rc1 drivers but that didn't help which I
suspected since the drivers are in the kernel and I had no issues with
2.6.14..3 before, but I'm beating my head against the wall here.



----------------------------------------------------------------------
 callihn - 12-22-05 06:04 
----------------------------------------------------------------------
I found a fix, though I don't understand it it works:

cp /etc/alsa/cards/CMI8738-MC6.conf ~/.asound.rc

Then restart Alsa and the mic works correctly.

Keep in mind that I have never used ~/.asound.rc before I just loaded the
drivers and it worked.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-22-05 02:25 callihn        New Issue                                    
12-22-05 02:25 callihn        Distribution              => Fedora Core 4   
12-22-05 02:25 callihn        Kernel Version            => ALL, currently
vanilla 2.6.14.4
12-22-05 05:13 callihn        Note Added: 0007119                          
12-22-05 05:15 callihn        Note Edited: 0007119                         
12-22-05 05:23 callihn        Note Edited: 0007119                         
12-22-05 05:25 callihn        Note Edited: 0007119                         
12-22-05 06:04 callihn        Note Added: 0007120                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
