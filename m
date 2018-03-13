From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ALSA: pcm: Use krealloc() for resizing the
	rules array
Date: Tue, 13 Mar 2018 23:17:56 +0900
Message-ID: <62b420c2-3401-6b2d-7adf-a39728762ea7@sakamocchi.jp>
References: <20180313114210.12434-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 1FAB7267172
 for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2018 15:18:00 +0100 (CET)
In-Reply-To: <20180313114210.12434-1-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Mar 13 2018 20:42, Takashi Iwai wrote:
> Just a minor simplification.  Change from kcalloc() shouldn't matter
> as each array element is fully initialized.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>   sound/core/pcm_lib.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)

I think this is a good simplification and preferable, too. Some local 
variables in this block could be replaced by assignment but for 
readability it's better to keep them as is, in my opinion.

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

> diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
> index a83152e7d387..f4a19509cccf 100644
> --- a/sound/core/pcm_lib.c
> +++ b/sound/core/pcm_lib.c
> @@ -1129,16 +1129,12 @@ int snd_pcm_hw_rule_add(struct snd_pcm_runtime *runtime, unsigned int cond,
>   	if (constrs->rules_num >= constrs->rules_all) {
>   		struct snd_pcm_hw_rule *new;
>   		unsigned int new_rules = constrs->rules_all + 16;
> -		new = kcalloc(new_rules, sizeof(*c), GFP_KERNEL);
> +		new = krealloc(constrs->rules, new_rules * sizeof(*c),
> +			       GFP_KERNEL);
>   		if (!new) {
>   			va_end(args);
>   			return -ENOMEM;
>   		}
> -		if (constrs->rules) {
> -			memcpy(new, constrs->rules,
> -			       constrs->rules_num * sizeof(*c));
> -			kfree(constrs->rules);
> -		}
>   		constrs->rules = new;
>   		constrs->rules_all = new_rules;
>   	}

Regards

Takashi Sakamoto
