From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001838]: Unknown model for ALC880 again, First International Computer p4m-915gd1 no sound
Date: Wed, 15 Mar 2006 19:31:34 +0100
Message-ID: <55fca069bc3440663cdbc259e4c42e6b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 00399205
	for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2006 19:31:34 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1838> 
======================================================================
Reported By:                graabein
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1838
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               Fedora Core 4
Kernel Version:             2.6.15-1.1831_FC4smp
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             02-10-2006 23:27 CET
Last Modified:              03-15-2006 19:31 CET
======================================================================
Summary:                    Unknown model for ALC880 again, First International
Computer p4m-915gd1 no sound
Description: 
I'm unable to get any sound on my FIC p4m-915gd1 motherboard's built-in
sound. There are no error messages and I can play content all I want, I
just don't get any sound.

The manufacturer's page lists the hardware as "Intel HDA, Azalia 8
Channel, Realtek ALC880":
http://www.fic.com.tw/product/motherboard/intel/p4m-915gd1.aspx

I've found other, similar reports here in the bug tracker (#1460, #1563,
#1589), including reports that this problem was resolved as of 1.0.11rc1.

Accordingly, I tried compiling alsa from cvs sources as of today, but this
made no difference. I still have no sound.

======================================================================

----------------------------------------------------------------------
 graabein - 03-15-06 18:53 
----------------------------------------------------------------------
Sorry, I explained that very badly. :-(

One of the problems I had was indeed the same as reported before (in bug
#1563).

However, I had another problem also: That my soundcard wasn't recognized
by the driver since FIC had used their own PCI IDs to identify it. These
PCI IDs need to be added to patch_realtek.c in CVS so owners of FIC
motherboards won't have to manually patch and compile alsa-drivers in the
future.

I've emailed the patch against current CVS directly to tiwai.

----------------------------------------------------------------------
 tiwai - 03-15-06 19:31 
----------------------------------------------------------------------
Thanks, the patch was applied to CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-10-06 23:27 graabein       New Issue                                    
02-10-06 23:27 graabein       Distribution              => Fedora Core 4   
02-10-06 23:27 graabein       Kernel Version            => 2.6.15-1.1831_FC4smp
02-10-06 23:38 graabein       Note Added: 0008010                          
02-15-06 23:46 Eugene Seppel  Issue Monitored: Eugene Seppel                    
02-15-06 23:46 Eugene Seppel  Note Added: 0008081                          
02-16-06 17:08 Marijn SchoutenNote Added: 0008098                          
02-16-06 17:10 Marijn SchoutenNote Edited: 0008098                         
02-16-06 18:36 er-ku          Note Added: 0008101                          
02-16-06 23:06 graabein       Note Added: 0008103                          
02-17-06 10:47 Marijn SchoutenNote Added: 0008107                          
02-17-06 16:31 Eugene Seppel  Note Added: 0008108                          
02-19-06 02:03 graabein       Note Added: 0008127                          
02-19-06 05:47 graabein       Note Added: 0008128                          
02-19-06 05:50 graabein       File Added: ficpatch.diff                    
02-19-06 05:55 rlrevell       Note Added: 0008129                          
03-06-06 00:03 graabein       Note Added: 0008360                          
03-15-06 15:31 tiwai          Status                   assigned => resolved
03-15-06 15:31 tiwai          Resolution               open => fixed       
03-15-06 15:31 tiwai          Note Added: 0008551                          
03-15-06 18:53 graabein       Status                   resolved => feedback
03-15-06 18:53 graabein       Resolution               fixed => reopened   
03-15-06 18:53 graabein       Note Added: 0008564                          
03-15-06 19:31 tiwai          Status                   feedback => resolved
03-15-06 19:31 tiwai          Resolution               reopened => fixed   
03-15-06 19:31 tiwai          Note Added: 0008567                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
