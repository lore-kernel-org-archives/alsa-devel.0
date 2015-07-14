From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH v2 1/3] ASoC: rt5645: Simplify
	rt5645_enable_push_button_irq
Date: Tue, 14 Jul 2015 09:48:08 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D70108A8EC@RTITMBSV03.realtek.com.tw>
References: <1436856687-31550-1-git-send-email-drinkcat@chromium.org>
 <1436856687-31550-2-git-send-email-drinkcat@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id BC505260525
 for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2015 11:48:16 +0200 (CEST)
In-Reply-To: <1436856687-31550-2-git-send-email-drinkcat@chromium.org>
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
To: Nicolas Boichat <drinkcat@chromium.org>, Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, "koro.chen@mediatek.com" <koro.chen@mediatek.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Nicolas Boichat [mailto:drinkcat@chromium.org]
> Sent: Tuesday, July 14, 2015 2:51 PM
> To: Mark Brown
> Cc: Bard Liao; Oder Chiou; Liam Girdwood; Jaroslav Kysela; Takashi Iwai;
> alsa-devel@alsa-project.org; koro.chen@mediatek.com
> Subject: [PATCH v2 1/3] ASoC: rt5645: Simplify
> rt5645_enable_push_button_irq
> 
> LDO2/Mic Det Power pins are already enabled/disabled in
> rt5645_jack_detect (the jack out code path previously did not disable
> those: modify it to make it so).
> 
> Also, provide an alternative if dapm is not ready yet.
> 
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>

Acked-by: Bard Liao <bardliao@realtek.com>
