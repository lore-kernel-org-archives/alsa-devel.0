From: Arthur Marsh <arthur.marsh@internode.on.net>
Subject: Re: lock-up when loading desktop
Date: Tue, 14 Oct 2014 16:54:08 +1030
Message-ID: <543CC188.9050401@internode.on.net>
References: <543B2438.1050002@internode.on.net>	<s5ha950zeyi.wl-tiwai@suse.de>	<543BB942.5060602@internode.on.net>	<s5h7g04ywgg.wl-tiwai@suse.de>	<543BCDE9.7010308@internode.on.net>	<s5h38asyrld.wl-tiwai@suse.de>	<543C153A.4060607@internode.on.net>	<s5hk343y9ew.wl-tiwai@suse.de>
 <s5hfvery8nt.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ipmail05.adl6.internode.on.net (ipmail05.adl6.internode.on.net
 [150.101.137.143])
 by alsa0.perex.cz (Postfix) with ESMTP id D38B42604A2
 for <alsa-devel@alsa-project.org>; Tue, 14 Oct 2014 08:24:13 +0200 (CEST)
In-Reply-To: <s5hfvery8nt.wl-tiwai@suse.de>
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



Takashi Iwai wrote, on 14/10/14 07:44:

>>> had a similar lock-up (see second photo)
>>
>> I looked at the relevant code now, and this indeed seems like a
>> deadlock.  But it's nothing new, the code is a decade old.  I wonder
>> why it appears out of sudden.  Maybe the change of the spin lock path
>> triggers.
>>
>> The patch below is the fix, just removing the superfluous spinlock.

After applying *both*:

---
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 85fe1a216225..bfe1cf6b492f 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -818,7 +818,7 @@ static int snd_pcm_action_group(struct action_ops *ops,
  		/* unlock streams */
  		snd_pcm_group_for_each_entry(s1, substream) {
  			if (s1 != substream) {
-				if (s->pcm->nonatomic)
+				if (s1->pcm->nonatomic)
  					mutex_unlock(&s1->self_group.mutex);
  				else
  					spin_unlock(&s1->self_group.lock);

and the patch to pcm_native.c below:

>
> Also below is another thing I spotted now, but this is likely
> irrelevant from the lockup, supposedly.  In anyway, try this one
> together with the previous patch, too.
>
>
> Takashi
>
> ---
> diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
> index 85fe1a216225..bfe1cf6b492f 100644
> --- a/sound/core/pcm_native.c
> +++ b/sound/core/pcm_native.c
> @@ -818,7 +818,7 @@ static int snd_pcm_action_group(struct action_ops *ops,
>   		/* unlock streams */
>   		snd_pcm_group_for_each_entry(s1, substream) {
>   			if (s1 != substream) {
> -				if (s->pcm->nonatomic)
> +				if (s1->pcm->nonatomic)
>   					mutex_unlock(&s1->self_group.mutex);
>   				else
>   					spin_unlock(&s1->self_group.lock);
>

against current Linus git head,

I can run alsa-info.sh successfully and launch the desktop and play 
sounds generally (tested with MIDI and running aplay somefile.wav)

Thank you very much for the patches!

Regards,

Arthur.
