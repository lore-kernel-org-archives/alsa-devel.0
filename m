From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001453]: 2.6.14-rc2 "Unknown model for ALC880"
Date: Fri, 14 Oct 2005 13:17:53 +0200
Message-ID: <42c7affe2714a4f11942da874e6bed2e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6834A193
	for <alsa-devel@alsa-project.org>; Fri, 14 Oct 2005 13:17:53 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1453> 
======================================================================
Reported By:                honschu
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1453
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               Debian sarge
Kernel Version:             2.6.14-rc2
======================================================================
Date Submitted:             09-24-2005 17:22 CEST
Last Modified:              10-14-2005 13:17 CEST
======================================================================
Summary:                    2.6.14-rc2 "Unknown model for ALC880"
Description: 
I have a Aopen i915Gm-HFS Motherboard with intel-hda chipset.
Sound output (input not) works in kernel 2.6.12.

For Kernel 2.6.14-rc2 I get error on boottime (see below)

If you want me to do tests, feel free to ask.

[...]
hda_codec: Unknown model for ALC880, trying auto-probe from BIOS...
hda_codec: num_steps = 0 for NID=0x8
hda_codec: num_steps = 0 for NID=0x8
hda_codec: num_steps = 0 for NID=0x8
[...]
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
[...]
hda_codec: num_steps = 0 for NID=0x8
hda_codec: num_steps = 0 for NID=0x8
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0x8
hda_codec: num_steps = 0 for NID=0x8
[...]

======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0001429 hda_codec: Unknown model for ALC880
======================================================================

----------------------------------------------------------------------
 tiwai - 10-11-05 16:29 
----------------------------------------------------------------------
Try to pass position_fix=2 option additionally.

----------------------------------------------------------------------
 honschu - 10-14-05 13:17 
----------------------------------------------------------------------
yes, that does the trick. Thanks!
Will this be setup up automatically in a future release of the module?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-24-05 17:22 honschu        New Issue                                    
09-24-05 17:22 honschu        Distribution              => Debian sarge    
09-24-05 17:22 honschu        Kernel Version            => 2.6.14-rc2      
09-24-05 22:06 rlrevell       Relationship added       duplicate of 0001429
10-05-05 18:34 tiwai          Note Added: 0006430                          
10-10-05 18:35 honschu        Note Added: 0006449                          
10-11-05 16:29 tiwai          Note Added: 0006452                          
10-14-05 13:17 honschu        Note Added: 0006479                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
