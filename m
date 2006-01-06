From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001721]: Alsa 1.0.10 & 1.0.11rc2: STAC_9223 unsupported/errors, only oss-emulation works with 2 channels
Date: Fri, 6 Jan 2006 15:19:56 +0100
Message-ID: <e4e80af3ee10fce5aa3c3a89ab743e49@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 38AAB13F
	for <alsa-devel@alsa-project.org>; Fri,  6 Jan 2006 15:19:56 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1721> 
======================================================================
Reported By:                oslo
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1721
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo Linux
Kernel Version:             2.6.14-gentoo-r5 #18 SMP PREEMPT
======================================================================
Date Submitted:             01-06-2006 15:19 CET
Last Modified:              01-06-2006 15:19 CET
======================================================================
Summary:                    Alsa 1.0.10 & 1.0.11rc2: STAC_9223
unsupported/errors, only oss-emulation works with 2 channels
Description: 
As in summary, alsa 1.0.11rc2 works not at all, alsa-kernel 1.0.10 only
with oss-emulation and 2 channel stereo.

My Board is an 
Intel Desktop Board D945PVS with 7.1 Surround Sound (Sigmatel 9223)with 5
analog jacks in the back, 2 on the board (Front Panel) and a digital jack
in the back.

The mixer shows only a "Front" (somtimes a "Headphones" on 1.0.11rc2)
device.

When starting "aplay" i get:
  ALSA lib pcm_direct.c:783:(snd_pcm_direct_initialize_slave)
snd_pcm_hw_params_any failed
  ALSA lib pcm_dmix.c:831:(snd_pcm_dmix_open) unable to initialize slave
  aplay: main:544: audio open error: Invalid argument

also on every other alsa using software

I'v taken a look into the "[cvs/1.0.11rc2] patch_sigmatel.c" and there
probably should be something like (After Line 277):
        { .pci_subvendor = PCI_VENDOR_ID_INTEL,
          .pci_subdevice = 0x0707,
          .config = STAC_D945GTP5 },    /* Intel D945PVS - 5 Stack */

but for me this changed nothing... 

The output of lspci is appended.

I hope this is enough information, if not tell me what you need.

PS: For me this is a major bug, butunsupported cards are generally
features?
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-06-06 15:19 oslo           New Issue                                    
01-06-06 15:19 oslo           File Added: intel_hda_stac9223.txt                
   
01-06-06 15:19 oslo           Distribution              => Gentoo Linux    
01-06-06 15:19 oslo           Kernel Version            => 2.6.14-gentoo-r5 #18
SMP PREEMPT
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
