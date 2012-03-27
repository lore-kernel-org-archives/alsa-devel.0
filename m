From: Omair Mohammed Abdullah <omair.m.abdullah@linux.intel.com>
Subject: Re: [PATCH] ASoC: Added PCM short and long frame sync
	formats
Date: Tue, 27 Mar 2012 09:04:18 +0530
Message-ID: <4F71353A.9020704@linux.intel.com>
References: <20120326133305.GR3098@opensource.wolfsonmicro.com>
	<1332819135-5416-1-git-send-email-omair.m.abdullah@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 80A43104135
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Mar 2012 05:31:58 +0200 (CEST)
In-Reply-To: <1332819135-5416-1-git-send-email-omair.m.abdullah@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Omair Mohammed Abdullah <omair.m.abdullah@linux.intel.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Tuesday 27 March 2012 09:02 AM, Omair Mohammed Abdullah wrote:
> The PCM short frame sync sends a short (1 clock length) sync signal before the
> MSB of data. The PCM long frame sync sends a 1 word length sync signal along
> with the data.
>
> Signed-off-by: Omair Mohammed Abdullah<omair.m.abdullah@linux.intel.com>
> ---
>   include/sound/soc-dai.h |    2 ++
>   1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
> index c429f24..dc94b25 100644
> --- a/include/sound/soc-dai.h
> +++ b/include/sound/soc-dai.h
> @@ -32,6 +32,8 @@ struct snd_soc_dapm_widget;
>   #define SND_SOC_DAIFMT_DSP_B		5 /* L data MSB during FRM LRC */
>   #define SND_SOC_DAIFMT_AC97		6 /* AC97 */
>   #define SND_SOC_DAIFMT_PDM		7 /* Pulse density modulation */
> +#define SND_SOC_DAIFMT_SHORT_SYNC	8 /* FRM for 1 clock before MSB */
> +#define SND_SOC_DAIFMT_LONG_SYNC	9 /* FRM for 1 word starting with MSB */
>
>   /* left and right justified also known as MSB and LSB respectively */
>   #define SND_SOC_DAIFMT_MSB		SND_SOC_DAIFMT_LEFT_J

What I am looking for is something like this. But 
SND_SOC_DAIFMT_SHORT_SYNC might be the same as SND_SOC_DAIFMT_DSP_A.
