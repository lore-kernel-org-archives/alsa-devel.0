From: Adrian Bunk <bunk@stusta.de>
Subject: 2.6: sound/isa/gus/gus_lfo.c is unused (fwd)
Date: Sun, 6 Mar 2005 23:41:59 +0100
Message-ID: <20050306224159.GQ5070@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from mailout.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 3D9DE170
	for <alsa-devel@alsa-project.org>; Sun,  6 Mar 2005 23:42:00 +0100 (MET)
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
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Jaroslav,

I didn't receive any answer regarding this question.

Any comments or shall I send a patch to remove this file?

cu
Adrian


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Wed, 24 Nov 2004 23:07:42 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: 2.6: sound/isa/gus/gus_lfo.c is unused

Hi Jaroslav,

in kernel 2.6 (I've checked 2.6.10-rc2-mm3), the file 
sound/isa/gus/gus_lfo.c is completely unused (it's never built, and all 
code using it in other files is #if 0'ed).

What's the status of this file?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
