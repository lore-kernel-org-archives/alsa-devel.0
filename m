From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH v3 1/6] ASoC: fsl_ssi: Real hardware
 channels max number is 32
Date: Mon, 18 Jan 2016 09:46:07 -0600
Message-ID: <569D08BF.7000008@tabi.org>
References: <1453130771-24419-1-git-send-email-arnaud.mouiche@invoxia.com>
 <1453130771-24419-2-git-send-email-arnaud.mouiche@invoxia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by alsa0.perex.cz (Postfix) with ESMTP id E3D45260534
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2016 16:46:10 +0100 (CET)
In-Reply-To: <1453130771-24419-2-git-send-email-arnaud.mouiche@invoxia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Mouiche <arnaud.mouiche@invoxia.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Caleb Crome <caleb@crome.org>
List-Id: alsa-devel@alsa-project.org

Arnaud Mouiche wrote:
> The max number of slots in TDM mode is 32:
> - Frame Rate Divider Control is a 5bit value
> - Time slot mask registers control 32 slots.
>
> Signed-off-by: Arnaud Mouiche<arnaud.mouiche@invoxia.com>
> ---
>   sound/soc/fsl/fsl_ssi.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index 40dfd8a..cfc78b8 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -1167,14 +1167,14 @@ static struct snd_soc_dai_driver fsl_ssi_dai_template = {
>   	.playback = {
>   		.stream_name = "CPU-Playback",
>   		.channels_min = 1,
> -		.channels_max = 2,
> +		.channels_max = 32,

TDM mode is not normally used.  What happens if we're not in TDM mode, 
and the user tries to start a stream with more than 2 channels?
