From: Timo Wischer <twischer@de.adit-jv.com>
Subject: Re: [PATCH - dmix v3 0/1] pcm: dmix: Align
 slave_hw_ptr to slave period boundary
Date: Tue, 6 Nov 2018 17:15:31 +0100
Message-ID: <04f0ef9b-fc3b-f268-6e74-cd1f07758163@de.adit-jv.com>
References: <bdf2f9ca-7ff1-40cb-271d-4a83b32ccf56@de.adit-jv.com>
 <s5hpnviz3gh.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
 by alsa0.perex.cz (Postfix) with ESMTP id 880132678F2
 for <alsa-devel@alsa-project.org>; Tue,  6 Nov 2018 17:15:38 +0100 (CET)
In-Reply-To: <s5hpnviz3gh.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Laxmi Devi <Laxmi.Devi@in.bosch.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 11/6/18 15:27, Takashi Iwai wrote:
> I guess that the biggest issue is the understanding of PCM period
> wakeup; let me cite the description of a part of your patch:
>
>   "But since 3 snd_pcm_period_elapsed(), 3 periods should be available
>    and it should have been able to write.
>    If rsnd_pointer during the start was 0x120 which is 3 periods
>    then 0x248 - 0x120 =  128 it could go on with write."
>
> This assumption can't be applied.
>
> However, the current implementation of dmix is designed to achieve the
> lowest latency by putting the data at the exact position being played
> back now.  This, of course, doesn't guarantee the period wakeup = one
> period free to fill like the above.  So it's the design choice.
>
> The current code has a workaround for the case of nperiods <= 2, by
> setting the initial slave_appl_ptr to the next period start.  This
> guarantees that the period wakeup = one period to be filled.  But its
> cost is the start latency; the playback doesn't start immediately but
> wait until the next period start.
>
>
> Takashi

Thanks for this explanation. That helps me to understand.

Now, I am thinking about a solution to align the slave_hw_ptr and 
slave_appl_ptr to the slave_period (round down) only on start up.
So we keep this low latency. (At start up it is the same behavior as 
known from old sound drivers)

As known from the past in worst case it will drop up to slave_period-1 
frames.
If the application uses big periods and the drop is not acceptable a 
small slave_period using the var_period feature could be configured.
But I think it is also not acceptable for an application which is using 
really big periods to wait sometimes one period longer.

There is always a higher probability of an under run whenever a poll() 
wakeup will not result in a write.
For example on systems with high load this could be an issue.

If you are anyway not happy with this solution may be we can think about 
an option to disable this feature
like "min_drop_on_start true"
But then we also should describe the drawbacks of this option like
* Delay of snd_pcm_wait() up to 2*periods
* Higher probability of Xruns


Best regards

Timo
