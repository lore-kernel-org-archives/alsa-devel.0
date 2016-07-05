From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH] ASoC: rt5645: disable soft volume control
Date: Tue, 5 Jul 2016 08:44:03 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D701177611@RTITMBSV03.realtek.com.tw>
References: <1467696235-31566-1-git-send-email-bardliao@realtek.com>
 <20160705083422.GN6247@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E60B265325
 for <alsa-devel@alsa-project.org>; Tue,  5 Jul 2016 10:44:08 +0200 (CEST)
In-Reply-To: <20160705083422.GN6247@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, Jack Yu <jack.yu@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "koro.chen@mediatek.com" <koro.chen@mediatek.com>, "PC.Liao@mediatek.com" <PC.Liao@mediatek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Tuesday, July 05, 2016 4:34 PM
> To: Bard Liao
> Cc: lgirdwood@gmail.com; alsa-devel@alsa-project.org;
> lars@metafoo.de; Flove; Oder Chiou; Jack Yu; koro.chen@mediatek.com;
> PC.Liao@mediatek.com
> Subject: Re: [PATCH] ASoC: rt5645: disable soft volume control
> 
> On Tue, Jul 05, 2016 at 01:23:55PM +0800, Bard Liao wrote:
> > With soft volume control function, rt5645/rt5650 will start with 0dB
> > volume and take a little time to adjust volume to given value. And it
> > will cause a bad user experience. This patch disable it.
> 
> This seems like something that it'd be better to give users control over
> - some users will be annoyed by a soft ramp but there will be others who
> welcome it.

Good idea. I will do it.

> 
> ------Please consider the environment before printing this e-mail.
