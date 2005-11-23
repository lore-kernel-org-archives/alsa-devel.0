From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001453]: 2.6.14-rc2 "Unknown model for ALC880"
Date: Wed, 23 Nov 2005 20:24:26 +0100
Message-ID: <97e0959394562c5b0d40e52bad284c1a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C0F8D1B4
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2005 20:24:26 +0100 (MET)
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
Last Modified:              11-23-2005 20:24 CET
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
 honschu - 10-14-05 13:17 
----------------------------------------------------------------------
yes, that does the trick. Thanks!
Will this be setup up automatically in a future release of the module?

----------------------------------------------------------------------
 rlrevell - 11-23-05 20:24 
----------------------------------------------------------------------
Re: the "unknown model" and "num_steps = 0 for NID" errors, see the patch
in bug #1563.

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
11-22-05 19:19 rlrevell       Relationship added       duplicate of 0000790
11-22-05 19:29 rlrevell       Relationship deleted     duplicate of 0000790
11-22-05 21:41 mbab           Issue Monitored: mbab                        
11-23-05 20:24 rlrevell       Note Added: 0006826                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
