From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH v3] ASoC: rt286: fix headphone click/crack
	noise on Dell XPS 9343 I2S mode
Date: Tue, 21 Mar 2017 03:07:25 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D701C4E587@RTITEXTEMP.realtek.com.tw>
References: <20170320035831.10762-1-kai.heng.feng@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 50F92266F51
 for <alsa-devel@alsa-project.org>; Tue, 21 Mar 2017 04:07:30 +0100 (CET)
In-Reply-To: <20170320035831.10762-1-kai.heng.feng@canonical.com>
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>, "broonie@kernel.org" <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Kai-Heng Feng [mailto:kai.heng.feng@canonical.com]
> Sent: Monday, March 20, 2017 11:59 AM
> To: broonie@kernel.org
> Cc: lgirdwood@gmail.com; Bard Liao; Oder Chiou;
> alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org; Kai-Heng Feng
> Subject: [PATCH v3] ASoC: rt286: fix headphone click/crack noise on Dell XPS
> 9343 I2S mode
> 
> +	switch (event) {
> +	case SND_SOC_DAPM_PRE_PMD:
> +	case SND_SOC_DAPM_POST_PMD:
> +	case SND_SOC_DAPM_POST_PMU:
> +		snd_soc_write(codec, RT286_SET_AMP_GAIN_HPO,
> AMP_OUT_MUTE);
> +		break;
> +	case SND_SOC_DAPM_PRE_PMU:
> +		snd_soc_write(codec, RT286_SET_AMP_GAIN_HPO,
> AMP_OUT_UNMUTE);
> +		break;

Besides Mark's comment, I have question here. It seems you want to mute
HPO before "HP Power" is powered up and after "HP Power" is powered down.
But "HPO L" and "HPO R" are autodisable. And "HP Power" is only connect to
"HPO L" and "HPO R". From my understanding, HPO will mute if "HP Power"
is powered down. Any specific reason for muting HPO again before "HP Power"
is powered up? Will HPO be unmuted before "HP Power" is powered up on your
system? Or should the event be associated with "LDO1"? Which power will
cause the click noise?
