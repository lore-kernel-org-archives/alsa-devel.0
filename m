From: Francisco Moraes <fmoraes@nc.rr.com>
Subject: Re: [PATCH] remove AC97 existing control
Date: Thu, 24 Mar 2005 08:24:03 -0500
Message-ID: <4242BF73.1040704@nc.rr.com>
References: <cecf51cf0059.cf0059cecf51@southeast.rr.com> <s5hd5tqquhu.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <s5hd5tqquhu.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

>At Tue, 22 Mar 2005 07:45:15 -0500,
>fmoraes@nc.rr.com wrote:
>  
>
>>This patch should fix bug report 752 by removing the existing control from the AC97.
>>
>>
>>Sign off: Francisco Moraes
>>    
>>
>
>Right now I created a patch to prevent SPDIF controls on ac97 for
>drivers which are known to work without AC97 spdif (conflicting with
>the native SPDIF support).
>
>The patch is below.  I guess this will do the same job as this patch.
>Could you check whether it works?
>  
>

I tested the patch and it works on my system, but I don't have the AC97 
problem, so I cannot confirm that it does fixes the problem, although it 
looks like from the changes. Also, the ca0106 driver has the same exact 
code.

Francisco



-------------------------------------------------------
This SF.net email is sponsored by Microsoft Mobile & Embedded DevCon 2005
Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
Embedded(r) & Windows Mobile(tm) platforms, applications & content.  Register
by 3/29 & save $300 http://ads.osdn.com/?ad_id=6883&alloc_id=15149&op=click
