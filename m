From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000537]: VIA VT8237: rear L/R switched with Center/LFE
Date: Wed, 10 Nov 2004 14:01:34 +0100
Message-ID: <f37122bbb3eaee30c2349bf42208f083@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 443DB242
	for <alsa-devel@alsa-project.org>; Wed, 10 Nov 2004 14:01:35 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=537> 
======================================================================
Reported By:                gertverv
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   537
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Fedora Core 2
Kernel Version:             2.6.8.1
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             09-24-2004 19:41 CEST
Last Modified:              11-10-2004 14:01 CET
======================================================================
Summary:                    VIA VT8237: rear L/R switched with Center/LFE
Description: 
While playing back 5.1 audio, it looks like the rear L/R channels are
swapped with the Center/LFE channels. The rear L/R and Center/LFE are
connected via Gigabyte Surround-Kit.


======================================================================

----------------------------------------------------------------------
 tiwai - 10-14-04 12:28 
----------------------------------------------------------------------
Then we need a software routing.
Please try the attached patch for the driver.  Then, copy
the attached VIA8237.conf to /usr/share/alsa/cards.

----------------------------------------------------------------------
 gertverv - 10-14-04 18:51 
----------------------------------------------------------------------
Thanks, now it seems to work. I tested the patch and config file with the
speaker-test program and playing back a DVD with xine.

I noticed with alsamixer that when I was running the speaker-test program,
that the Line-In was switched to surround (also the sound of the TV card
connected to line-in disappeared).
In the VIA8237.conf, I changed the value of "Line-In As Surround" and "Mic
As Center/LFE" to off. Because I have the rear L/R and Center/LFE
connected via the Gigabyte Surround kit, so I don't have to use the
Line-In and Mic connectors for this.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-24-04 19:41 gertverv       New Issue                                    
09-24-04 19:41 gertverv       Distribution              => Fedora Core 2   
09-24-04 19:41 gertverv       Kernel Version            => 2.6.8.1         
09-24-04 19:50 gertverv       Note Added: 0001903                          
10-12-04 15:06 tiwai          Note Added: 0002104                          
10-12-04 18:21 gertverv       Note Added: 0002106                          
10-13-04 16:20 tiwai          Note Added: 0002125                          
10-13-04 16:20 tiwai          File Added: via-6ch-slot.diff                    
10-13-04 19:21 gertverv       Note Added: 0002133                          
10-14-04 12:28 tiwai          Note Added: 0002140                          
10-14-04 12:29 tiwai          File Added: via8237.diff                     
10-14-04 12:29 tiwai          File Added: VIA8237.conf                     
10-14-04 18:51 gertverv       Note Added: 0002158                          
11-10-04 14:01 tiwai          Status                   new => resolved     
11-10-04 14:01 tiwai          Resolution               open => fixed       
11-10-04 14:01 tiwai          Assigned To               => tiwai           
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
