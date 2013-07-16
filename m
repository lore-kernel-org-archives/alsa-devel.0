From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 0/10] snd_pcm_stop() lock fixes
Date: Tue, 16 Jul 2013 17:57:28 +0200
Message-ID: <51E56D68.2020206@metafoo.de>
References: <1373893582-17116-1-git-send-email-tiwai@suse.de>
 <51E3F527.60801@perex.cz> <s5h61wcynax.wl%tiwai@suse.de>
 <s5h8v16wogt.wl%tiwai@suse.de> <51E55E96.1040305@metafoo.de>
 <s5h4nbuwnfc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-238.synserver.de (smtp-out-238.synserver.de
 [212.40.185.238])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B6F02650B8
 for <alsa-devel@alsa-project.org>; Tue, 16 Jul 2013 17:56:47 +0200 (CEST)
In-Reply-To: <s5h4nbuwnfc.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 07/16/2013 05:10 PM, Takashi Iwai wrote:
> At Tue, 16 Jul 2013 16:54:14 +0200,
> Lars-Peter Clausen wrote:
>>
>> On 07/16/2013 04:48 PM, Takashi Iwai wrote:
>> [...]
>>> +int snd_pcm_lock_and_stop(struct snd_pcm_substream *substream, snd_pcm_state_t state)
>>
>> The name makes it sound as if the lock will still be held after the function
>> call has completed.
> 
> Yeah, I agree with my bad sense of naming...
> 
>> How about snd_pcm_stop_locked()?
> 
> Hrm, it's also unclear whether it's called in a locked context or it
> does lock by itself.

Hm, I always thought that ..._locked() was mainly used for functions that
take the lock, but a quick grep revealed that both meanings are used and
it's split about 50/50 :/

- Lars
