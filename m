From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000802]: ymfpci seems to export wrong values for period_count/period_size/buffer_size
Date: Tue, 18 Jan 2005 13:28:58 +0100
Message-ID: <7d31cc31ccea20cef64e9eb31ee3dbd4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D357225E
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2005 13:28:58 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=802> 
======================================================================
Reported By:                slomosnail
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   802
Category:                   PCI - ymfpci
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             01-10-2005 18:42 CET
Last Modified:              01-18-2005 13:28 CET
======================================================================
Summary:                    ymfpci seems to export wrong values for
period_count/period_size/buffer_size
Description: 
See here: http://bugzilla.gnome.org/show_bug.cgi?id=162024
======================================================================

----------------------------------------------------------------------
 tiwai - 01-11-05 16:48 
----------------------------------------------------------------------
Its periods_min=3.  Maybe this confuses gstreamer?

----------------------------------------------------------------------
 LeRoutier - 01-18-05 13:28 
----------------------------------------------------------------------
gst-plugins CVS now uses those min/max probing functions :
snd_pcm_hw_params_get_[rate/periods/period_size]_[min/max]

to probe the hardware caps.

unfortunatly, it seems that they return garbage for this driver :
period_count : MIN= 0 & MAX=204522253
period_size  : MIN=22 & MAX=4294967295
buffer_size  : MIN=10 & MAX=4294967294

so, unless i misused them in gst-plugins probing code, values this driver
return are bad. (ad period_count < 3 won't work with this hardware)

i used those on my own hardware, and i got (nforce2/i810_ac97)
hw:0	 from 1 to 1024 (real device)
plughw:0 from 0 to 4294967295 (software device)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-10-05 18:42 slomosnail     New Issue                                    
01-11-05 16:48 tiwai          Note Added: 0003156                          
01-18-05 13:28 LeRoutier      Note Added: 0003248                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
