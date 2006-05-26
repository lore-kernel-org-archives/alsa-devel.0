From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002149]: No sound,
	with Ensoniq 5880 AudioPCI
Date: Fri, 26 May 2006 14:45:01 +0200
Message-ID: <f8d28328b38c6246f69f2c1c6eb11093@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D0F7C155
	for <alsa-devel@alsa-project.org>;
	Fri, 26 May 2006 14:45:01 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2149> 
======================================================================
Reported By:                sergiopr
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2149
Category:                   PCI - ens1371
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             kernel-2.6.16-1.2111_FC5
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             05-23-2006 10:25 CEST
Last Modified:              05-26-2006 14:45 CEST
======================================================================
Summary:                    No sound, with Ensoniq 5880 AudioPCI
Description: 
After a fresh install of Fedora Core 5, firstboot and
system-config-souncard utilities correctly detect the sound card, but no
sound comes from the speakers.

Furthermore, aplay -l gives:
aplay: device_list:222: no soundcards found...
======================================================================

----------------------------------------------------------------------
 sergiopr - 05-26-06 10:38 
----------------------------------------------------------------------
It seems to be a problem with acpi. The souncard works booting with
acpi=off in the kernel line. Please, close this bug.

----------------------------------------------------------------------
 tiwai - 05-26-06 14:45 
----------------------------------------------------------------------
OK, let's close.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-23-06 10:25 sergiopr       New Issue                                    
05-23-06 10:25 sergiopr       File Added: buginfo.tar.bz2                    
05-23-06 10:25 sergiopr       Kernel Version            =>
kernel-2.6.16-1.2111_FC5
05-23-06 18:29 Raymond        Note Added: 0009944                          
05-26-06 10:38 sergiopr       Note Added: 0009974                          
05-26-06 14:45 tiwai          Status                   new => resolved     
05-26-06 14:45 tiwai          Resolution               open => not an issue
05-26-06 14:45 tiwai          Assigned To               => tiwai           
05-26-06 14:45 tiwai          Note Added: 0009976                          
======================================================================
