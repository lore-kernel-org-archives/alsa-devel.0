From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Device supported by the OSS trident driver not supported by
 ALSA
Date: Mon, 25 Jul 2005 00:42:49 +0100
Message-ID: <1122248569.10835.22.camel@localhost.localdomain>
References: <20050723200417.GI3160@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A14741BA
	for <alsa-devel@alsa-project.org>; Mon, 25 Jul 2005 01:18:02 +0200 (MEST)
Received: from localhost.localdomain (unknown [81.2.110.250])
	by gate.perex.cz (Perex's E-mail Delivery System) with ESMTP id DB6478450D
	for <alsa-devel@alsa-project.org>; Mon, 25 Jul 2005 01:18:01 +0200 (MEST)
In-Reply-To: <20050723200417.GI3160@stusta.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adrian Bunk <bunk@stusta.de>
Cc: perex@suse.cz, mulix@mulix.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Alan Cox <alan@redhat.com>
List-Id: alsa-devel@alsa-project.org

On Sad, 2005-07-23 at 22:04 +0200, Adrian Bunk wrote:
> The OSS trident driver has 5 different pci_device_id entries.
> 
> For 4 of them there seems to be similar ALSA support, but I can't find 
> any ALSA equivalent for the following entry:
>         {PCI_VENDOR_ID_INTERG, PCI_DEVICE_ID_INTERG_5050,
>          PCI_ANY_ID, PCI_ANY_ID, 0, 0, CYBER5050},
> 
> Can anyone tell my why this device is supported by the OSS trident 
> driver but not by ALSA?

The OSS driver supports the CyberPro T-squared core integrated into the
cyberpro chipset while the ALSA driver only supports the others. Should
be easy for someone to resolve. I don't have any 5000 hardware to test
it however.

Alan



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
