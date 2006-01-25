From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001768]: ALi5451 AC'97 mixer error on boot
Date: Thu, 26 Jan 2006 00:50:30 +0100
Message-ID: <8318942977fb37732570acfed724b8a9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 815501A0
	for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2006 00:50:31 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1768> 
======================================================================
Reported By:                liontooth
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1768
Category:                   PCI - ali5451
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Debian sid
Kernel Version:             2.6.15
======================================================================
Date Submitted:             01-22-2006 12:53 CET
Last Modified:              01-26-2006 00:50 CET
======================================================================
Summary:                    ALi5451 AC'97 mixer error on boot
Description: 
On a Debian 2.6.15 kernel and the ALi5451 chipset, I get this in dmesg:

AC'97 1 does not respond - RESET
AC'97 1 access is not valid [0xffffffff], removing mixer.
ali mixer 1 creating error.


======================================================================

----------------------------------------------------------------------
 liontooth - 01-22-06 13:00 
----------------------------------------------------------------------
The "Additional information" about the AC97 softmodem oops may be
irrelevant; the problem there may be caused by the failure to free the
device from the serial driver.

----------------------------------------------------------------------
 sashak - 01-26-06 00:50 
----------------------------------------------------------------------
I think there is crazy configuration - this modem is actually not ali5451,
but ali5457, and since everything is integrated in same chip (south
bridge) secondary codec is indicated in al5451 registers. Hmm, probably
should be some difference against "convensional" two codecs ali5451 setup.
Could you upload your '/proc/asound/card0/ali5451' file and lspci -vv
output?

And yes, the oops is irrelevant for ALSA.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-22-06 12:53 liontooth      New Issue                                    
01-22-06 12:53 liontooth      File Added: alsa-sigillo-2.6.15                   

01-22-06 12:53 liontooth      Distribution              => Debian sid      
01-22-06 12:53 liontooth      Kernel Version            => 2.6.15          
01-22-06 12:56 liontooth      Issue Monitored: liontooth                    
01-22-06 13:00 liontooth      Note Added: 0007745                          
01-26-06 00:50 sashak         Note Added: 0007782                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
