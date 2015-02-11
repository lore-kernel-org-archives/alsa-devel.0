From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/8] ALSA: control: obsolete switch
 statement with const value table
Date: Wed, 11 Feb 2015 11:51:49 +0100
Message-ID: <54DB3445.1050100@metafoo.de>
References: <1423651052-19593-1-git-send-email-o-takashi@sakamocchi.jp>
 <1423651052-19593-3-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-161.synserver.de (smtp-out-161.synserver.de
 [212.40.185.161])
 by alsa0.perex.cz (Postfix) with ESMTP id 86E4E26058D
 for <alsa-devel@alsa-project.org>; Wed, 11 Feb 2015 11:51:49 +0100 (CET)
In-Reply-To: <1423651052-19593-3-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 02/11/2015 11:37 AM, Takashi Sakamoto wrote:
> To check parameters from userspace, snd_ctl_elem_add() has switch
> statement. This statement checks the number of values in a control and
> the size of each value. These two parameters are limited by
> struct snd_ctl_elem_value.value and can be replaced with two sets of two
> dimension array with constant values, without any calculation.
>
> This commit obsolete the switch statement with the array.
>
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---
>   sound/core/control.c | 57 +++++++++++++++++++++++++---------------------------
>   1 file changed, 27 insertions(+), 30 deletions(-)
>
> diff --git a/sound/core/control.c b/sound/core/control.c
> index ea49abc..f248bde 100644
> --- a/sound/core/control.c
> +++ b/sound/core/control.c
> @@ -1161,6 +1161,23 @@ static void snd_ctl_elem_user_free(struct snd_kcontrol *kcontrol)
>   static int snd_ctl_elem_add(struct snd_ctl_file *file,
>   			    struct snd_ctl_elem_info *info, int replace)
>   {
> +	/* The capacity of struct snd_ctl_elem_value.value.*/
> +	const unsigned int value_sizes[] = {
> +		[SNDRV_CTL_ELEM_TYPE_BOOLEAN]	= sizeof(long),
> +		[SNDRV_CTL_ELEM_TYPE_INTEGER]	= sizeof(long),
> +		[SNDRV_CTL_ELEM_TYPE_ENUMERATED] = sizeof(unsigned int),
> +		[SNDRV_CTL_ELEM_TYPE_BYTES]	= sizeof(unsigned char),
> +		[SNDRV_CTL_ELEM_TYPE_IEC958]	= sizeof(struct snd_aes_iec958),
> +		[SNDRV_CTL_ELEM_TYPE_INTEGER64] = sizeof(long long),
> +	};
> +	const unsigned int max_value_counts[] = {
> +		[SNDRV_CTL_ELEM_TYPE_BOOLEAN]	= 128,
> +		[SNDRV_CTL_ELEM_TYPE_INTEGER]	= 128,
> +		[SNDRV_CTL_ELEM_TYPE_ENUMERATED] = 128,
> +		[SNDRV_CTL_ELEM_TYPE_BYTES]	= 512,
> +		[SNDRV_CTL_ELEM_TYPE_IEC958]	= 1,
> +		[SNDRV_CTL_ELEM_TYPE_INTEGER64] = 64,
> +	};

The tables should probably be static, no need to put them on the stack.
