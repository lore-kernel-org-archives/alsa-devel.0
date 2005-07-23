From: Adrian Bunk <bunk@stusta.de>
Subject: Device supported by the OSS trident driver not supported by ALSA
Date: Sat, 23 Jul 2005 22:04:17 +0200
Message-ID: <20050723200417.GI3160@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailout.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 2BD76178
	for <alsa-devel@alsa-project.org>; Sat, 23 Jul 2005 22:04:24 +0200 (MEST)
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: perex@suse.cz, mulix@mulix.org
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Alan Cox <alan@redhat.com>
List-Id: alsa-devel@alsa-project.org


I'm currently creating a list of OSS drivers where all the hardware 
supported by them is also supported by ALSA. The goal is to schedule 
them for removal (except someone tells that for one or more of them ALSA 
support is inferior).


The OSS trident driver has 5 different pci_device_id entries.

For 4 of them there seems to be similar ALSA support, but I can't find 
any ALSA equivalent for the following entry:
        {PCI_VENDOR_ID_INTERG, PCI_DEVICE_ID_INTERG_5050,
         PCI_ANY_ID, PCI_ANY_ID, 0, 0, CYBER5050},

Can anyone tell my why this device is supported by the OSS trident 
driver but not by ALSA?


TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
