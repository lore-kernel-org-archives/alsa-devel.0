From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001803]: hda-intel on my amilo fujitsu laptop dont produces any sound
Date: Wed, 1 Feb 2006 18:27:24 +0100
Message-ID: <54a08f22b1d2f261930afe2bc11eb988@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 47C4E1E1
	for <alsa-devel@alsa-project.org>; Wed,  1 Feb 2006 18:27:24 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1803> 
======================================================================
Reported By:                DjCoke
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1803
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.15-gentoo-r1
======================================================================
Date Submitted:             01-31-2006 23:30 CET
Last Modified:              02-01-2006 18:27 CET
======================================================================
Summary:                    hda-intel on my amilo fujitsu laptop dont produces
any sound
Description: 
driver don't procuce any sound at all.


I have a amilo fujitsu laptop.
======================================================================

----------------------------------------------------------------------
 DjCoke - 01-31-06 23:34 
----------------------------------------------------------------------
uname -a:
Linux Gentoo 2.6.15-gentoo-r1 #1 SMP Tue Jan 31 20:25:47 CET 2006 i686
Intel(R) Pentium(R) M processor 1.73GHz GenuineIntel GNU/Linux

lspci | grep -i audio produces:
0000:00:1b.0 Class 0403: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family)
High Definition Audio Controller (rev 04)

I tried 2 versions of alsa and the builtin driver from the kernel all wont
produces any sound

lsmod produces:
Gentoo ~ # lsmod
Module Size Used by
snd_pcm_oss 43424 0
snd_mixer_oss 15488 1 snd_pcm_oss
snd_seq_oss 30592 0
snd_seq_midi_event 6656 1 snd_seq_oss
snd_seq 45776 4 snd_seq_oss,snd_seq_midi_event
snd_seq_device 7948 2 snd_seq_oss,snd_seq
snd_hda_intel 14608 0
snd_hda_codec 114816 1 snd_hda_intel
snd_pcm 70916 3 snd_pcm_oss,snd_hda_intel,snd_hda_codec
snd_timer 20100 2 snd_seq,snd_pcm
snd 46144 9
snd_pcm_oss,snd_mixer_oss,snd_seq_oss,snd_seq,snd_seq_device,snd_hda_intel,snd_hda_codec,snd_pcm,snd_timer
snd_page_alloc 9224 2 snd_hda_intel,snd_pcm
fglrx 232124 7

I tried now also the cvs version, it wont work.
I tried pass the option model=fujitsu wont work.

options snd-hda-intel model=fujitsu position_fix=1

dmesg produces this error on loading:
dmesg | grep -i hda
hda_codec: Unknown model for ALC880, trying auto-probe from BIOS...

Ive readed solutions here but they wont work

----------------------------------------------------------------------
 DjCoke - 02-01-06 18:27 
----------------------------------------------------------------------
Tried as said in ALSA-configuration.txt several models, but dmesg keeping
me saying that hda_codec: Unknown model for ALC880, trying auto-probe from
BIOS...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-31-06 23:30 DjCoke         New Issue                                    
01-31-06 23:30 DjCoke         Distribution              => Gentoo          
01-31-06 23:30 DjCoke         Kernel Version            => 2.6.15-gentoo-r1
01-31-06 23:32 DjCoke         Issue Monitored: DjCoke                      
01-31-06 23:34 DjCoke         Note Added: 0007856                          
02-01-06 18:27 DjCoke         Note Added: 0007862                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
