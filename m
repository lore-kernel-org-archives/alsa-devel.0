From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH] ASoC: rt5640: add ASRC support
Date: Mon, 30 Jun 2014 06:09:53 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D75C87F7@RTITMBSV03.realtek.com.tw>
References: <1403866691-5031-1-git-send-email-bardliao@realtek.com>
 <53AD7A1A.2090501@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id D270126166B
 for <alsa-devel@alsa-project.org>; Mon, 30 Jun 2014 08:10:01 +0200 (CEST)
In-Reply-To: <53AD7A1A.2090501@metafoo.de>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Lars-Peter Clausen [mailto:lars@metafoo.de]
> Sent: Friday, June 27, 2014 10:05 PM
> To: Bard Liao; broonie@kernel.org; lgirdwood@gmail.com
> Cc: Oder Chiou; alsa-devel@alsa-project.org; Flove
> Subject: Re: [alsa-devel] [PATCH] ASoC: rt5640: add ASRC support
> 
> 
> I wonder if that shouldn't be something that is automatically
> enabled/disabled based on the samplerates involved. Also for
> enable/disable controls use a switch control rather than a enum.

To turn on/off rt5640's ASRC function is not decided by only one
condition. To make it flexible, I prefer to use a control to enable/
disable ASRC function.
Do you mean SOC_SINGLE_EXT? I didn't find a _SWITCH control
in soc.h

> 
> - Lars
> 
> ------Please consider the environment before printing this e-mail.
