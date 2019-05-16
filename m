From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH v2 6/6] pcm: Update pcm->avail_min with
 needed_slave_avail_min, after reading unaligned frames
Date: Thu, 16 May 2019 19:35:28 +0200
Message-ID: <e959837a-bdf3-75cd-11bc-41cda842fb50@perex.cz>
References: <1557901597-19215-1-git-send-email-vanitha.channaiah@in.bosch.com>
 <1557901597-19215-7-git-send-email-vanitha.channaiah@in.bosch.com>
 <s5hk1erhgx2.wl-tiwai@suse.de>
 <293476c61233469cbffdd5a7688a8879@in.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CCA75F806E7
 for <alsa-devel@alsa-project.org>; Thu, 16 May 2019 19:35:33 +0200 (CEST)
In-Reply-To: <293476c61233469cbffdd5a7688a8879@in.bosch.com>
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
To: "Channaiah Vanitha (RBEI/ECF3)" <Vanitha.Channaiah@in.bosch.com>, Takashi Iwai <tiwai@suse.de>
Cc: "Wischer Timo (ADITG/ESS)" <twischer@de.adit-jv.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Dne 16. 05. 19 v 19:26 Channaiah Vanitha (RBEI/ECF3) napsal(a):
> Hello  Takashi-san,
> 
>>  Can we avoid adding such a hack in the core code?
>>  Basically the issue is very specific to direct-plugins, so this sort of workaround should be implemented locally there instead.  I guess we can do similar tricks by overriding the calls in the callbacks.
> 
> Issue can be seen without direct plugins too with involvement of only hw which reports unaligned hw ptr. As I have explained in below  detailed description:
> "Also, this issue can be seen without dsnoop plugin, when HW reports unaligned hw_ptr For e.g. "

Which hardware exactly? The hw_ptr should be reset when the streaming starts.
It appears that the problem is specific to the direct plugins only when the
period wakeups are a bit different than for the direct hardware access.

						Jaroslav


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
