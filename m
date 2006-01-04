From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001707]: Better support for new USB-Microphone Samson C01U
Date: Wed, 4 Jan 2006 17:23:27 +0100
Message-ID: <75cd903dd411622887e7ccc4740d3e51@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 10C70154
	for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2006 17:23:27 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1707> 
======================================================================
Reported By:                Toph
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1707
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   tweak
Priority:                   normal
Status:                     assigned
Distribution:               gentoo
Kernel Version:             2.6.15-ck1
======================================================================
Date Submitted:             01-03-2006 22:42 CET
Last Modified:              01-04-2006 17:23 CET
======================================================================
Summary:                    Better support for new USB-Microphone Samson C01U
Description: 
I recently bought this microphone:
http://www.samsontech.com/products/productpage.cfm?prodID=1810&brandID=2
and have been quite pleased to see that it kind of works with alsa. I've
only been puzzled by a few oddities: Although the mic is mono, I get a
stereo input with 2 controls, which did even influence the sound on both
channels separatly, but in a not-so-clear way.

Since neither the windows, nor the OSX usb-audio driver are able to fully
control the device, especially the internal gain-control, Samson has
published a modified driver & tool to control such parameters. I have
investigated that tool with an usb-traffic sniffer (usbsnoop).

I did also do some experiments with the alsa driver to see, what the
controls really do and how the device might be designed internally. I have
found out about everything needed to make the device fully supported, I
just don't really know how to implement it, so I'm hoping someone will
guide and help me. Although I'd really like to, I'm not a kernel hacker.

What I basically want to do is remap and rename the mixer-controls and
output lines alsa exposes. Is that what the quirks are for?

Details about the device and my findings follow below:
======================================================================

----------------------------------------------------------------------
 tiwai - 01-04-06 17:23 
----------------------------------------------------------------------
I recommend you to post this to alsa-devel ML rather than here on BTS in
cases of not real "bugs"...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-03-06 22:42 Toph           New Issue                                    
01-03-06 22:42 Toph           Distribution              => gentoo          
01-03-06 22:42 Toph           Kernel Version            => 2.6.15-ck1      
01-04-06 16:58 Toph           Issue Monitored: Toph                        
01-04-06 17:23 tiwai          Note Added: 0007438                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
