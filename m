From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH v6] ASoC: add RT286 CODEC driver
Date: Wed, 4 Jun 2014 12:08:41 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D73DE932@RTITMBSV03.realtek.com.tw>
References: <536B4708.8080203@metafoo.de>
 <20140512202918.GG12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B1A4264EAA
 for <alsa-devel@alsa-project.org>; Wed,  4 Jun 2014 14:08:48 +0200 (CEST)
In-Reply-To: <20140512202918.GG12304@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Flove <flove@realtek.com>, Gustaw Lewandowski <gustaw.lewandowski@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Tuesday, May 13, 2014 4:29 AM
> To: Lars-Peter Clausen
> Cc: Bard Liao; lgirdwood@gmail.com; alsa-devel@alsa-project.org; Flove; Oder
> Chiou; Gustaw Lewandowski
> Subject: Re: [PATCH v6] ASoC: add RT286 CODEC driver
> 
> 
> > >If you really want to reuse regmap having a write only regmap
> > >internal to the driver (not presented to ASoC) which just remembers
> > >the last value written to every NID/VID combination might work and at
> > >least avoids the ugly bits with trying to convince ASoC there are
> > >registers since you don't need to worry about reading the data back
> > >and can just pretend that read values match written values since we
> > >never look at them except to write them back out.
> 
> > Yes kind of.
> 
> Kind of?  It solves the cache sync case and if it's write only then we won't need to
> go to the register map for reads anyway (outside of interrupt handling and so on).

Does "write only regmap" mean read (almost) everything from cache? If so, we
don't need to care about the asymmetry read/write issue. In that case, can we
use regmap for mixer/mux controls just like other drivers do?


> 
> ------Please consider the environment before printing this e-mail.
