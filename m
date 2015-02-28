From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 7/7] ALSA: hda - Reduce verbs during
 generic parser initialization
Date: Sat, 28 Feb 2015 10:51:29 +0100
Message-ID: <54F18FA1.40002@metafoo.de>
References: <1425072502-3204-1-git-send-email-tiwai@suse.de>
 <1425072502-3204-8-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-061.synserver.de (smtp-out-061.synserver.de
 [212.40.185.61])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E9772602AD
 for <alsa-devel@alsa-project.org>; Sat, 28 Feb 2015 10:51:29 +0100 (CET)
In-Reply-To: <1425072502-3204-8-git-send-email-tiwai@suse.de>
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

On 02/27/2015 10:28 PM, Takashi Iwai wrote:
> For reducing the number of verbs performed during the initialization
> and the resume of the generic parser, this patch (re-)introduces the
> mechanism to cache everything in init and sync later.
>
> However, it became a bit tricky in the end: we can't use regcache's
> cache_only flag straightforwardly here because we do want the actual
> hardware access for reads if needed, but forbids only the writes.
> So, instead, the regmap reg_write callback checks the own flag
> (reusing the existing codec->cached_write) and skips the actual
> access.  This works by assumption of regmap dumping the whole
> registers via regcache_sync() at a later point.
>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>   sound/pci/hda/hda_generic.c | 4 ++++
>   sound/pci/hda/hda_regmap.c  | 6 ++++++
>   2 files changed, 10 insertions(+)
>
> diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
> index 33de31c83d6e..bcaed93f8795 100644
> --- a/sound/pci/hda/hda_generic.c
> +++ b/sound/pci/hda/hda_generic.c
> @@ -5411,6 +5411,8 @@ int snd_hda_gen_init(struct hda_codec *codec)
>
>   	snd_hda_apply_verbs(codec);
>
> +	codec->cached_write = 1;
> +

How about using regcache_cache_only(), this handles this internally in 
regmap and will also make sure that the cache gets marked as dirty so that a 
regcache_sync() will properly write out the dirty registers.

>   	init_multi_out(codec);
>   	init_extra_out(codec);
>   	init_multi_io(codec);
[...]
>
