From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v6] ASoC: add RT286 CODEC driver
Date: Mon, 12 May 2014 16:51:53 +0200
Message-ID: <5370E009.5070503@metafoo.de>
References: <536B2C9D.9040807@metafoo.de>
 <20140508080025.GA12304@sirena.org.uk> <536B4708.8080203@metafoo.de>
 <CAFOFQBaoYpXCfroxfZX+7yf-ua71dav5kfUytyJLzUs_FCMg8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-016.synserver.de (smtp-out-079.synserver.de
 [212.40.185.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 87613265050
 for <alsa-devel@alsa-project.org>; Mon, 12 May 2014 16:51:55 +0200 (CEST)
In-Reply-To: <CAFOFQBaoYpXCfroxfZX+7yf-ua71dav5kfUytyJLzUs_FCMg8g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao.rtk@gmail.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Gustaw Lewandowski <gustaw.lewandowski@intel.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

On 05/12/2014 01:08 PM, Bard Liao wrote:
> 2014-05-08 16:57 GMT+08:00 Lars-Peter Clausen <lars@metafoo.de>:
>> On 05/08/2014 10:00 AM, Mark Brown wrote:
>
> [...]
>
> Just for confirm.
>  From the mail thread, what I need to to are:
> 1. Don't present register map to alsa, use virtrul controls instead.
>     I may need to extend the APIs to accomplish the goal.

To avoid confusion we should not call them virtual controls, but controls 
with custom put/get handlers.

> 2. I can (or should?) use regmap internal to codec driver to set the
> codec physically.
> Did I miss anything?

There are essentially two options.

a) Have custom put/get handlers for different types of verbs. This means 
you'll re-implement things like caching.

b) Have a mapping that maps the hierarchical HDA register addressing 
structure onto a linear address map and use regmap.

- Lars
