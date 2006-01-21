From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001765]: Issue 001595 does not fix Audigy 4
Date: Sun, 22 Jan 2006 00:19:35 +0100
Message-ID: <d463245146f344ff66e89692f895cc32@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C4250197
	for <alsa-devel@alsa-project.org>; Sun, 22 Jan 2006 00:19:35 +0100 (MET)
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


The following issue requires your FEEDBACK.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1765> 
======================================================================
Reported By:                alexholkner
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1765
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     feedback
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             01-21-2006 01:49 CET
Last Modified:              01-22-2006 00:19 CET
======================================================================
Summary:                    Issue 001595 does not fix Audigy 4
Description: 
I have an Audigy 4 with the same device/subsystem as khampf from issue
1595.  I applied his patch, but it does NOT work unless I change
.ca0102_chip = 1 to .ca0108_chip = 1.

I did experience the same confusion where loading one driver with ca0108
will make any subsequent driver work (e.g., ca0102) until the next reboot.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001595 Audigy 4 (bulk, non-Pro) unsupported (p...
======================================================================

----------------------------------------------------------------------
 jcdutton - 01-22-06 00:19 
----------------------------------------------------------------------
Please note that some settings on the sound card can survive a warm
reboot.
When testing, please cold reboot. I.e. Power off the PC.
So, happily do modprobe/rmmod to test the patches, but then do a final
cold reboot to double check it BEFORE posting anything more to this bug
report.

By default, without any patches, the following will be applied:
        {.vendor = 0x1102, .device = 0x0008,
         .driver = "Audigy2", .name = "Audigy 2 Value [Unknown]", 
         .id = "Audigy2",
         .emu10k2_chip = 1,
         .ca0108_chip = 1,
         .ac97_chip = 1} ,

So, if for "fix" is exactly the same as that, it is not a fix at all. :-)

If you do find another options that works reliably after a cold reboot,
please post the entire record, not just one line of it.

Do not try the options:
         .ca_cardbus_chip = 1,
         .spi_dac = 1,
Something that might be worth trying could be adding:
         .spk71 = 1,

Also, if one does post a new record for the card, please also include the
output of:
cat /proc/asound/version
cat /proc/asound/cards

Thank you


Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-21-06 01:49 alexholkner    New Issue                                    
01-22-06 00:06 jcdutton       Status                   new => assigned     
01-22-06 00:06 jcdutton       Assigned To               => jcdutton        
01-22-06 00:06 jcdutton       Relationship added       related to 0001595  
01-22-06 00:19 jcdutton       Note Added: 0007741                          
01-22-06 00:19 jcdutton       Status                   assigned => feedback
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
