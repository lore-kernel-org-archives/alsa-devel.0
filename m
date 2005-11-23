From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001592]: SPDIF-out bit depth is truncated
Date: Wed, 23 Nov 2005 17:21:41 +0100
Message-ID: <bcafc0ed44216fed8818b8e582210332@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0E8F41AE
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2005 17:21:42 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1592> 
======================================================================
Reported By:                anli
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1592
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             11-22-2005 23:52 CET
Last Modified:              11-23-2005 17:21 CET
======================================================================
Summary:                    SPDIF-out bit depth is truncated
Description: 
I have tried to play back 96KHz/24bit file this way:

# aplay -Dplug:spdif 96x24.wav
Playing WAVE '96x24.wav' : Signed 24 bit Little Endian in 3bytes, Rate
96000 Hz, Stereo

During playing back I have got first four bytes of SPDIF channel status:

iecset -x
AES0=0x00,AES1=0x02,AES2=0x00,AES3=0x05

Byte AES2 has '0x00' value, which, in accordance with AES3-2003 document,
means: "Maximum audio sample word length is 20 bits (default). Use of
auxiliary sample bits not defined". You see, bit depth is truncated.

The same result was got with JACK server started at 96KHz/32bit.

P.S. I'm not sure which the issue category to select. I use ice1724 driver
(v.1.0.10). 

======================================================================

----------------------------------------------------------------------
 tiwai - 11-23-05 17:21 
----------------------------------------------------------------------
Pass proper AES* parameters together with PCM spdif open.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-22-05 23:52 anli           New Issue                                    
11-23-05 17:21 tiwai          Note Added: 0006813                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
