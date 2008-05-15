From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: Re: Kernel crashes for unsupported sample rates
Date: Thu, 15 May 2008 18:09:21 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB022256EFD5@dbde02.ent.ti.com>
References: <s5hzlqrrbul.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C70B24799
	for <alsa-devel@alsa-project.org>;
	Thu, 15 May 2008 14:39:30 +0200 (CEST)
In-Reply-To: <s5hzlqrrbul.wl%tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Can you point me to any particular git tree which I can download and apply the patches directly, instead of committing any silly mistake? It would be really helpful.

Thanks and Regards,
Anuj Aggarwal

Platform Support Products
Texas Instruments Inc
Ph: +91-80-2509-9542
TI IP Ph: 509-9542
PSP Products RSS Feed PSP Product Announcements


-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de]
Sent: Thursday, May 15, 2008 5:58 PM
To: Aggarwal, Anuj
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] Kernel crashes for unsupported sample rates

At Thu, 15 May 2008 16:40:52 +0530,
Aggarwal, Anuj wrote:
>
> It gave me the following error:
>
> bash-3.00$ patch -p 1 < audio_patch
> (Stripping trailing CRs from patch.)
> patching file include/sound/memalloc.h
> Hunk #1 succeeded at 62 with fuzz 1.
> Hunk #2 FAILED at 87.
> 1 out of 2 hunks FAILED -- saving rejects to file include/sound/memalloc.h.rej
> (Stripping trailing CRs from patch.)
> patching file include/sound/pcm.h
> patch: **** malformed patch at line 60: @@ -306,6 +306,126 @@ int snd_pcm_lib_preallocate_pages_for_all(struct snd_pcm *pcm,
>
>
> I think I have to apply the patch manually. Is there any other way to do that?

No.  Please fix it manually.


Takashi
