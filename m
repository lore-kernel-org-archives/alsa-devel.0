From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000635]: Unknown symbol snd_verbode_printk, MC'97 0 converters and GPIO not ready (0x1)
Date: Tue, 22 Mar 2005 15:07:33 +0100
Message-ID: <0b18414c5bdda0120ebc46a6f4f97a40@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 05E5128B
	for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2005 15:07:33 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=635> 
======================================================================
Reported By:                betak
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   635
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               Fedora Core 2
Kernel Version:             2.6.9
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             11-07-2004 21:41 CET
Last Modified:              03-22-2005 15:07 CET
======================================================================
Summary:                    Unknown symbol snd_verbode_printk, MC'97 0
converters and GPIO not ready (0x1)
Description: 
I tried to install kernel-2.6.9 with alsa-driver-1.0.7rc2. I use Fedora
Core 2  on my Fujitsu - Siemens Lifebook C1020 ( technical dokumentation -
see http://212.52.234.17/index.cfm?fuseaction=dspcontent&lid=11&page=2 )
When I try to load module snd_via82xx first , I am not able to load second
modul - snd_via82xx. I recieve following message "Unknown symbol
snd_verbode_printk" and modul is not loded.
But when I tried to load sdn_via82xx_modem  first, then I recieve
following message "MC'97 0 converters and GPIO not ready (0x1)".
Snd_via82xx_modem is loaded , but I am not able to setup them.
Any useful information from my system are attached.
Can you help me to setup this modem driver  ? How can I create /dev/modem
... ?

======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0000634 Unknown symbol snd_verbode_printk, MC'9...
======================================================================

----------------------------------------------------------------------
 betak - 11-09-04 20:12 
----------------------------------------------------------------------
cd /usr/src
tar xvjf alsa-driver-1.0.7rc2.tar.bz2
./configure --with-kernel=/mnt/hda14/usr.src.hda17/linux-2.6.9
make
make install
./snddevices

less /proc/config.gz attached

----------------------------------------------------------------------
 jdthood - 03-19-05 12:57 
----------------------------------------------------------------------
This is merged with a resolved issue.  It should also be marked "resolved".

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-07-04 21:41 betak          New Issue                                    
11-07-04 21:41 betak          File Added: alsa.txt                         
11-07-04 21:41 betak          Distribution              => Fedora Core 2   
11-07-04 21:41 betak          Kernel Version            => 2.6.9           
11-09-04 18:28 tiwai          Relationship added       has duplicate 0000634
11-09-04 18:37 tiwai          Note Added: 0002331                          
11-09-04 20:12 betak          Note Added: 0002350                          
11-09-04 20:13 betak          File Added: proc.config.gx                    
03-19-05 12:57 jdthood        Note Added: 0004043                          
03-22-05 15:07 jdthood        Status                   new => resolved     
03-22-05 15:07 jdthood        Resolution               open => fixed       
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
