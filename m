From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH] ASoC: rt5651: remove unexisting widget
Date: Thu, 28 Apr 2016 09:08:13 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D70114F8BE@RTITMBSV03.realtek.com.tw>
References: <1461809581-7863-1-git-send-email-bardliao@realtek.com>
 <5721C67F.2080007@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E6942661B9
 for <alsa-devel@alsa-project.org>; Thu, 28 Apr 2016 11:08:23 +0200 (CEST)
In-Reply-To: <5721C67F.2080007@metafoo.de>
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
To: Lars-Peter Clausen <lars@metafoo.de>, "broonie@kernel.org" <broonie@kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, John Lin <john.lin@realtek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> > -	/* IN Mux */
> > -	SND_SOC_DAPM_MUX("INL1 Mux", SND_SOC_NOPM, 0, 0,
> &rt5651_inl1_mux),
> > -	SND_SOC_DAPM_MUX("INR1 Mux", SND_SOC_NOPM, 0, 0,
> &rt5651_inr1_mux),
> > -	SND_SOC_DAPM_MUX("INL2 Mux", SND_SOC_NOPM, 0, 0,
> &rt5651_inl2_mux),
> > -	SND_SOC_DAPM_MUX("INR2 Mux", SND_SOC_NOPM, 0, 0,
> &rt5651_inr2_mux),
> 
> What is with the rt5651_in*_mux controls, those are unused now and
> can be removed as well, aren't they?

Thanks for the reminder. I will send v2 soon.

> 
> 
> ------Please consider the environment before printing this e-mail.
