From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH] ASoC: rt5677: Add a configuration
	optionforLDO2_POW pin
Date: Thu, 18 Sep 2014 02:03:04 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D76335F4@RTITMBSV03.realtek.com.tw>
References: <201409180125.s8I1Phwp020498@rtits1.realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id C7B2E2610B0
 for <alsa-devel@alsa-project.org>; Thu, 18 Sep 2014 04:03:18 +0200 (CEST)
In-Reply-To: <201409180125.s8I1Phwp020498@rtits1.realtek.com>
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
To: Anatol Pomozov <anatol.pomozov@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: alsa-devel-bounces@alsa-project.org
> [mailto:alsa-devel-bounces@alsa-project.org] On Behalf Of Anatol
> Pomozov
> Sent: Thursday, September 18, 2014 4:14 AM
> To: broonie@kernel.org; lgirdwood@gmail.com
> Cc: Oder Chiou; alsa-devel@alsa-project.org; Anatol Pomozov
> Subject: [alsa-devel] [PATCH] ASoC: rt5677: Add a configuration option
> forLDO2_POW pin
> 
> Some boards have this pin statically tied and do not require any
> configuration, some other boards allow to enable chip using GPIO.
> 
> Add an option that tells which GPIO is used to power the audio codec.
> 
> Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
> ---

Acked-by: Bard Liao <bardliao@realtek.com>

Thanks.

> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
