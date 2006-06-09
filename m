From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002194]: fglrx and snd_hda_intel
Date: Fri, 9 Jun 2006 04:56:26 +0200
Message-ID: <a9b6cafe96002b235dee87effe230248@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1C718175
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Jun 2006 04:56:27 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2194> 
======================================================================
Reported By:                emacspy
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   2194
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               gentoo
Kernel Version:             2.6.16-gentoo-r9
======================================================================
Date Submitted:             06-08-2006 19:33 CEST
Last Modified:              06-09-2006 04:56 CEST
======================================================================
Summary:                    fglrx and snd_hda_intel
Description: 
Iam having a problem using snd_hda_intel with fglrx. In games sound lags
but if I do a modprobe snd_hda_intel sound does not lag but video fps
suffers greatly. I am not sure if this is a problem with fglrx or
snd_hda_intel any input would be great.
======================================================================

----------------------------------------------------------------------
 rlrevell - 06-08-06 19:46 
----------------------------------------------------------------------
What sound driver is used if you do not use snd-hda-intel?

If your games support OSS, does it make any difference if you use them in
OSS or ALSA mode?

----------------------------------------------------------------------
 emacspy - 06-09-06 04:56 
----------------------------------------------------------------------
Here is my lsmod also OSS does not work at all Im using KDE if I set arts
to use OSS I get no output .Ive tryed not using ARTS at all but the same
lag effects occurs. Sometimes it goes away and everything works great but
then it goes back to either sound or video lags. I know the sound and
video are both integrated on my laptop but I have 2gigs of ram installed
so it should not be a problem. Thanks for the help and also sometimes Ive
been getting an error that cpu sound system overload in kde that just pops
up not sure if any of this helps though.
lsmod
Module                  Size  Used by
fglrx                 379628  8
snd_pcm_oss            39968  0
snd_mixer_oss          17664  1 snd_pcm_oss
snd_seq_dummy           3844  0
snd_seq_oss            34432  0
snd_seq_midi_event      6912  1 snd_seq_oss
snd_seq                50896  5
snd_seq_dummy,snd_seq_oss,snd_seq_midi_event
snd_seq_device          7692  3 snd_seq_dummy,snd_seq_oss,snd_seq
snd_hda_intel          16404  6
snd_hda_codec         144048  1 snd_hda_intel
snd_pcm                80900  5 snd_pcm_oss,snd_hda_intel,snd_hda_codec
snd_timer              21892  4 snd_seq,snd_pcm
snd                    48356  18
snd_pcm_oss,snd_mixer_oss,snd_seq_dummy,snd_seq_oss,snd_seq,snd_seq_device,snd_hda_intel,snd_hda_codec,snd_pcm,snd_timer
soundcore               8672  1 snd
snd_page_alloc          8968  2 snd_hda_intel,snd_pcm
wlan_scan_sta          14080  1
ath_pci                91684  0
ath_rate_sample        12800  1 ath_pci
wlan                  187740  4 wlan_scan_sta,ath_pci,ath_rate_sample
ath_hal               188240  3 ath_pci,ath_rate_sample

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-08-06 19:33 emacspy        New Issue                                    
06-08-06 19:33 emacspy        Distribution              => gentoo          
06-08-06 19:33 emacspy        Kernel Version            => 2.6.16-gentoo-r9
06-08-06 19:46 rlrevell       Note Added: 0010115                          
06-09-06 04:56 emacspy        Note Added: 0010130                          
======================================================================
