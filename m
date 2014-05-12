From: Bard Liao <bardliao.rtk@gmail.com>
Subject: Re: [PATCH v6] ASoC: add RT286 CODEC driver
Date: Mon, 12 May 2014 19:08:40 +0800
Message-ID: <CAFOFQBaoYpXCfroxfZX+7yf-ua71dav5kfUytyJLzUs_FCMg8g@mail.gmail.com>
References: <536B2C9D.9040807@metafoo.de>
 <20140508080025.GA12304@sirena.org.uk>
 <536B4708.8080203@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f178.google.com (mail-wi0-f178.google.com
 [209.85.212.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 91881264F45
 for <alsa-devel@alsa-project.org>; Mon, 12 May 2014 13:08:40 +0200 (CEST)
Received: by mail-wi0-f178.google.com with SMTP id hm4so4250760wib.5
 for <alsa-devel@alsa-project.org>; Mon, 12 May 2014 04:08:40 -0700 (PDT)
In-Reply-To: <536B4708.8080203@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Gustaw Lewandowski <gustaw.lewandowski@intel.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

2014-05-08 16:57 GMT+08:00 Lars-Peter Clausen <lars@metafoo.de>:
> On 05/08/2014 10:00 AM, Mark Brown wrote:

[...]

Just for confirm.
>From the mail thread, what I need to to are:
1. Don't present register map to alsa, use virtrul controls instead.
   I may need to extend the APIs to accomplish the goal.
2. I can (or should?) use regmap internal to codec driver to set the
codec physically.
Did I miss anything?

Thanks.

>
> ------Please consider the environment before printing this e-mail.
