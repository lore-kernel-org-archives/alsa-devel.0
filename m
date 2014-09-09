From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: Master Plan on rewinding
Date: Tue, 09 Sep 2014 14:55:42 +0600
Message-ID: <540EC08E.4000906@gmail.com>
References: <540C76E0.9050808@gmail.com>
 <540CC53B.7080204@ladisch.de>	<540D5B46.3020904@gmail.com>
 <540EBD9A.9000009@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f169.google.com (mail-lb0-f169.google.com
 [209.85.217.169])
 by alsa0.perex.cz (Postfix) with ESMTP id BDC6F2615BF
 for <alsa-devel@alsa-project.org>; Tue,  9 Sep 2014 10:55:44 +0200 (CEST)
Received: by mail-lb0-f169.google.com with SMTP id p9so7512049lbv.0
 for <alsa-devel@alsa-project.org>; Tue, 09 Sep 2014 01:55:44 -0700 (PDT)
In-Reply-To: <540EBD9A.9000009@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, David Henningsson <david.henningsson@canonical.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

09.09.2014 14:43, Clemens Ladisch wrote:
> Alexander E. Patrakov wrote:
>> |---------|---------P----h----p---------|-a-------|---------|
>>
>> So, what should alsa-lib return for snd_pcm_avail() and snd_pcm_rewind()?
>> The driver only knows that "P" is already used, can infer that "p" isn't
>> used yet, and knows nothing about samples in the middle.
> Indeed.  However, the DMA pointer moves asynchronously, so it is possible
> that it has already moved beyond p when snd_pcm_rewindable() returns.
> For the samples between P and p, the risk is larger than for those after
> p, but p is not a boundary where the risk abruptly decreases.
>
> It would make sense to report the pointer update granularity, but not
> to adjust the return value of snd_pcm_avail/rewindable().

OK, I understand your viewpoint, and the phrase "some indicator of the 
actual rewind granularity and/or safeguard ... should be enough for PA 
to be able to pick a suitable default latency" from David indicates that 
he has a similar opinion.

Now the remaining question is: can the proposed heuristic (minimum 
period size for a given sample rate, number of channels and sample 
format) be useful as an upper-bound approximation of the pointer update 
granularity for cards that are "rewindable even further than the nearest 
period"?

-- 
Alexander E. Patrakov
