From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000836]: Intel HDA (C-Media 9880) - alsamixer/gamix - no slider control for Surround/Center/LFE/Side
Date: Fri, 21 Jan 2005 08:16:34 +0100
Message-ID: <bf064e679c064c31e18f1d36c3522885@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 55FF3222
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2005 08:16:34 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=836> 
======================================================================
Reported By:                jbrsubscribe
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   836
Category:                   PCI - azx
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     feedback
Distribution:               Suse
Kernel Version:             2.6.8-24.10-smp
======================================================================
Date Submitted:             01-19-2005 18:19 CET
Last Modified:              01-21-2005 08:16 CET
======================================================================
Summary:                    Intel HDA (C-Media 9880) - alsamixer/gamix - no
slider control for Surround/Center/LFE/Side
Description: 
Unable to set volume control for Surround/Center/LFE/Side due to the fact
that the sliders for these entities do not function in alsamixer and
gamix. The sliders cannot be manipulated. The only functional sliders are
PCM, PC Speaker and the two (2) Capture sliders.
In KAMix, KMix and QAMix the sliders for Surround/Center/LFE/Side do not
appear at all.
======================================================================

----------------------------------------------------------------------
 1g0R - 01-21-05 05:56 
----------------------------------------------------------------------
Hi tiwai and jbrsubscribe

My volume slide still not working. I upload a screenshot to my issue
nr.0000822.
I try everything to make work.I dont know why not working the PCM volume
slide.
The SPDIF out problem is secondary.First i need to controll PCM
volume.Please help me.Thanks you.

----------------------------------------------------------------------
 mab - 01-21-05 08:16 
----------------------------------------------------------------------
Hi Tiwai, Jbsubscribe, 1gor

I have problem imilar to the 1gor's Not sound, no PCM slider. ..
How you dump the alsa configuration? in the module listing snd_pcm_oss is
no in use, it is a problem?

running FC3 2.6.10-1.741FC3smp ASUS P5AD2-E premiun and 1.0.8. 

% lsmod
snd_azx                16096  2
snd_hda_codec          43008  1 snd_azx
snd_pcm_oss            55712  0                 <<<<<< ?????? What's
mean?
snd_mixer_oss          19456  1 snd_pcm_oss
snd_pcm                92036  3 snd_azx,snd_hda_codec,snd_pcm_oss
snd_timer              24964  1 snd_pcm
snd                    61060  10
snd_azx,snd_hda_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
soundcore               9824  1 snd
snd_page_alloc         10500  2 snd_azx,snd_pcm

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-19-05 18:19 jbrsubscribe   New Issue                                    
01-19-05 18:19 jbrsubscribe   File Added: aadebug                          
01-19-05 18:19 jbrsubscribe   Distribution              => Suse            
01-19-05 18:19 jbrsubscribe   Kernel Version            => 2.6.8-24.10-smp 
01-19-05 18:27 jbrsubscribe   Issue Monitored: jbrsubscribe                    
01-19-05 18:36 tiwai          Status                   new => resolved     
01-19-05 18:36 tiwai          Resolution               open => not an issue
01-19-05 18:36 tiwai          Assigned To               => tiwai           
01-19-05 18:36 tiwai          Note Added: 0003311                          
01-19-05 18:36 tiwai          Assigned To              tiwai =>            
01-20-05 01:07 jbrsubscribe   Status                   resolved => feedback
01-20-05 01:07 jbrsubscribe   Resolution               not an issue => reopened
01-20-05 01:07 jbrsubscribe   Note Added: 0003320                          
01-20-05 01:51 jbrsubscribe   Note Added: 0003321                          
01-20-05 11:52 1g0R           Note Added: 0003325                          
01-20-05 18:42 jbrsubscribe   Note Added: 0003328                          
01-20-05 19:11 tiwai          Note Added: 0003331                          
01-21-05 00:30 jbrsubscribe   Note Added: 0003335                          
01-21-05 05:56 1g0R           Note Added: 0003338                          
01-21-05 08:16 mab            Note Added: 0003339                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
