From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001014]: card detect function is never called in pxa2xx-ac97
Date: Tue, 29 Mar 2005 16:25:38 +0200
Message-ID: <0d9669c62d9d4c5b2361c4d376a8a3e9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 097A0FE
	for <alsa-devel@alsa-project.org>; Tue, 29 Mar 2005 16:25:38 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1014> 
======================================================================
Reported By:                twinsen
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1014
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               custom: PXA255/uClibc
Kernel Version:             2.6.11.5
======================================================================
Date Submitted:             03-25-2005 00:04 CET
Last Modified:              03-29-2005 16:25 CEST
======================================================================
Summary:                    card detect function is never called in pxa2xx-ac97
Description: 
Hi there,
I have a some problem with this driver. The environment:
ALSA source: alsa-driver-1.0.9rc1
Kernel source: linux-2.6.11.5 (stock)

I cross compiled the kernel and the alsa source for arm target with a 
toolchain from handhelds.org. I used the following configure command
line:

./configure --with-cards=pxa2xx-ac97 
--with-kernel=/home/twinsen/EmbeddedLinux/Kernel/linux-2.6.11.5 
--with-build=/home/twinsen/EmbeddedLinux/Kernel/linux-2.6.11.5 
--with-cross=/usr/local/arm/3.3.2/bin/arm-linux-

config runs without problems, when running make gcc complains about
"pci_dev_present" being redefined (alsa-driver-1.0.9rc1/include/adriver.h,
orig: include/linux/pci.h), but compiles ok. 

The problem:
I loaded all modules (snd, snd-timer, snd-page-alloc, snd-pcm,
snd-ac97-codec, snd-pxa2xx-pcm, snd-pxa2xx-ac97) but still no soundcard in
/proc/asound/cards.
I looked a bit inside the driver, and when snd-pxa2xx-ac97 is loaded, the
module init function registers the new driver:
driver_register(&pxa2xx_ac97_driver);

The driver struct contains a probe function:
.probe          = pxa2xx_ac97_probe,
but it's never called, so the driver doesn't even check the existance of
the sound card. Why is that? Did I srcew up the cross compiling?
Thanks:
	George
======================================================================

----------------------------------------------------------------------
 tiwai - 03-29-05 16:25 
----------------------------------------------------------------------
No certain idea.  It should be called from platform_bus...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-25-05 00:04 twinsen        New Issue                                    
03-25-05 00:04 twinsen        Distribution              => custom: PXA255/uClibc
03-25-05 00:04 twinsen        Kernel Version            => 2.6.11.5        
03-29-05 16:25 tiwai          Note Added: 0004247                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
