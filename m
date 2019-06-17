From: "Channaiah Vanitha (RBEI/ECF3)" <Vanitha.Channaiah@in.bosch.com>
Subject: Re: [PATCH v2 6/6] pcm: Update pcm->avail_min with
 needed_slave_avail_min, after reading unaligned frames
Date: Mon, 17 Jun 2019 23:15:08 +0000
Message-ID: <d7190437121644a78802ea69893e2b3a@in.bosch.com>
References: <1557901597-19215-1-git-send-email-vanitha.channaiah@in.bosch.com>
 <1557901597-19215-7-git-send-email-vanitha.channaiah@in.bosch.com>
 <s5hk1erhgx2.wl-tiwai@suse.de>
 <293476c61233469cbffdd5a7688a8879@in.bosch.com>
 <e959837a-bdf3-75cd-11bc-41cda842fb50@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de-out1.bosch-org.com (de-out1.bosch-org.com [139.15.230.186])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9CC22F8075C
 for <alsa-devel@alsa-project.org>; Tue, 18 Jun 2019 01:15:12 +0200 (CEST)
In-Reply-To: <e959837a-bdf3-75cd-11bc-41cda842fb50@perex.cz>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: "Wischer Timo (ADITG/ESS)" <twischer@de.adit-jv.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello Jaroslav-san, Takashi-san,

> Which hardware exactly? The hw_ptr should be reset when the streaming starts.
> It appears that the problem is specific to the direct plugins only when the period wakeups are a bit different than for the direct hardware access.

Firstly, sorry for late reply.

Issue is seen in RCar Kingfischer H3 es2.0 target.

The issue was seen during the below commit :
commit 07b7acb51d283d8469696c906b91f1882696a4d4
("ASoC: rsnd: update pointer more accurate")
https://patchwork.kernel.org/patch/9772671/


There could be a non-uniform jitter exists between when interrupt raised [rcar_dmac_isr_channel(), rcar_dmac_isr_channel_thread()]
and the interrupt is processed to read/calculate the DMA position [dma_set_residue()]
This could result in unaligned hw_ptr reported at user-space alsa lib.


Best regards,
Vanitha Channaiah
RBEI/ECF3

Tel. +91 80 6136-4436


-----Original Message-----
From: Jaroslav Kysela <perex@perex.cz>
Sent: Thursday, May 16, 2019 11:05 PM
To: Channaiah Vanitha (RBEI/ECF3) <Vanitha.Channaiah@in.bosch.com>; Takashi Iwai <tiwai@suse.de>
Cc: Wischer Timo (ADITG/ESS) <twischer@de.adit-jv.com>; alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] [PATCH v2 6/6] pcm: Update pcm->avail_min with needed_slave_avail_min, after reading unaligned frames

Dne 16. 05. 19 v 19:26 Channaiah Vanitha (RBEI/ECF3) napsal(a):
> Hello  Takashi-san,
>
>>  Can we avoid adding such a hack in the core code?
>>  Basically the issue is very specific to direct-plugins, so this sort of workaround should be implemented locally there instead.  I guess we can do similar tricks by overriding the calls in the callbacks.
>
> Issue can be seen without direct plugins too with involvement of only hw which reports unaligned hw ptr. As I have explained in below  detailed description:
> "Also, this issue can be seen without dsnoop plugin, when HW reports unaligned hw_ptr For e.g. "

Which hardware exactly? The hw_ptr should be reset when the streaming starts.
It appears that the problem is specific to the direct plugins only when the period wakeups are a bit different than for the direct hardware access.

                                                Jaroslav


--
Jaroslav Kysela <perex@perex.cz<mailto:perex@perex.cz>>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
