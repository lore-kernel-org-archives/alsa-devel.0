From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000261]: insmod says no such device ?@#!
Date: Sat, 19 Mar 2005 12:49:35 +0100
Message-ID: <b626ebf30a765092225a16754e324f23@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 8A742106
	for <alsa-devel@alsa-project.org>; Sat, 19 Mar 2005 12:49:35 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=261> 
======================================================================
Reported By:                kevkim55
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   261
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.4.18-14
======================================================================
Date Submitted:             05-07-2004 18:32 CEST
Last Modified:              03-19-2005 12:49 CET
======================================================================
Summary:                    insmod says no such device ?@#!
Description: 
I downloaded ALSA drivers version 1.0.0 and succeeded in installing the
drivers. But the problem that I face is that ALSA driver compilation
doesn't automatically recognize the sound card. From the documentation I
came to know what driver to compile. I have BENQ Joybook 3000 that comes
with ALI M5455 soundcard with Realtek AC'97 codecs. Drivers for Windows
came with the notebook. So, the sound card is working perfect on Windows
platform. But I just can't get it working. I ran sndconfig utility which
says something like 'Identified ALI M5455 PCI Audio Link. Your card is
currently supported but yours is currently disabled. This could be set
right by disabling PNP OS in your BIOs settings.'   Now my BIOS doesn't
have anything like that. The redhat-sound-config utility also identifies
the card correctly but displays "module: disabled" in the last line of the
dialog box. 
  The documentation that came with ALSA says ALI M5455 is supported and
specifies intel8x0 as the driver module. I compiled the same successfully
but modprobe/insmod display a message "Intel ICH sound card not found" and
"using /lib/mod..../intel8x0.o, init_module: no such deveice" when I try
with intel8x0.o module. 
 I tried to compile all the drivers and tried to load one by one. sb,
v_midi, uart410, MPU410, ad1878 etc load without any error messages but do
not iniialize the sound card nor the device files like /dev/dsp,
/dev/mixer, /dev/audio etc, referencing which simply says "no such
device". 
 If intel8x0.o is the right driver for ALI M5455, why intel8x.o says no
Intel ICH cards found and thus fails ? 
======================================================================

----------------------------------------------------------------------
 jdthood - 03-19-05 12:49 
----------------------------------------------------------------------
> I ran sndconfig utility

That is a utility for configuring OSS drivers, not ALSA drivers.

> when I try with intel8x0.o

That is an OSS module, not an ALSA module.

I think that this report should be closed.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-07-04 18:32 kevkim55       New Issue                                    
05-07-04 18:32 kevkim55       Kernel Version            => 2.4.18-14       
05-16-04 17:13 kevkim55       Issue Monitored: kevkim55                    
05-16-04 17:14 kevkim55       Issue End Monitor: kevkim55                    
03-19-05 12:49 jdthood        Note Added: 0004040                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
