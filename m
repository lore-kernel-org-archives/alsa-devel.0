From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000685]: Doom3 doesn't work with alsa backend
Date: Thu, 2 Dec 2004 19:27:38 +0100
Message-ID: <4bbb3b3639d02903b74ad35b6cfa3bac@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id F1A13245
	for <alsa-devel@alsa-project.org>; Thu,  2 Dec 2004 19:27:38 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=685> 
======================================================================
Reported By:                darkbrain
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   685
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               debian
Kernel Version:             2.6.9-nitro4
======================================================================
Date Submitted:             11-28-2004 14:55 CET
Last Modified:              12-02-2004 19:27 CET
======================================================================
Summary:                    Doom3 doesn't work with alsa backend
Description: 
Latest doom3 client for linux has alsa support built in but doesn't work
with my Hercules Fortissimo II (cs4624).

The game show me this error:
idAudioHardwareALSA::Write: 4096 frames overflowed and dropped

dmesg output:
ALSA sound/pci/cs46xx/cs46xx_lib.c:1355: open front channel
ALSA sound/pci/cs46xx/cs46xx_lib.c:897: snd_cs46xx_playback_hw_params
start
ALSA sound/pci/cs46xx/dsp_spos_scb_lib.c:1312: dsp_spos: creating SRC
"SrcTask_SCB1"
ALSA sound/pci/cs46xx/dsp_spos_scb_lib.c:603: dsp_spos: setting
SrcTask_SCB1 rate to 44100
ALSA sound/pci/cs46xx/dsp_spos_scb_lib.c:296: dsp_spos: creating SCB
<SrcTask_SCB1>
ALSA sound/pci/cs46xx/dsp_spos_scb_lib.c:1337: dsp_spos: creating PCM
"PCMReader_SCB2" (1)
ALSA sound/pci/cs46xx/dsp_spos_scb_lib.c:296: dsp_spos: creating SCB
<PCMReader_SCB2>
ALSA sound/pci/cs46xx/cs46xx_lib.c:933: period_size (32), periods (1024)
buffer_size(32768)
ALSA sound/pci/cs46xx/dsp_spos_scb_lib.c:226:
cs46xx_dsp_proc_free_scb_desc: freeing PCMReader_SCB2
ALSA sound/pci/cs46xx/dsp_spos_scb_lib.c:226:
cs46xx_dsp_proc_free_scb_desc: freeing SrcTask_SCB1


======================================================================

----------------------------------------------------------------------
 tiwai - 12-02-04 19:27 
----------------------------------------------------------------------
Any test case program to reproduce this bug?
Otherwise it's hard to debug.  Sorry, it's too little information.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-28-04 14:55 darkbrain      New Issue                                    
11-28-04 14:55 darkbrain      Distribution              => debian          
11-28-04 14:55 darkbrain      Kernel Version            => 2.6.9-nitro4    
11-28-04 14:56 darkbrain      Issue Monitored: darkbrain                    
12-02-04 19:27 tiwai          Note Added: 0002692                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
