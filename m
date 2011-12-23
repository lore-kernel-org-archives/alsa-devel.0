From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: Allocate PCM operations dynamically
 to	support multiple DAIs
Date: Fri, 23 Dec 2011 12:36:15 +0100
Message-ID: <4EF467AF.6070603@metafoo.de>
References: <1324599996-19661-1-git-send-email-sbkim73@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-168.synserver.de (smtp-out-168.synserver.de
	[212.40.185.168])
	by alsa0.perex.cz (Postfix) with SMTP id E6742103FA5
	for <alsa-devel@alsa-project.org>; Fri, 23 Dec 2011 12:35:33 +0100 (CET)
In-Reply-To: <1324599996-19661-1-git-send-email-sbkim73@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sangbeom Kim <sbkim73@samsung.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, Sangsu Park <sangsu4u.park@samsung.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On 12/23/2011 01:26 AM, Sangbeom Kim wrote:
> From: Sangsu Park <sangsu4u.park@samsung.com>
> 
> The original code does not cover the case that two DAIs(CPU) have different
> ASoC core PCM operations(like mmap, pointer...). Currently we have only one
> global soc_pcm_ops for ASoC core PCM operation. When two DAIs have different
> pointer functions, second DAI's pointer function is set for both first DAI
> and second DAI in case of original code.
> 
> This patch allocates ASoC core PCM operations dynamically for each DAIs. So
> each DAIs can have different ASoC core PCM operations. This is needed to
> support multiple DAIs.
> 
> Signed-off-by: Sangsu Park <sangsu4u.park@samsung.com>
> Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
> ---
>  sound/core/pcm.c    |    1 +
>  sound/soc/soc-pcm.c |   44 ++++++++++++++++++++++++--------------------
>  2 files changed, 25 insertions(+), 20 deletions(-)
> 
> diff --git a/sound/core/pcm.c b/sound/core/pcm.c
> index 8928ca8..15cf27a 100644
> --- a/sound/core/pcm.c
> +++ b/sound/core/pcm.c
> @@ -769,6 +769,7 @@ static void snd_pcm_free_stream(struct snd_pcm_str * pstr)
>  		substream_next = substream->next;
>  		snd_pcm_timer_done(substream);
>  		snd_pcm_substream_proc_done(substream);
> +		kfree(substream->ops);

This looks wrong. It will probably cause regression for all non ASoC sound
card drivers.

The issue this patch addresses came up before and I think the conclusion was
that it is best to embed the snd_pcm_ops struct into the snd_soc_pcm_runtime
struct.
