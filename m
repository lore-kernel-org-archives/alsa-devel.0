From: John Hsu <KCHSU0@nuvoton.com>
Subject: Re: [PATCH] ASoC: nau8825: fix issue that pop noise
	when start capture
Date: Fri, 15 Dec 2017 15:16:55 +0800
Message-ID: <5A3376E7.2080602@nuvoton.com>
References: <1513019426-9623-1-git-send-email-abhijeet.kumar@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3165F266BF5
 for <alsa-devel@alsa-project.org>; Fri, 15 Dec 2017 08:17:00 +0100 (CET)
In-Reply-To: <1513019426-9623-1-git-send-email-abhijeet.kumar@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: abhijeet.kumar@intel.com
Cc: alsa-devel@alsa-project.org, cychiang@google.com, anatol.pomozov@gmail.com, WTLI@nuvoton.com, linux-kernel@vger.kernel.org, wuchengli@google.com, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, YHCHuang@nuvoton.com, mac.chiang@intel.com, Mark Brown <broonie@kernel.org>, CTLIN0@nuvoton.com, Bhumika Goyal <bhumirks@gmail.com>, mhkuo@nuvoton.com
List-Id: alsa-devel@alsa-project.org

On 12/12/2017 3:10 AM, abhijeet.kumar@intel.com wrote:
> From: Abhijeet Kumar <abhijeet.kumar@intel.com>
>
> In skylake platform, we hear a loud pop noise(0 dB) at start of
> audio capture power up sequence. This patch removes the pop noise
> from the recording by adding a delay before enabling ADC.
>
> Signed-off-by: Abhijeet Kumar <abhijeet.kumar@intel.com>
> ---
>  sound/soc/codecs/nau8825.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
> index 714ce17da717..e853a6dfd33b 100644
> --- a/sound/soc/codecs/nau8825.c
> +++ b/sound/soc/codecs/nau8825.c
> @@ -905,6 +905,7 @@ static int nau8825_adc_event(struct snd_soc_dapm_widget *w,
>
>       switch (event) {
>       case SND_SOC_DAPM_POST_PMU:
> +             msleep(125);
>               regmap_update_bits(nau8825->regmap, NAU8825_REG_ENA_CTRL,
>                       NAU8825_ENABLE_ADC, NAU8825_ENABLE_ADC);
>               break;

The solution is fine for me. It's verified in my device and indeed
helps to reduce the capture pop noise. I think the little delay
is acceptable.



===========================================================================================
The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Nuvoton is strictly prohibited; and any information in this email irrelevant to the official business of Nuvoton shall be deemed as neither given nor endorsed by Nuvoton.
