From: Jean Delvare <khali@linux-fr.org>
Subject: Re: 2.6.12-rc1-mm3, sound card lost id
Date: Sat, 26 Mar 2005 11:19:45 +0100
Message-ID: <20050326111945.5eb58343.khali__39123.1487425559$1111832527$gmane$org@linux-fr.org>
References: <20050325002154.335c6b0b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received: from mallaury.noc.nerim.net (smtp-106-saturday.noc.nerim.net [62.4.17.106])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 8A12D22D
	for <alsa-devel@alsa-project.org>; Sat, 26 Mar 2005 11:19:46 +0100 (MET)
In-Reply-To: <20050325002154.335c6b0b.akpm@osdl.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc1/2.6.12-rc1-mm3/
> (...)
>  bk-alsa.patch

This one made /proc/asound/card0/id change from "Live" to "Unknown" on
one of my systems, preventing alsatcl from properly restoring my mixer
settings.

I guess this wasn't exactly expected?

00:0d.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 06)
        Subsystem: Creative Labs CT4832 SBLive! Value
        Flags: bus master, medium devsel, latency 48, IRQ 5
        I/O ports at 8800 [size=32]

Class:     0401
Device:    1102:0002
Subsystem: 1102:8027

Thanks,
-- 
Jean Delvare


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
