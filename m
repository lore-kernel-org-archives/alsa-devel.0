From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001453]: 2.6.14-rc2 "Unknown model for ALC880"
Date: Mon, 19 Dec 2005 02:22:33 +0100
Message-ID: <1ebdc688592a615df2f0c42a45f82bae@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CAE19134
	for <alsa-devel@alsa-project.org>; Mon, 19 Dec 2005 02:22:33 +0100 (MET)
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


The following issue has been RESOLVED.
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
Status:                     resolved
Distribution:               Debian sarge
Kernel Version:             2.6.14-rc2
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             09-24-2005 17:22 CEST
Last Modified:              12-19-2005 02:22 CET
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
 rlrevell - 11-23-05 20:24 
----------------------------------------------------------------------
Re: the "unknown model" and "num_steps = 0 for NID" errors, see the patch
in bug #1563.

----------------------------------------------------------------------
 rlrevell - 12-19-05 02:22 
----------------------------------------------------------------------
The "num_steps = 0" bug is fixed.  Open another bug if position_fix is
still needed with 1.0.11rc1

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
12-19-05 02:22 rlrevell       Status                   assigned => resolved
12-19-05 02:22 rlrevell       Resolution               open => fixed       
12-19-05 02:22 rlrevell       Note Added: 0007080                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
