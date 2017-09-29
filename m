From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] seq: fix snd_seq_set_queue_tempo() usage
 example in the documentation
Date: Fri, 29 Sep 2017 11:04:25 +0900
Message-ID: <9dce17bf-11f0-d2c9-8285-f5d4cd13d86d@sakamocchi.jp>
References: <20170928134615.20712-1-ao2@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id E544F26737C
 for <alsa-devel@alsa-project.org>; Fri, 29 Sep 2017 04:04:28 +0200 (CEST)
In-Reply-To: <20170928134615.20712-1-ao2@ao2.it>
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Sep 28 2017 22:46, Antonio Ospite wrote:
> snd_seq_set_queue_tempo() requires a queue id as the second argument,
> fix the example in documentation to reflect that.
> 
> Also add the queue id as an argument of the set_tempo() function, just
> to keep the whole example compilable.
> 
> Signed-off-by: Antonio Ospite <ao2@ao2.it>
> ---
>   src/seq/seq.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/src/seq/seq.c b/src/seq/seq.c
> index d5ed1c6a..808c7915 100644
> --- a/src/seq/seq.c
> +++ b/src/seq/seq.c
> @@ -452,13 +452,13 @@ For setting these tempo parameters, use #snd_seq_queue_tempo_t record.
>   For example, to set the tempo of the queue <code>q</code> to
>   48 PPQ, 60 BPM,
>   \code
> -void set_tempo(snd_seq_t *handle)
> +void set_tempo(snd_seq_t *handle, int queue)
>   {
>           snd_seq_queue_tempo_t *tempo;
>           snd_seq_queue_tempo_alloca(&tempo);
>           snd_seq_queue_tempo_set_tempo(tempo, 1000000); // 60 BPM
>           snd_seq_queue_tempo_set_ppq(tempo, 48); // 48 PPQ
> -        snd_seq_set_queue_tempo(handle, tempo);
> +        snd_seq_set_queue_tempo(handle, queue, tempo);
>   }
>   \endcode

This looks good catch for documentation.

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

Unfortunately, a maintainer of this subsystem is absent this week. Your 
patch is going to put into merge queue after he's back. It may takes a 
bit longer.


Thanks

Takashi Sakamoto
