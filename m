From: Takashi Sakamoto <mocchi.sakamoto113@gmail.com>
Subject: Re: [PATCH - Intervals v2 1/1] interval: Interpret (x
 x+1] correctly and return x+1
Date: Thu, 18 Oct 2018 23:45:53 +0900 (JST)
Message-ID: <alpine.DEB.2.21.1810182339530.3374@laptop>
References: <1539862404-21955-1-git-send-email-twischer@de.adit-jv.com>
 <s5hbm7rv4wf.wl-tiwai@suse.de>
 <81531fd0-2173-c274-5279-a48fdfdf5121@de.adit-jv.com>
 <s5hr2gntmt0.wl-tiwai@suse.de>
 <4fb00512-47f2-4a1f-b434-ccec896355e9@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 08CFC26751A
 for <alsa-devel@alsa-project.org>; Thu, 18 Oct 2018 16:46:01 +0200 (CEST)
Received: by mail-pg1-f176.google.com with SMTP id i4-v6so14288554pgq.9
 for <alsa-devel@alsa-project.org>; Thu, 18 Oct 2018 07:46:01 -0700 (PDT)
In-Reply-To: <4fb00512-47f2-4a1f-b434-ccec896355e9@de.adit-jv.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timo Wischer <twischer@de.adit-jv.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Thu, 18 Oct 2018, Timo Wischer wrote:
> The reason for this fix was an issue where an interval of (x x+1] is 
> interpreted as not a single value.
> Before the change in snd_interval_single() the following intervals were 
> interpreted as a single value:
>
> * (x x) -> required for rounding issues e.g. 32ms * 22,05 kHz = 705,6
>   frames => (705 706)
> * (x x]
> * [x x)
> * [x x]
> * (x x+1)
> * [x x+1)
>
> With this change (x x+1] will also be interpreted as a single value (which 
> looks reasonable for me).
> But the interval [x x+1] is still not interpreted as a single value (which 
> also sounds right for me)
>
> Before the change in snd_interval_value() for all intervals x was returned.
> With this change only in case (x x+1] x+1 will be returned. All other 
> intervals are not changed.
>
> Therefore this is a minimal change which solves issues. I have already at 
> least two use cases which
> are failing without this fix. (Somehow simple use cases with rate->dmix->hw 
> where the hw truncates
> the default period_time of 125ms and fails with EINVAL on 
> snd_pcm_set_period_near()).
> Therefore I would expect that these issues will be seen soon by other users.
>
> If there is a use case which breaks in future due to the right interpretation 
> of (x x+1] I think we should try
> to find the root cause why this (x x+1] interval has to be interpreted 
> wrongly to get the use case to work.

'struct snd_interval' has 'integer' flag. When this flag is off,
'(x, x + 1]' brings no single unique value. The inline function
'snd_interval_single()' should handle this case correctly.


Thanks

Takashi Sakamoto (@airport)
