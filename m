From: Adrian Bunk <bunk@stusta.de>
Subject: 2.6: sound/isa/gus/gus_lfo.c is unused
Date: Wed, 24 Nov 2004 23:07:42 +0100
Message-ID: <20041124220742.GL19873__31052.2246677012$1101396969$gmane$org@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailout.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 7D04829D
	for <alsa-devel@alsa-project.org>; Wed, 24 Nov 2004 23:07:46 +0100 (MET)
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



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
