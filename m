From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH alsa-lib] ioplug: Fix comment in struct
	snd_pcm_ioplug
Date: Tue, 2 Oct 2018 08:33:19 +0900
Message-ID: <3137f7c9-34cb-7f4d-134b-ccefbb1d9ed4@sakamocchi.jp>
References: <20180928213335.16430-1-andre.guedes@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
 [209.85.210.196])
 by alsa0.perex.cz (Postfix) with ESMTP id EE3982676A7
 for <alsa-devel@alsa-project.org>; Tue,  2 Oct 2018 01:33:22 +0200 (CEST)
Received: by mail-pf1-f196.google.com with SMTP id s5-v6so74024pfj.7
 for <alsa-devel@alsa-project.org>; Mon, 01 Oct 2018 16:33:22 -0700 (PDT)
In-Reply-To: <20180928213335.16430-1-andre.guedes@intel.com>
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
To: Andre Guedes <andre.guedes@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Sep 29 2018 06:33, Andre Guedes wrote:
> This patch fixes the comment about 'pcm' field in 'struct
> snd_pcm_ioplug' which wrongly refers to snd_pcm_extplug_create().
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>   include/pcm_ioplug.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

> diff --git a/include/pcm_ioplug.h b/include/pcm_ioplug.h
> index b16fc8b8..81ac8613 100644
> --- a/include/pcm_ioplug.h
> +++ b/include/pcm_ioplug.h
> @@ -105,7 +105,7 @@ struct snd_pcm_ioplug {
>   	 */
>   	void *private_data;
>   	/**
> -	 * PCM handle filled by #snd_pcm_extplug_create()
> +	 * PCM handle filled by #snd_pcm_ioplug_create()
>   	 */
>   	snd_pcm_t *pcm;


Thanks

Takashi Sakamoto
